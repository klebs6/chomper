use grust-model;

our role Stmts::Rules {

    rule maybe-stmts { <stmts>? <nonblock-expr>? }

    rule stmts { <stmt>+ }

    proto rule stmt { * }
    rule stmt:sym<a> { <maybe-outer-attrs> <let> }
    rule stmt:sym<b> { <stmt-item> }
    rule stmt:sym<c> { <PUB> <stmt-item> }
    rule stmt:sym<d> { <outer-attrs> <stmt-item> }
    rule stmt:sym<e> { <outer-attrs> <PUB> <stmt-item> }
    rule stmt:sym<f> { <full-block-expr> }
    rule stmt:sym<g> { <maybe-outer-attrs> <block> }
    rule stmt:sym<h> { <nonblock-expr> ';' }
    rule stmt:sym<i> { <outer-attrs> <nonblock-expr> ';' }
    rule stmt:sym<j> { ';' }
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
    method stmt:sym<b>($/) { make $<stmt-item>.made }
    method stmt:sym<c>($/) { make $<stmt-item>.made }
    method stmt:sym<d>($/) { make $<stmt-item>.made }
    method stmt:sym<e>($/) { make $<stmt-item>.made }
    method stmt:sym<f>($/) { make $<full-block-expr>.made }
    method stmt:sym<g>($/) { make $<block>.made }
    method stmt:sym<h>($/) { }
    method stmt:sym<i>($/) { make $<nonblock-expr>.made }
    method stmt:sym<j>($/) { }
}

