#[dojo::contract]
pub mod gameFactorySystem {
    use starknet::{ContractAddress, get_block_timestamp, get_caller_address, contract_address_const, get_contract_address};
    use dojo::event::EventStorage;
    use dojo::model::{ModelStorage};
    use zappquiz_contract::models::game::{Game, GamesByHost};
    use openzeppelin::access::accesscontrol::{AccessControlComponent, DEFAULT_ADMIN_ROLE};
    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    use zappquiz_contract::interfaces::IGameFactorySystem::{IGameFactorySystem};

    #[derive(Clone, Drop, Serde, Debug)]
    #[dojo::event]
    pub struct GameCreated {
        #[key]
        pub game_id: u64,
        pub host: ContractAddress,
        pub prize_pool: u256,
        pub max_players: u32,
    }

    #[derive(Clone, Drop, Serde, Debug)]
    #[dojo::event]
    pub struct GameFunded {
        #[key]
        pub game_id: u64,
        pub sponsor: ContractAddress,
        pub amount: u256,
    }

    #[abi(embed_v0)]
    impl IGameFactorySystemImpl of IGameFactorySystem<ContractState> {
        fn create_game(ref self: ContractState, host: ContractAddress, title_hash: felt252, max_players: u32) -> u64 {
            let mut world = self.world_default();

            let game_id = get_block_timestamp();

            let game = Game{
                game_id,
                host,
                title_hash,
                prize_pool: 0,
                max_players,
                is_finalized: false,
                created_at: get_block_timestamp(),
            };
            
            world.write_model(@game);

            let record = GamesByHost {
                host,
                game_id,
                created_at: get_block_timestamp(),
            };

            world.write_model(@record);

            world.emit_event(@GameCreated {
                game_id,
                host,
                prize_pool: 0,
                max_players,
            });

            game_id
        }

        fn get_game(self: @ContractState, game_id: u64) -> Game {
           let mut game = self._get_game(game_id);
           game
        }

        fn fund_game(ref self: ContractState, game_id: u64, token_address:ContractAddress, amount: u256){
            let mut world = self.world_default();
            let sponsor = get_caller_address();
            let mut game : Game = self._get_game(game_id);
            let zappquiz_contract_address = get_contract_address();

            assert!(game.host != contract_address_const::<0>(), "Game does not exist");
            assert!(game.is_finalized == false, "Game is already finalized");          

            let token = IERC20Dispatcher{contract_address:token_address};
            let user_token_balance = token.balance_of(sponsor); 
            assert!(user_token_balance >= amount, "Insufficient token balance");

            token.transfer_from(sponsor, zappquiz_contract_address, amount);

            game.prize_pool += amount;
            
            world.write_model(@game);

            world.emit_event(@GameFunded {
                game_id,
                sponsor: sponsor,
                amount,});
            
        }  
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage  {
            self.world(@"zappquiz_contract")
        }

        fn _get_game(self: @ContractState, game_id: u64) -> Game {
            let world = self.world_default();
            let game : Game = world.read_model(game_id);
            game
        }
    }
}