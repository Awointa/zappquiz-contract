#[derive(Drop,starknet::Event)]
pub struct GameCreated {
    pub game_id: felt252,
    pub host: ContractAddress,
    pub prize_pool: u256,
    pub max_players: u32,
}

#[derive(Drop,starknet::Event)]
pub struct GameFinalized {
    pub game_id: felt252,
    pub total_players: u32,
    pub total_prize: u256,
    pub winner_count: u32,
}

#[derive(Drop,starknet::Event)]
pub struct PrizesClaimed {
    pub game_id: felt252,
    pub total_players: u32,
    pub total_prize: u256,
    pub winner_count: u32,
}

#[derive(Drop,starknet::Event)]
pub struct GameFunded {
    pub game_id: felt252,
    pub sponsor: ContractAddress,
    pub amount: u256,
}
