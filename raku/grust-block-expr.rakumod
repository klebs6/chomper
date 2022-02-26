our class Macro {
    has $.braces_delimited-token-trees;
    has $.path_expr;
    has $.maybe_ident;
}

our class UnsafeBlock {
    has $.block;
}

our class BlockExprDotTail {
    has $.path-generic-args-with-colons;
    has @.maybe-exprs;
    has $.lit-integer;
}

our class BlockExprDot {
    has @.block-exprs;
    has $.block-expr-dot-tail;
}

our role BlockExpr::Rules {

    #------------------------
    proto rule block-expr { * }

    rule block-expr:sym<match>        { <expr-match>     } 
    rule block-expr:sym<if>           { <expr-if>        } 
    rule block-expr:sym<if-let>       { <expr-if-let>    } 
    rule block-expr:sym<while>        { <expr-while>     } 
    rule block-expr:sym<while-let>    { <expr-while-let> } 
    rule block-expr:sym<expr-loop>    { <expr-loop>      } 
    rule block-expr:sym<expr-for>     { <expr-for>       } 
    rule block-expr:sym<unsafe-block> { <UNSAFE> <block> } 
    rule block-expr:sym<macro>        { 
        <path-expr> '!' 
        <maybe-ident> 
        <braces-delimited-token-trees> 
    }

    #------------------------
    proto rule full-block_expr { * }

    rule full-block_expr:sym<basic> { <block-expr>     }
    rule full-block_expr:sym<dot>   { <block-expr-dot> }

    #------------------------
    proto rule block-expr-dot-tail { * }

    rule block-expr-dot-tail:sym<base> {
        <path-generic-args-with-colons> {self.set-prec(IDENT)} 
    }

    rule block-expr-dot-tail:sym<brack> {
        <path-generic-args-with-colons> '[' <maybe-expr> ']' 
    }

    rule block-expr-dot-tail:sym<parens> {
        <path-generic-args-with-colons> '(' <maybe-exprs> ')' 
    }

    rule block-expr-dot-tail:sym<lit-int> {
        <LIT-INTEGER>
    }

    #------------------------
    rule block-expr-dot {  
        [<block-expr> '.']+ <block-expr-dot-tail>
    }
}

our class BlockExpr::Actions {

    #-------------------------
    method block-expr:sym<match>($/)      { make $<expr-match>.made }
    method block-expr:sym<if>($/)         { make $<expr-if>.made }
    method block-expr:sym<if-let>($/)     { make $<expr-if-let>.made }
    method block-expr:sym<expr-while>($/) { make $<expr-while>.made }
    method block-expr:sym<while-let>($/)  { make $<expr-while-let>.made }
    method block-expr:sym<loop>($/)       { make $<expr-loop>.made }
    method block-expr:sym<for>($/)        { make $<expr-for>.made }

    method block-expr:sym<unsafe-block>($/) {
        make UnsafeBlock.new(
            block =>  $<block>.made,
        )
    }

    method block-expr:sym<macro>($/) {
        make Macro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            braces-delimited-token-trees =>  $<braces-delimited-token-trees>.made,
        )
    }

    method full-block_expr:sym<basic>($/) { make $<block-expr>.made }
    method full-block_expr:sym<dot>($/)   { make $<block-expr-dot>.made }

    #-------------------------
    method block-expr-dot($/) {
        make BlockExprDot.new(
            block-exprs         => $<block-expr>>>.made,
            block-expr-dot-tail => $<block-expr-dot-tail>.made,
        )
    }

    method block-expr-dot-tail:sym<base>($/) {
        make ExprField.new(
            path-generic-args-with-colons => $<path-generic-args-with-colons>.made,
        )
    }

    method block-expr-dot-tail:sym<brack>($/) {
        make ExprIndex.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
            maybe-expr                    =>  $<maybe-expr>.made,
        )
    }

    method block-expr-dot-tail:sym<parens>($/) {
        make ExprCall.new(
            block-expr                    =>  $<block-expr>.made,
            path-generic-args-with-colons =>  $<path-generic-args-with-colons>.made,
            maybe-exprs                   =>  $<maybe-exprs>.made,
        )
    }

    method block-expr-dot-tail:sym<lit-int>($/) {
        make $<LIT-INTEGER>.made
    }
}
