our class ImplConst {
    has $.maybe_default;
    has $.attrs_and_vis;
    has $.item_const;
}

our class ImplConst::G {

    rule impl-const {
        <attrs-and_vis> <maybe-default> <item-const>
    }
}

our class ImplConst::A {

    method impl-const($/) {
        make ImplConst.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            maybe-default =>  $<maybe-default>.made,
            item-const    =>  $<item-const>.made,
        )
    }
}
