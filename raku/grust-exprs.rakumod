our class Exprs {
    has $.expr;
}

our class Exprs::Rules {

    proto rule maybe-exprs { * }

    rule maybe-exprs:sym<a> {
        <exprs>
    }

    rule maybe-exprs:sym<b> {
        <exprs> ','
    }

    rule maybe-exprs:sym<c> {

    }

    proto rule maybe-expr { * }

    rule maybe-expr:sym<a> {
        <expr>
    }

    rule maybe-expr:sym<b> {

    }

    proto rule exprs { * }

    rule exprs:sym<a> {
        <expr>
    }

    rule exprs:sym<b> {
        <exprs> ',' <expr>
    }
}

our class Exprs::Actions {

    method maybe-exprs:sym<a>($/) {
        make $<exprs>.made
    }

    method maybe-exprs:sym<b>($/) {

    }

    method maybe-exprs:sym<c>($/) {
        MkNone<140567541982240>
    }

    method maybe-expr:sym<a>($/) {
        make $<expr>.made
    }

    method maybe-expr:sym<b>($/) {
        MkNone<140567541982272>
    }

    method exprs:sym<a>($/) {
        make exprs.new(
            expr =>  $<expr>.made,
        )
    }

    method exprs:sym<b>($/) {
        ExtNode<140567166887600>
    }
}
