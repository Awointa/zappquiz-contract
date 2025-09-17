use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
#[dojo::model]
pub struct Game{
    #[key]
    pub game_id: felt252,
    pub host: ContractAddress,
    pub title_hash: felt252,
    pub prize_pool: u256,
    pub entry_fee: u256,
    pub max_players: u32,
    pub is_finalized: bool,
    pub created_at: u64
}

#[derive(Model, Copy, Drop, Serde)]
#[dojo::model]
pub struct FinalScore {
    #[key]
    pub game_id: felt252,
    #[key]
    pub player_id: felt252,  // UUID hash
    pub username_hash: felt252,
    pub wallet_Address: ContractAddress,
    pub final_score: u32,
    pub rank: u32,
}

#[derive(Model, Copy, Drop, Serde)]
#[dojo::model]
pub struct GameResult {
    #[key]
    pub game_id: felt252,
    pub total_players:u32,
    pub winner_count:u32,
    pub total_prize_distributed: u256,
    pub results_hash: felt252, // hash of all final scores for verification 
    pub submitted_by: ContractAddress,
    pub submitted_at: u64,
}

#[derive(Model, Copy, Drop, Serde)]
#[dojo::model]
pub struct PlayerClaim {
    #[key]
    pub game_id: felt252,
    #[key]
    pub player_id: felt252,  // UUID hash
    pub prize_amount: u256,
    pub claimed: bool,
    pub claimed_at: u64,
}