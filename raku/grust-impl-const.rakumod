use grust-model;

our role ImplConst::Rules {

    rule impl-const {
        <attrs-and-vis> 
        <maybe-default> 
        <item-const>
    }
}

our role ImplConst::Actions {

    method impl-const($/) {
        make ImplConst.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            maybe-default =>  $<maybe-default>.made,
            item-const    =>  $<item-const>.made,
        )
    }
}
