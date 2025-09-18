#[dojo::contract]
mod game_factory_system {
    use starknet::{ContractAddress, get_block_timestamp};
    use dojo::event::EventStorage;
    use dojo::model::{ModelStorage};
    use zappquiz_contract::models::game::Game;
    // use zappquiz_contract::events::game_events::{GameCreated};

    // interface 
    #[starknet::interface]
    trait IGameFactory<T> {
        fn create_game(ref self: T, host: ContractAddress, title_hash: felt252, max_players: u32) -> u64;
        fn fund_game(ref self: T, game_id: u64, amount: u256);

    }

    // Game Events 

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    pub struct GameCreated {
        #[key]
        pub game_id: u64,
        pub host: ContractAddress,
        pub prize_pool: u256,
        pub max_players: u32,
    }


    #[abi(embed_v0)]
    impl IGameFactoryImpl of IGameFactory<ContractState> {
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

            world.emit_event(@GameCreated {
                game_id,
                host,
                prize_pool: 0,
                max_players,
            });

            game_id
        }

        fn fund_game(ref self: ContractState, game_id: u64, amount: u256){}
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage  {
            self.world(@"zappquiz_contract")
        }
    }
}