pub mod systems {
    pub mod gameFactorySystem;
}

pub mod models{
    pub mod final_score;
    pub mod game_results;   
    pub mod game;
    pub mod platform_config;
    pub mod player_claim;
}

pub mod interfaces {
    pub mod IGameFactorySystem;
    pub mod IFinalSettlement;
}

pub mod events {
    pub mod game_events;
}

pub mod structs {
    pub mod helper_structs;
}

pub mod tests {
    #[cfg(test)]
    mod test_game_factory;
}
