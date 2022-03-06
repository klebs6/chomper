use Data::Dump::Tree;

our class InitExpr {
    has $.expr;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        my $expr = $.expr.gist;
        "= $expr";
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
