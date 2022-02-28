use grust-model;


our role ItemMacro::Rules {

    proto rule item-macro { * }

    rule item-macro:sym<a> {
        <path-expr> '!' <maybe-ident> <parens-delimited-token-trees> ';'
    }

    rule item-macro:sym<b> {
        <path-expr> '!' <maybe-ident> <braces-delimited-token-trees>
    }

    rule item-macro:sym<c> {
        <path-expr> '!' <maybe-ident> <brackets-delimited-token-trees> ';'
    }
}

our role ItemMacro::Actions {

    method item-macro:sym<a>($/) {
        make ItemMacro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            parens-delimited-token-trees =>  $<parens-delimited-token-trees>.made,
        )
    }

    method item-macro:sym<b>($/) {
        make ItemMacro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            braces-delimited-token-trees =>  $<braces-delimited-token-trees>.made,
        )
    }

    method item-macro:sym<c>($/) {
        make ItemMacro.new(
            path-expr                      =>  $<path-expr>.made,
            maybe-ident                    =>  $<maybe-ident>.made,
            brackets-delimited-token-trees =>  $<brackets-delimited-token-trees>.made,
        )
    }
}

