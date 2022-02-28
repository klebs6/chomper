use grust-model;

our role ItemStatic::Rules {

    proto rule item-static { * }

    rule item-static:sym<a> {
        <static> <ident> ':' <ty> '=' <expr> ';'
    }

    rule item-static:sym<b> {
        <static> <mut> <ident> ':' <ty> '=' <expr> ';'
    }
}

our role ItemStatic::Actions {

    method item-static:sym<a>($/) {
        make ItemStatic.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }

    method item-static:sym<b>($/) {
        make ItemStatic.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}
