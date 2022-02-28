use grust-model;


our role TraitConst::Rules {

    rule trait-const {
        <maybe-outer-attrs> 
        <CONST> 
        <ident> 
        <maybe-ty-ascription> 
        <maybe-const-default> 
        ';'
    }
}

our role TraitConst::Actions {

    method trait-const($/) {
        make ConstTraitItem.new(
            maybe-outer-attrs   =>  $<maybe-outer-attrs>.made,
            ident               =>  $<ident>.made,
            maybe-ty-ascription =>  $<maybe-ty-ascription>.made,
            maybe-const-default =>  $<maybe-const-default>.made,
        )
    }
}

