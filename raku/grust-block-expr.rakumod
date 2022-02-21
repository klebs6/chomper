
our class Macro {
    has $.braces_delimited_token_trees;
    has $.path_expr;
    has $.maybe_ident;
}

our class UnsafeBlock {
    has $.block;
}

our role BlockExpr::Rules {

    proto rule block-expr { * }

    rule block-expr:sym<match>        { <expr-match> }
    rule block-expr:sym<if>           { <expr-if> }
    rule block-expr:sym<if-let>       { <expr-if_let> }
    rule block-expr:sym<while>        { <expr-while> }
    rule block-expr:sym<while-let>    { <expr-while_let> }
    rule block-expr:sym<expr-loop>    { <expr-loop> }
    rule block-expr:sym<expr-for>     { <expr-for> }
    rule block-expr:sym<unsafe-block> { <UNSAFE> <block> }
    rule block-expr:sym<macro>        { <path-expr> '!' <maybe-ident> <braces-delimited_token_trees> }

    proto rule full-block_expr { * }

    rule full-block_expr:sym<a> { <block-expr> }
    rule full-block_expr:sym<b> { <block-expr_dot> }

    proto rule block-expr_dot { * }

    rule block-expr_dot:sym<a> { <block-expr>     '.' <path-generic_args_with_colons> {self.set-prec(IDENT)} }
    rule block-expr_dot:sym<b> { <block-expr_dot> '.' <path-generic_args_with_colons> {self.set-prec(IDENT)} }
    rule block-expr_dot:sym<c> { <block-expr>     '.' <path-generic_args_with_colons>                          '[' <maybe-expr>  ']' }
    rule block-expr_dot:sym<d> { <block-expr_dot> '.' <path-generic_args_with_colons>                          '[' <maybe-expr>  ']' }
    rule block-expr_dot:sym<e> { <block-expr>     '.' <path-generic_args_with_colons>                          '(' <maybe-exprs> ')' }
    rule block-expr_dot:sym<f> { <block-expr_dot> '.' <path-generic_args_with_colons>                          '(' <maybe-exprs> ')' }
    rule block-expr_dot:sym<g> { <block-expr>     '.' <LIT-INTEGER> }
    rule block-expr_dot:sym<h> { <block-expr_dot> '.' <LIT-INTEGER> }
}

our class BlockExpr::Actions {

    method block-expr:sym<match>($/) {
        make $<expr-match>.made
    }

    method block-expr:sym<if>($/) {
        make $<expr-if>.made
    }

    method block-expr:sym<if-let>($/) {
        make $<expr-if_let>.made
    }

    method block-expr:sym<expr-while>($/) {
        make $<expr-while>.made
    }

    method block-expr:sym<while-let>($/) {
        make $<expr-while_let>.made
    }

    method block-expr:sym<loop>($/) {
        make $<expr-loop>.made
    }

    method block-expr:sym<for>($/) {
        make $<expr-for>.made
    }

    method block-expr:sym<unsafe-block>($/) {
        make UnsafeBlock.new(
            block =>  $<block>.made,
        )
    }

    method block-expr:sym<macro>($/) {
        make Macro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            braces-delimited_token_trees =>  $<braces-delimited_token_trees>.made,
        )
    }

    method full-block_expr:sym<a>($/) {
        make $<block-expr>.made
    }

    method full-block_expr:sym<b>($/) {
        make $<block-expr_dot>.made
    }

    method block-expr_dot:sym<a>($/) {
        make ExprField.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method block-expr_dot:sym<b>($/) {
        make ExprField.new(
            block-expr_dot                =>  $<block-expr_dot>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
        )
    }

    method block-expr_dot:sym<c>($/) {
        make ExprIndex.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-expr                    =>  $<maybe-expr>.made,
        )
    }

    method block-expr_dot:sym<d>($/) {
        make ExprIndex.new(
            block-expr_dot                =>  $<block-expr_dot>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-expr                    =>  $<maybe-expr>.made,
        )
    }

    method block-expr_dot:sym<e>($/) {
        make ExprCall.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-exprs                   =>  $<maybe-exprs>.made,
        )
    }

    method block-expr_dot:sym<f>($/) {
        make ExprCall.new(
            block-expr_dot                =>  $<block-expr_dot>.made,
            path-generic_args_with_colons =>  $<path-generic_args_with_colons>.made,
            maybe-exprs                   =>  $<maybe-exprs>.made,
        )
    }

    method block-expr_dot:sym<g>($/) {
        make ExprTupleIndex.new(
            block-expr =>  $<block-expr>.made,
        )
    }

    method block-expr_dot:sym<h>($/) {
        make ExprTupleIndex.new(
            block-expr_dot =>  $<block-expr_dot>.made,
        )
    }
}

