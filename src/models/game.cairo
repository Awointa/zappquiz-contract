use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
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
