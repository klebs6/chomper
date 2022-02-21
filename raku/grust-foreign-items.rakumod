our class ForeignItem {
    has $.item_foreign_fn;
    has $.attrs_and_vis;
    has $.item_foreign_static;
}

our class ForeignItems {
    has $.foreign_item;
}

our class ForeignItems::G {

    proto rule maybe-foreign_items { * }

    rule maybe-foreign_items:sym<a> {
        <foreign-items>
    }

    rule maybe-foreign_items:sym<b> {

    }

    proto rule foreign-items { * }

    rule foreign-items:sym<a> {
        <foreign-item>
    }

    rule foreign-items:sym<b> {
        <foreign-items> <foreign-item>
    }

    proto rule foreign-item { * }

    rule foreign-item:sym<a> {
        <attrs-and_vis> <STATIC> <item-foreign_static>
    }

    rule foreign-item:sym<b> {
        <attrs-and_vis> <item-foreign_fn>
    }

    rule foreign-item:sym<c> {
        <attrs-and_vis> <UNSAFE> <item-foreign_fn>
    }
}

our class ForeignItems::A {

    method maybe-foreign_items:sym<a>($/) {
        make $<foreign-items>.made
    }

    method maybe-foreign_items:sym<b>($/) {
        MkNone<140372880377344>
    }

    method foreign-items:sym<a>($/) {
        make ForeignItems.new(
            foreign-item =>  $<foreign-item>.made,
        )
    }

    method foreign-items:sym<b>($/) {
        ExtNode<140373133060288>
    }

    method foreign-item:sym<a>($/) {
        make ForeignItem.new(
            attrs-and_vis       =>  $<attrs-and_vis>.made,
            item-foreign_static =>  $<item-foreign_static>.made,
        )
    }

    method foreign-item:sym<b>($/) {
        make ForeignItem.new(
            attrs-and_vis   =>  $<attrs-and_vis>.made,
            item-foreign_fn =>  $<item-foreign_fn>.made,
        )
    }

    method foreign-item:sym<c>($/) {
        make ForeignItem.new(
            attrs-and_vis   =>  $<attrs-and_vis>.made,
            item-foreign_fn =>  $<item-foreign_fn>.made,
        )
    }
}
