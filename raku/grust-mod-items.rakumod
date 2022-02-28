use grust-model;

#-----------------------
our role ModItem::Rules {

    rule mod-item {
        <attrs-and-vis> <item>
    }
}

our role ModItem::Actions {

    method mod-item($/) {
        make Item.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            item          =>  $<item>.made,
        )
    }
}

#-----------------------
our role ModItems::Rules {

    rule maybe-mod-items {
        <mod-items>?
    }

    rule mod-items {
        <mod-item>+
    }
}

our role ModItems::Actions {

    method maybe-mod-items($/) {
        make $<mod-items>.made
    }

    method mod-items($/) {
        make $<mod-item>>>.made
    }
}
