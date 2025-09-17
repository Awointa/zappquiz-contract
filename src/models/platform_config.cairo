






// platform Configuration 
#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct PlatformConfig {
    #[key]
    pub id: felt252,//Always 1 for singleton
    pub platform_fee_bps: u16, //Base points
    pub host_fee_bps: u16,
    pub min_prize_pool: u256,
    pub relayer_Address: ContractAddress,

}