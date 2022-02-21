our class VecRepeat {
    has $.expr;
    has $.exprs;
}

our class VecExpr::Rules {

    proto rule vec-expr { * }

    rule vec-expr:sym<a> {
        <maybe-exprs>
    }

    rule vec-expr:sym<b> {
        <exprs> ';' <expr>
    }
}

our class VecExpr::Actions {

    method vec-expr:sym<a>($/) {
        make $<maybe-exprs>.made
    }

    method vec-expr:sym<b>($/) {
        make VecRepeat.new(
            exprs =>  $<exprs>.made,
            expr  =>  $<expr>.made,
        )
    }
}
