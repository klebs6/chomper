our class ForeignItem {
    has $.item_foreign_fn;
    has $.attrs_and_vis;
    has $.item_foreign_static;
}

our class ForeignItems {
    has $.foreign_items;
}

our class ForeignItems::Rules {

    rule maybe-foreign_items {
        <foreign-items>?
    }

    rule foreign-items {
        <foreign-item>+
    }

    #------------------------
    proto rule foreign-item { * }
    rule foreign-item:sym<a> { <attrs-and_vis> <STATIC> <item-foreign_static> }
    rule foreign-item:sym<b> { <attrs-and_vis> <item-foreign_fn> }
    rule foreign-item:sym<c> { <attrs-and_vis> <UNSAFE> <item-foreign_fn> }
}

our class ForeignItems::Actions {

    method maybe-foreign_items($/) {
        make $<foreign-items>.made
    }

    method foreign-items($/) {
        make ForeignItems.new(
            foreign-items =>  $<foreign-item>>>.made,
        )
    }

    method foreign-item($/) {
        make ForeignItem.new(
            attrs-and_vis       =>  $<attrs-and_vis>.made,
            item-foreign_static =>  $<item-foreign_static>.made,
        )
    }

    method foreign-item($/) {
        make ForeignItem.new(
            attrs-and_vis   =>  $<attrs-and_vis>.made,
            item-foreign_fn =>  $<item-foreign_fn>.made,
        )
    }

    method foreign-item($/) {
        make ForeignItem.new(
            attrs-and_vis   =>  $<attrs-and_vis>.made,
            item-foreign_fn =>  $<item-foreign_fn>.made,
        )
    }
}
