
#-------------------------------------
our class ExprAddrOf {
    has $.expr_nostruct;
    has $.maybe_mut;
    has $.expr;
}

our class ExprUnary {
    has $.expr;
    has $.expr_nostruct;
}

our class NonblockPrefixExpr::G {

    proto rule nonblock-prefix_expr_nostruct { * }

    rule nonblock-prefix_expr_nostruct:sym<a> {
        '-' <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<b> {
        '!' <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<c> {
        '*' <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<d> {
        '&' <maybe-mut> <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<e> {
        <ANDAND> <maybe-mut> <expr-nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<f> {
        <lambda-expr_nostruct>
    }

    rule nonblock-prefix_expr_nostruct:sym<g> {
        <MOVE> <lambda-expr_nostruct>
    }

    proto rule nonblock-prefix_expr { * }

    rule nonblock-prefix_expr:sym<a> {
        '-' <expr>
    }

    rule nonblock-prefix_expr:sym<b> {
        '!' <expr>
    }

    rule nonblock-prefix_expr:sym<c> {
        '*' <expr>
    }

    rule nonblock-prefix_expr:sym<d> {
        '&' <maybe-mut> <expr>
    }

    rule nonblock-prefix_expr:sym<e> {
        <ANDAND> <maybe-mut> <expr>
    }

    rule nonblock-prefix_expr:sym<f> {
        <lambda-expr>
    }

    rule nonblock-prefix_expr:sym<g> {
        <MOVE> <lambda-expr>
    }
}

our class NonblockPrefixExpr::A {

    method nonblock-prefix_expr_nostruct:sym<a>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<b>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<c>($/) {
        make ExprUnary.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut     =>  $<maybe-mut>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method nonblock-prefix_expr_nostruct:sym<e>($/) {
        make ExprAddrOf.new(

        )
    }

    method nonblock-prefix_expr_nostruct:sym<f>($/) {
        make $<lambda-expr_nostruct>.made
    }

    method nonblock-prefix_expr_nostruct:sym<g>($/) {
        make $<lambda_expr_nostruct>.made
    }

    method nonblock-prefix_expr:sym<a>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<b>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<c>($/) {
        make ExprUnary.new(
            expr =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<d>($/) {
        make ExprAddrOf.new(
            maybe-mut =>  $<maybe-mut>.made,
            expr      =>  $<expr>.made,
        )
    }

    method nonblock-prefix_expr:sym<e>($/) {
        make ExprAddrOf.new(

        )
    }

    method nonblock-prefix_expr:sym<f>($/) {
        make $<lambda-expr>.made
    }

    method nonblock-prefix_expr:sym<g>($/) {
        make $<lambda_expr>.made
    }
}

