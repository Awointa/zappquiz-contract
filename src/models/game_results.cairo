use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
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