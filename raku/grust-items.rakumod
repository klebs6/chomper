
#------------------------------
# items that can appear outside of a fn block
our class Item::Rules {

    proto rule item { * }
    rule item:sym<stmt>  { <stmt-item> }
    rule item:sym<macro> { <item-macro> }
}

our class Item::Actions {

    method item:sym<stmt>($/)  { make $<stmt-item>.made }
    method item:sym<macro>($/) { make $<item-macro>.made }
}

