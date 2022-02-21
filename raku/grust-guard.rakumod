our class Guard::G {

    proto rule maybe-guard { * }

    rule maybe-guard:sym<a> {
        <IF> <expr-nostruct>
    }

    rule maybe-guard:sym<b> {

    }
}

our class Guard::A {

    method maybe-guard:sym<a>($/) {
        make $<expr_nostruct>.made
    }

    method maybe-guard:sym<b>($/) {
        MkNone<140269876955936>
    }
}

