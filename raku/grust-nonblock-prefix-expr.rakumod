use grust-model;

#-------------------------------------

our role NonblockPrefixExpr::Rules {

    proto rule nonblock-prefix-expr-nostruct { * }

    rule nonblock-prefix-expr-nostruct:sym<a> { '-' <expr-nostruct> }
    rule nonblock-prefix-expr-nostruct:sym<b> { '!' <expr-nostruct> }
    rule nonblock-prefix-expr-nostruct:sym<c> { '*' <expr-nostruct> }
    rule nonblock-prefix-expr-nostruct:sym<d> { '&' <maybe-mut> <expr-nostruct> }
    rule nonblock-prefix-expr-nostruct:sym<e> { <andand> <maybe-mut> <expr-nostruct> }
    rule nonblock-prefix-expr-nostruct:sym<f> { <lambda-expr-nostruct> }
    rule nonblock-prefix-expr-nostruct:sym<g> { <move> <lambda-expr-nostruct> }

    proto rule nonblock-prefix-expr { * }

    rule nonblock-prefix-expr:sym<a> { '-' <expr> }
    rule nonblock-prefix-expr:sym<b> { '!' <expr> }
    rule nonblock-prefix-expr:sym<c> { '*' <expr> }
    rule nonblock-prefix-expr:sym<d> { '&' <maybe-mut> <expr> }
    rule nonblock-prefix-expr:sym<e> { <andand> <maybe-mut> <expr> }
    rule nonblock-prefix-expr:sym<f> { <lambda-expr> }
    rule nonblock-prefix-expr:sym<g> { <move> <lambda-expr> }
}

our role NonblockPrefixExpr::Actions {

    method nonblock-prefix-expr-nostruct:sym<a>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<b>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<c>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut     =>  $<maybe-mut>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<e>($/) {
        make ExprAddrOf.new(

        )
    }

    method nonblock-prefix-expr-nostruct:sym<f>($/) {
        make $<lambda-expr-nostruct>.made
    }

    method nonblock-prefix-expr-nostruct:sym<g>($/) {
        make $<lambda-expr-nostruct>.made
    }

    method nonblock-prefix-expr:sym<a>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix-expr:sym<b>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix-expr:sym<c>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix-expr:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut =>  $<maybe-mut>.made,
            expr      =>  $<expr>.made,
        )
    }

    method nonblock-prefix-expr:sym<e>($/) {
        make ExprAddrOf.new(

        )
    }

    method nonblock-prefix-expr:sym<f>($/) {
        make $<lambda-expr>.made
    }

    method nonblock-prefix-expr:sym<g>($/) {
        make $<lambda-expr>.made
    }
}
