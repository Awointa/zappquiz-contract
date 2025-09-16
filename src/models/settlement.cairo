use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
#[dojo::model]
pub struct Game{
    #[key]
    pub game_id: felt252,
    pub host: ContractAddress,
    pub title_hash: felt252,
    pub prize_pool: u252,
    pub entry_fee: u252,
    pub max_players: u32,
    pub is_finalized: bool,
    pub created_at: u64
}