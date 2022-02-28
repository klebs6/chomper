use grust-model;

#------------------------------
# items that can appear in "stmts"
our role StmtItem::Rules {

    proto rule stmt-item { * }

    rule stmt-item:sym<static> { <item-static> }
    rule stmt-item:sym<const>  { <item-const> }
    rule stmt-item:sym<type>   { <item-type> }
    rule stmt-item:sym<block>  { <block-item> }
    rule stmt-item:sym<view>   { <view-item> }
}

our role StmtItem::Actions {

    method stmt-item:sym<static>($/) { make $<item-static>.made }
    method stmt-item:sym<const>($/)  { make $<item-const>.made }
    method stmt-item:sym<type>($/)   { make $<item-type>.made }
    method stmt-item:sym<block>($/)  { make $<block-item>.made }
    method stmt-item:sym<view>($/)   { make $<view-item>.made }
}
