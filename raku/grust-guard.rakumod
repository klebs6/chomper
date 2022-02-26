our class Guard::Rules {

    rule maybe-guard {
        [ <IF> <expr-nostruct> ]?
    }
}

our class Guard::Actions {

    method maybe-guard($/) {
        make $<expr_nostruct>.made
    }
}

