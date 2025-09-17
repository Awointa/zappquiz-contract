#[derive(Drop, Copy)]
pub struct RewardTier {
    pub min_rank: u32,
    pub max_rank: u32,
    pub percentage: u16, // Basis points (e.g., 5000 = 50%)
}

// Standard reward tiers - can be customized per game
fn get_default_reward_tiers() -> Array<RewardTier> {
    let mut tiers = ArrayTrait::new();
    
    // Winner takes 50%
    tiers.append(RewardTier { min_rank: 1, max_rank: 1, percentage: 5000 });
    
    // 2nd place: 25%
    tiers.append(RewardTier { min_rank: 2, max_rank: 2, percentage: 2500 });
    
    // 3rd place: 15%
    tiers.append(RewardTier { min_rank: 3, max_rank: 3, percentage: 1500 });
    
    // 4th-10th: split remaining 10%
    tiers.append(RewardTier { min_rank: 4, max_rank: 10, percentage: 1000 });
    
    tiers
}