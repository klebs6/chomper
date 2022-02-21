our class ConstTraitItem {
    has $.maybe_ty_ascription;
    has $.maybe_const_default;
    has $.ident;
    has $.maybe_outer_attrs;
}

our class TraitConst::Rules {

    rule trait-const {
        <maybe-outer_attrs> <CONST> <ident> <maybe-ty_ascription> <maybe-const_default> ';'
    }
}

our class TraitConst::Actions {

    method trait-const($/) {
        make ConstTraitItem.new(
            maybe-outer_attrs   =>  $<maybe-outer_attrs>.made,
            ident               =>  $<ident>.made,
            maybe-ty_ascription =>  $<maybe-ty_ascription>.made,
            maybe-const_default =>  $<maybe-const_default>.made,
        )
    }
}

