our class ItemStatic {
    has Bool $.mut;
    has $.ty;
    has $.expr;
    has $.ident;

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
            text  => ~$/,
        )
    }
}
