#[cfg(test)]
mod tests {
    use dojo::model::{ModelStorage, ModelValueStorage, ModelStorageTest};
    use dojo::world::worldStorageTrait;
    use dojo_cairo_test::{spawn_test_world, NameSpaceDef, TestResource, ContractDefTrait};

    use zappquiz_contract::systems::game_factory_system::{gameFactorysystem, IGameFactorySystemDispatcher, IGameFactorySystemDispatcherTrait};   
    use zappquiz_contract::models::game::Game;

    fn namespace_def() -> NameSpaceDef {
        NameSpaceDef {
            namespace: "zappquiz_contract", resources: [
                TestResource::Model(m_Game::TEST_CLASS_HASH),
                TestResource::Event(gameFactorysystem::e_GameCreated::EVENT_CLASS_HASH),
                TestResource::Contract(gameFactorysystem::CONTRACT_CLASS_HASH),
            ].span()
        }
    }

    fn contract_defs() -> Span<ContractDef> {
        [
            ContractDefTrait::new(@"zappquiz_contract", @"gameFactorySystem").with_writer_of([dojo::utils::bytearray_hash(@"zappquiz_contract")].span())
        ].span()
    }
}
