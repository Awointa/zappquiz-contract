use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
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