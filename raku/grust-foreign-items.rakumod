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
    rule foreign-item:sym<a> { <attrs-and-vis> <STATIC> <item-foreign-static> }
    rule foreign-item:sym<b> { <attrs-and-vis> <item-foreign-fn> }
    rule foreign-item:sym<c> { <attrs-and-vis> <UNSAFE> <item-foreign-fn> }
}

our role ForeignItems::Actions {

    method maybe-foreign-items($/) {
        make $<foreign-items>.made
    }

    method foreign-items($/) {
        make ForeignItems.new(
            foreign-items =>  $<foreign-item>>>.made,
        )
    }

    method foreign-item:sym<a>($/) {
        make ForeignItem.new(
            attrs-and-vis       =>  $<attrs-and-vis>.made,
            item-foreign-static =>  $<item-foreign-static>.made,
        )
    }

     method foreign-item:sym<b>($/) {
        make ForeignItem.new(
            attrs-and-vis   =>  $<attrs-and-vis>.made,
            item-foreign-fn =>  $<item-foreign-fn>.made,
        )
    }

    method foreign-item:sym<c>($/) {
        make ForeignItem.new(
            attrs-and-vis   =>  $<attrs-and-vis>.made,
            item-foreign-fn =>  $<item-foreign-fn>.made,
        )
    }
}


