#[derive(Drop, Serde)]
pub struct PlayerResult {
    pub player_id: felt252,
    pub username_hash: felt252,
    pub final_sore: u128,
}

