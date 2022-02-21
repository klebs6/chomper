
#------------------------------
# items that can appear outside of a fn block
our class Item::Rules {

    proto rule item { * }

    rule item:sym<a> {
        <stmt-item>
    }

    rule item:sym<b> {
        <item-macro>
    }
}

our class Item::Actions {

    method item:sym<a>($/) {
        make $<stmt-item>.made
    }

    method item:sym<b>($/) {
        make $<item-macro>.made
    }
}

