#[derive(Drop,starknet::Event)]
pub struct GameCreated {
    pub game_id: felt252,
    pub host: ContractAddress,
    pub prize_pool: u256,
    pub max_players: u32,
}