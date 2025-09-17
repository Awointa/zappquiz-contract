pub mod systems {
    pub mod actions;
}

pub mod models{
    pub mod final_score;
    pub mod player_claim;
    pub mod game_results;   
    pub mod game;
    pub mod platform_config;
    pub mod player_claim;
}

pub mod interface {
     pub IGameFactory;
     pub IFinalSettlement;
}

pub mod tests {
    mod test_world;
}
