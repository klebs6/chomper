use Data::Dump::Tree;

use grust-model;

#------------------------------
# items that can appear outside of a fn block
our role Item::Rules {

    proto rule item { * }
    rule item:sym<stmt>  { <stmt-item> }
    rule item:sym<macro> { <item-macro> }
}

our role Item::Actions {

    method item:sym<stmt>($/)  { make $<stmt-item>.made }
    method item:sym<macro>($/) { make $<item-macro>.made }
}
