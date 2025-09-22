#[cfg(test)]
mod tests {
    use dojo::world::{WorldStorage, WorldStorageTrait};
    use dojo_cairo_test::{spawn_test_world, NamespaceDef, TestResource, ContractDefTrait, ContractDef, WorldStorageTestTrait};
    use starknet::testing::{set_caller_address, set_block_number, set_block_timestamp};
    use starknet::contract_address_const;
    use starknet::ContractAddress;
    use zappquiz_contract::systems::gameFactorySystem::gameFactorySystem;
    use zappquiz_contract::interfaces::IGameFactorySystem::{IGameFactorySystemDispatcher, IGameFactorySystemDispatcherTrait};

    use zappquiz_contract::models::game::{Game, GamesByHost, m_Game, m_GamesByHost};

    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    // use zappquiz_contract::systems::gameFactorySystem::gameFactorySystem::GameCreated;

     fn TOKEN_ADDRESS() -> ContractAddress { contract_address_const::<0x789>() }

    fn namespace_def() -> NamespaceDef {
        let ndef = NamespaceDef {
            namespace: "zappquiz_contract",
            resources: [
                TestResource::Model(m_Game::TEST_CLASS_HASH),
                TestResource::Model(m_GamesByHost::TEST_CLASS_HASH),
                TestResource::Event(gameFactorySystem::e_GameCreated::TEST_CLASS_HASH),
                TestResource::Contract(gameFactorySystem::TEST_CLASS_HASH), 
                
            ].span()
        };
        ndef
    }

    fn contract_defs() -> Span<ContractDef> {
        [
            ContractDefTrait::new(@"zappquiz_contract", @"gameFactorySystem")
                .with_writer_of([dojo::utils::bytearray_hash(@"zappquiz_contract")].span())
        ].span()
    }

    pub fn setup() -> WorldStorage {
        let ndef = namespace_def();
        let mut world: WorldStorage = spawn_test_world([ndef].span());
        world.sync_perms_and_inits(contract_defs());
        world
    }

    #[test]
    fn test_create_game() {
        let mut world = setup();

        let (contract_address, _) = world.dns(@"gameFactorySystem").unwrap();
        let game_factory_system = IGameFactorySystemDispatcher { contract_address };

        let host = contract_address_const::<'Host'>();

        let game_id = game_factory_system.create_game(host, 12345, 4);

        let game = game_factory_system.get_game(game_id);

        
        assert!(host == game.host, "Host address should match");
        assert!(12345 == game.title_hash, "Title hash should match");
        assert!(4 == game.max_players, "Max players should match");
        assert!(0 == game.prize_pool, "Initial prize pool should be zero");
        assert!(!game.is_finalized, "Game should not be finalized");
    }

    #[test]
    fn test_fund_game() {
        let mut world = setup();
    
        let (contract_address, _) = world.dns(@"gameFactorySystem").unwrap();
        let game_factory_system = IGameFactorySystemDispatcher { contract_address };
    
        
        let host = contract_address_const::<'Host'>();

        let game_id = game_factory_system.create_game(host, 12345, 4);

        // set_caller_address(host);

        game_factory_system.fund_game(game_id, TOKEN_ADDRESS(), 10000000000000000000
        );

        let funded_game = game_factory_system.get_game(game_id);

        assert!(funded_game.prize_pool == 10000000000000000000, "Prize pool should be updated");

    }
}
