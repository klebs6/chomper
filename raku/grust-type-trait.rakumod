our class TypeTraitItem {
    has $.maybe_outer_attrs;
    has $.ty_param;
}

our class TraitType::Rules {

    rule trait-type {
        <maybe-outer_attrs> <TYPE> <ty-param> ';'
    }
}

our class TraitType::Actions {

    method trait-type($/) {
        make TypeTraitItem.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            ty-param          =>  $<ty-param>.made,
        )
    }
}

