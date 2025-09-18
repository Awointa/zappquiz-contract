#[dojo::contract]
mod game_factory_system {
    use starknet::{ContractAddress};
    use dojo::model::WorldStorage;
    use dojo::event::EventStorage;
    use zappquiz_contract::interfaces::i_game_factory::IGameFactory;

    #[abi(embed_v0)]
    impl IGameFactoryImpl of IGameFactory<ContractState> {
        fn create_game(ref self: ContractState, host: ContractAddress, title_hash: felt252, max_players: u32) -> felt252 {
            
            
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage  {
            self.world(@"zappquiz_contract")
        }
    }
}