use grust-model;

our role VecExpr::Rules {

    proto rule vec-expr { * }

    rule vec-expr:sym<a> {
        <maybe-exprs>
    }

    rule vec-expr:sym<b> {
        <exprs> ';' <expr>
    }
}

our role VecExpr::Actions {

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

