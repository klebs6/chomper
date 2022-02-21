our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;
}

our class ItemConst::G {

    rule item-const {
        <CONST> <ident> ':' <ty> '=' <expr> ';'
    }
}

our class ItemConst::A {

    method item-const($/) {
        make ItemConst.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}

