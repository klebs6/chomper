our class ItemStatic {
    has $.ty;
    has $.expr;
    has $.ident;
}

our class ItemStatic::Rules {

    proto rule item-static { * }

    rule item-static:sym<a> {
        <STATIC> <ident> ':' <ty> '=' <expr> ';'
    }

    rule item-static:sym<b> {
        <STATIC> <MUT> <ident> ':' <ty> '=' <expr> ';'
    }
}

our class ItemStatic::Actions {

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
