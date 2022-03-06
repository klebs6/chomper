our class InitExpr {
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

our role InitExpr::Rules {

    rule maybe-init-expr {
        [ '=' <expr> ]?
    }
}

our role InitExpr::Actions {

    method maybe-init-expr($/) {
        make InitExpr.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }
}
