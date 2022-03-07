use Data::Dump::Tree;

our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;

    has $.text;

    method gist {
        "const {$.ident.gist}: {$.ty.gist}= {$.expr.gist};"
    }
}

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
            text  => ~$/,
        )
    }
}
