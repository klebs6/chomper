use grust-model;


our role MacroExpr::Rules {

    proto rule macro-expr { * }

    rule macro-expr:sym<a> {
        <path-expr> '!' <maybe-ident> <parens-delimited_token_trees>
    }

    rule macro-expr:sym<b> {
        <path-expr> '!' <maybe-ident> <brackets-delimited_token_trees>
    }
}

our role MacroExpr::Actions {

    method macro-expr:sym<a>($/) {
        make MacroExpr.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            parens-delimited_token_trees =>  $<parens-delimited_token_trees>.made,
        )
    }

    method macro-expr:sym<b>($/) {
        make MacroExpr.new(
            path-expr                      =>  $<path-expr>.made,
            maybe-ident                    =>  $<maybe-ident>.made,
            brackets-delimited_token_trees =>  $<brackets-delimited_token_trees>.made,
        )
    }
}
