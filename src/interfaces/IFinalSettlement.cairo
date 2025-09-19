use starknet::ContractAddress;
use zappquiz_contract::structs::helper_structs::PlayerResult;

#[starknet::interface]
pub trait IFinalSettlement<T> {
   fn submit_final_score(ref self: T, game_id: felt252, players: Array<PlayerResult>, result_signature: felt252);
   fn claim_prize(ref self: T, game_id: felt252, player_id: felt252);
   fn batch_ditribute_prizes(ref self: T, game_id: felt252, recipients: Array<ContractAddress>, amounts: Array<u256>);
}