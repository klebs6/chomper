our role ImplTraitType::Rules {

    rule impl-trait-type {
        <kw-impl>
        <type-param-bounds>
    }

    rule impl-trait-type-one-bound {
        <kw-impl>
        <trait-bound>
    }
}
