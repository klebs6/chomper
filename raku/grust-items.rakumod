
#------------------------------
# items that can appear outside of a fn block
our class Item::G {

    proto rule item { * }

    rule item:sym<a> {
        <stmt-item>
    }

    rule item:sym<b> {
        <item-macro>
    }
}

our class Item::A {

    method item:sym<a>($/) {
        make $<stmt-item>.made
    }

    method item:sym<b>($/) {
        make $<item-macro>.made
    }
}

