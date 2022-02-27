our class ConstTraitItem {
    has $.maybe-ty-ascription;
    has $.maybe-const-default;
    has $.ident;
    has $.maybe-outer-attrs;
}

our class TraitConst::Rules {

    rule trait-const {
        <maybe-outer-attrs> 
        <CONST> 
        <ident> 
        <maybe-ty-ascription> 
        <maybe-const-default> 
        ';'
    }
}

our class TraitConst::Actions {

    method trait-const($/) {
        make ConstTraitItem.new(
            maybe-outer-attrs   =>  $<maybe-outer-attrs>.made,
            ident               =>  $<ident>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-const-default =>  $<maybe-const-default>.made,
        )
    }
}


