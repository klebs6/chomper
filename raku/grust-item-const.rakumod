use grust-model;

our role ItemConst::Rules {

    rule item-const {
        <kw-const> <ident> ':' <ty> '=' <expr> ';'
    }
}

our role ItemConst::Actions {

    method item-const($/) {
        make ItemConst.new(
            ident =>  $<ident>.made,
            ty    =>  $<ty>.made,
            expr  =>  $<expr>.made,
        )
    }
}
