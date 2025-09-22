use starknet::ContractAddress;
use zappquiz_contract::models::game::Game;

// interface 
#[starknet::interface]
pub trait IGameFactorySystem<T> {
    fn create_game(ref self: T, host: ContractAddress, title_hash: felt252, max_players: u32) -> u64;
    fn fund_game(ref self: T, game_id: u64, token_address:ContractAddress, amount: u256);

    // Query Methods
    fn get_game(self: @T, game_id: u64) -> Game;

}