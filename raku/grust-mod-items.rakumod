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

    proto rule maybe-mod_items { * }

    rule maybe-mod_items:sym<a> {
        <mod-items>
    }

    rule maybe-mod_items:sym<b> {

    }

    proto rule mod-items { * }

    rule mod-items:sym<a> {
        <mod-item>
    }

    rule mod-items:sym<b> {
        <mod-items> <mod-item>
    }
}

our class ModItems::Actions {

    method maybe-mod_items:sym<a>($/) {
        make $<mod-items>.made
    }

    method maybe-mod_items:sym<b>($/) {
        MkNone<140677866772384>
    }

    method mod-items:sym<a>($/) {
        make Items.new(
            mod-item =>  $<mod-item>.made,
        )
    }

    method mod-items:sym<b>($/) {
        ExtNode<140679773399960>
    }
}
