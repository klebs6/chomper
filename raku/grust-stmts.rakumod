use grust-model;

our role Stmts::Rules {

    rule maybe-stmts { 
        <stmts>? 
        <nonblock-expr>? 
    }

    rule stmts { <stmt>+ }

    proto rule stmt  { * }
    rule stmt:sym<a> { <comment>? <stmt-body> }
    rule stmt:sym<b> { <block-comment> }

    proto rule stmt-body  { * }
    rule stmt-body:sym<a> { <maybe-outer-attrs> <let> }
    rule stmt-body:sym<e> { <outer-attrs>? <kw-pub>? <stmt-item> }
    rule stmt-body:sym<f> { <full-block-expr> }
    rule stmt-body:sym<g> { <maybe-outer-attrs> <block> }
    rule stmt-body:sym<i> { <outer-attrs>? <nonblock-expr> ';' }
    rule stmt-body:sym<j> { ';' }
}

our role Stmts::Actions {

    method maybe-stmts:sym<a>($/) {
        make Stmts.new(
            stmts         => $<stmts>.made,
            nonblock-expr => $<nonblock-expr>.made,
        )
    }

    method stmts($/) {
        make $<stmt>>>.made
    }

    method stmt:sym<a>($/) { make $<let>.made }
    method stmt:sym<e>($/) { make $<stmt-item>.made }
    method stmt:sym<f>($/) { make $<full-block-expr>.made }
    method stmt:sym<g>($/) { make $<block>.made }
    method stmt:sym<i>($/) { make $<nonblock-expr>.made }
}

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
