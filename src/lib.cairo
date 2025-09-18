pub mod systems {
    pub mod game_factory_system;
}

pub mod models{
    pub mod final_score;
    pub mod game_results;   
    pub mod game;
    pub mod platform_config;
    pub mod player_claim;
}

pub mod interfaces {
     pub mod i_final_settlement{
        pub trait IFinalSettlement;
     }
     pub mod i_game_factory{
        pub trait IGameFactory;
     }
}

pub mod events {
    pub mod game_events;
}

pub mod tests {
    mod test_world;
}
