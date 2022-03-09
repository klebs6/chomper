use Data::Dump::Tree;

use grust-model-expr;

our role NonblockPrefixExpr::Rules {

    proto rule nonblock-prefix-expr { * }

    rule nonblock-prefix-expr:sym<a> { '-' <expr> }
    rule nonblock-prefix-expr:sym<b> { '!' <expr> }
    rule nonblock-prefix-expr:sym<c> { '*' <expr> }
    rule nonblock-prefix-expr:sym<d> { '&' <maybe-mut> <expr> }
    rule nonblock-prefix-expr:sym<e> { <tok-andand> <maybe-mut> <expr> }
    rule nonblock-prefix-expr:sym<f> { <lambda-expr> }
    rule nonblock-prefix-expr:sym<g> { <kw-move> <lambda-expr> }
}

our role NonblockPrefixExpr::Actions {

    method nonblock-prefix-expr-nostruct:sym<a>($/) {
        make ExprUnaryMinus.new(
            expr => $<expr-nostruct>.made,
            text => ~$/,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<b>($/) {
        make ExprUnaryNot.new(
            expr => $<expr-nostruct>.made,
            text => ~$/,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<c>($/) {
        make ExprUnaryStar.new(
            expr => $<expr-nostruct>.made,
            text => ~$/,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut => $<maybe-mut>.made,
            expr      => $<expr-nostruct>.made,
            text      => ~$/,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<e>($/) {
        make ExprAddrOf.new(
            maybe-mut => $<maybe-mut>.made,
            expr      => $<expr-nostruct>.made,
            count     => 2,
            text      => ~$/,
        )
    }

    method nonblock-prefix-expr-nostruct:sym<f>($/) {
        make $<lambda-expr-nostruct>.made
    }

    method nonblock-prefix-expr-nostruct:sym<g>($/) {
        make $<lambda-expr-nostruct>.made
    }

    method nonblock-prefix-expr:sym<a>($/) {
        make ExprUnaryMinus.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-prefix-expr:sym<b>($/) {
        make ExprUnaryNot.new(
            expr =>  $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-prefix-expr:sym<c>($/) {
        make ExprUnaryStar.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }

    method nonblock-prefix-expr:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut =>  $<maybe-mut>.made,
            expr      =>  $<expr>.made,
            text      => ~$/,
        )
    }

    method nonblock-prefix-expr:sym<e>($/) {
        make ExprAddrOf.new(
            maybe-mut => $<maybe-mut>.made,
            expr      => $<expr>.made,
            count     => 2,
            text      => ~$/,
        )
    }

    method nonblock-prefix-expr:sym<f>($/) {
        make $<lambda-expr>.made
    }

    method nonblock-prefix-expr:sym<g>($/) {
        make $<lambda-expr>.made
    }
}
