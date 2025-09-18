#[starknet::interface]
pub trait IFinalSettlement<TContractState> {
   fn submit_final_score(self ref: T, game_id: felt252, players: Array<PlayersResult>, result_signature: felt252);
   fn claim_prize(ref self: T, game_id: felt252, player_id: felt252);
   fn batch_ditribute_prizes(ref self: T, game_id: felt252, recipients: Array<ContractAddress>, amounts: Array<u256>);
}