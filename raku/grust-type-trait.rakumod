our class TypeTraitItem {
    has $.maybe-outer-attrs;
    has $.ty-param;
}

our class TraitType::Rules {

    rule trait-type {
        <maybe-outer-attrs> <TYPE> <ty-param> ';'
    }
}

our class TraitType::Actions {

    method trait-type($/) {
        make TypeTraitItem.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            ty-param          =>  $<ty-param>.made,
        )
    }
}
