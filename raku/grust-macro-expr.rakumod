use grust-model;

our role MacroExpr::Rules {

    proto rule macro-expr { * }

    rule macro-expr:sym<a> {
        <path-expr> 
        '!' 
        <maybe-ident> 
        <parens-delimited-token-trees>
    }

    rule macro-expr:sym<b> {
        <path-expr> 
        '!' 
        <maybe-ident> 
        <brackets-delimited-token-trees>
    }
}

our role MacroExpr::Actions {

    method macro-expr:sym<a>($/) {
        make MacroExpr.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            parens-delimited-token-trees =>  $<parens-delimited-token-trees>.made,
        )
    }

    method macro-expr:sym<b>($/) {
        make MacroExpr.new(
            path-expr                      =>  $<path-expr>.made,
            maybe-ident                    =>  $<maybe-ident>.made,
            brackets-delimited-token-trees =>  $<brackets-delimited-token-trees>.made,
        )
    }
}
