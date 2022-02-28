use grust-model;

our role Guard::Rules {

    rule maybe-guard {
        [ <kw-if> <expr-nostruct> ]?
    }
}

our role Guard::Actions {

    method maybe-guard($/) {
        make $<expr-nostruct>.made
    }
}
