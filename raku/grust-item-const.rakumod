our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;
}

our class ItemConst::Rules {

    rule item-const {
        <CONST> <ident> ':' <ty> '=' <expr> ';'
    }
}

our class ItemConst::Actions {

    method item-const($/) {
        make ItemConst.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}

