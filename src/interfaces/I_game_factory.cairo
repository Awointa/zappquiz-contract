#[dojo::interface]
pub trait IGameFactory<T> {
    fn create_game(ref self: T, host: ContractAddress, title_hash: felt252, max_players: u32) -> felt252;
    fn fund_game(ref self: T, game_id: felt252, amount: u256);

}