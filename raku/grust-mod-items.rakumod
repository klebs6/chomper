use grust-model;

use grust-model;


#-----------------------
our role ModItem::Rules {

    rule mod-item {
        <attrs-and_vis> <item>
    }
}

our role ModItem::Actions {

    method mod-item($/) {
        make Item.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            item          =>  $<item>.made,
        )
    }
}

#-----------------------
our role ModItems::Rules {

    rule maybe-mod_items {
        <mod-items>?
    }

    rule mod-items {
        <mod-item>+
    }
}

our role ModItems::Actions {

    method maybe-mod_items($/) {
        make $<mod-items>.made
    }

    method mod-items($/) {
        make $<mod-item>>>.made
    }
}
