use grust-model;

our role ItemStatic::Rules {

    rule item-static {
        <kw-static> <kw-mut>? <ident> ':' <ty> '=' <expr> ';'
    }
}

our role ItemStatic::Actions {

    method item-static($/) {
        make ItemStatic.new(
            mut   => so $/<kw-mut>:exists,
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}
