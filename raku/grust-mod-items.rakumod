our class Items {
    has $.mod_item;
}

our class Item {
    has $.item;
    has $.attrs_and_vis;
}

#-----------------------
our class ModItem::Rules {

    rule mod-item {
        <attrs-and_vis> <item>
    }
}

our class ModItem::Actions {

    method mod-item($/) {
        make Item.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            item          =>  $<item>.made,
        )
    }
}

#-----------------------
our class ModItems::Rules {

    rule maybe-mod_items {
        <mod-items>?
    }

    rule mod-items {
        <mod-item>+
    }
}

our class ModItems::Actions {

    method maybe-mod_items($/) {
        make $<mod-items>.made
    }

    method mod-items($/) {
        make $<mod-item>.made
    }
}
