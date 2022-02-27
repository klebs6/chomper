use grust-model;


our role ItemMacro::Rules {

    proto rule item-macro { * }

    rule item-macro:sym<a> {
        <path-expr> '!' <maybe-ident> <parens-delimited_token_trees> ';'
    }

    rule item-macro:sym<b> {
        <path-expr> '!' <maybe-ident> <braces-delimited_token_trees>
    }

    rule item-macro:sym<c> {
        <path-expr> '!' <maybe-ident> <brackets-delimited_token_trees> ';'
    }
}

our role ItemMacro::Actions {

    method item-macro:sym<a>($/) {
        make ItemMacro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            parens-delimited_token_trees =>  $<parens-delimited_token_trees>.made,
        )
    }

    method item-macro:sym<b>($/) {
        make ItemMacro.new(
            path-expr                    =>  $<path-expr>.made,
            maybe-ident                  =>  $<maybe-ident>.made,
            braces-delimited_token_trees =>  $<braces-delimited_token_trees>.made,
        )
    }

    method item-macro:sym<c>($/) {
        make ItemMacro.new(
            path-expr                      =>  $<path-expr>.made,
            maybe-ident                    =>  $<maybe-ident>.made,
            brackets-delimited_token_trees =>  $<brackets-delimited_token_trees>.made,
        )
    }
}
