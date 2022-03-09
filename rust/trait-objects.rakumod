our role TraitObjectType::Rules {

    rule trait-object-type {
        <kw-dyn>? 
        <type-param-bounds>
    }

    rule trait-object-type-one-bound {
        <kw-dyn>?
        <trait-bound>
    }
}
