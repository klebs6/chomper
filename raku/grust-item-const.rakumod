our class ItemConst {
    has $.ty;
    has $.ident;
    has $.expr;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
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
