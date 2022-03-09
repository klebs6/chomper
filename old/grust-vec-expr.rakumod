use Data::Dump::Tree;

our class VecRepeat {
    has $.expr;
    has $.exprs;

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

our role VecExpr::Rules {

    proto rule vec-expr { * }

    rule vec-expr:sym<b> {
        <exprs> ';' <expr>
    }

    rule vec-expr:sym<a> {
        <maybe-exprs>
    }

}

our role VecExpr::Actions {

    method vec-expr:sym<a>($/) {
        make $<maybe-exprs>.made
    }

    method vec-expr:sym<b>($/) {
        make VecRepeat.new(
            exprs => $<exprs>.made,
            expr  => $<expr>.made,
            text  => ~$/,
        )
    }
}
