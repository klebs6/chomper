our class Guard::Rules {

    proto rule maybe-guard { * }

    rule maybe-guard:sym<a> {
        <IF> <expr-nostruct>
    }

    rule maybe-guard:sym<b> {

    }
}

our class Guard::Actions {

    method maybe-guard:sym<a>($/) {
        make $<expr_nostruct>.made
    }

    method maybe-guard:sym<b>($/) {
        MkNone<140269876955936>
    }
}

