#[derive(Copy, Drop, Serde)]
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