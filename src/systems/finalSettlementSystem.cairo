#[dojo:contract]
mod finalSettlementSystem {
    use zappquiz_contract::models::game::Game;
    use zappquiz_contract::models::final_score::FinalScore;
    use zappquiz_contract::models::game_results::GameResults;
    use zappquiz_contract::models::player_claim::PlayerClaim;
    use zappquiz_contract::interfaces::IFinalSettlement::{IFinalSettlement};
    use zappquiz_contract::models::platform_config::PlatformConfig;
    use starknet::ContractAddress;
    use zappquiz_contract::structs::helper_structs::PlayerResult;


    #[abi(embed_v0)]
    impl FinalSettlementImpl of IFinalSettlement<ContractState> {
        
    }
}