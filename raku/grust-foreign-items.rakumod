use grust-model;

our role ForeignItems::Rules {

    rule maybe-foreign-items {
        <foreign-items>?
    }

    rule foreign-items {
        <foreign-item>+
    }

    #------------------------
    proto rule foreign-item { * }
    rule foreign-item:sym<static> { <attrs-and-vis> <kw-static> <item-foreign-static> }
    rule foreign-item:sym<fn>     { <attrs-and-vis> <item-foreign-fn> }
    rule foreign-item:sym<unsafe> { <attrs-and-vis> <kw-unsafe> <item-foreign-fn> }
}

our role ForeignItems::Actions {

    method maybe-foreign-items($/) {
        make $<foreign-items>.made
    }

    method foreign-items($/) {
        make $<foreign-item>>>.made
    }

    method foreign-item:sym<static>($/) {
        make ForeignItemStatic.new(
            attrs-and-vis       =>  $<attrs-and-vis>.made,
            item-foreign-static =>  $<item-foreign-static>.made,
            text                => ~$/,
        )
    }

     method foreign-item:sym<fn>($/) {
        make ForeignItem.new(
            attrs-and-vis   =>  $<attrs-and-vis>.made,
            item-foreign-fn =>  $<item-foreign-fn>.made,
            text            => ~$/,
        )
    }

    method foreign-item:sym<unsafe>($/) {
        make ForeignItemUnsafe.new(
            attrs-and-vis   =>  $<attrs-and-vis>.made,
            item-foreign-fn =>  $<item-foreign-fn>.made,
            text            => ~$/,
        )
    }
}
