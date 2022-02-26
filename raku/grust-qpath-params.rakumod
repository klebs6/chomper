our class QPathParams::Rules {

    rule maybe-qpath-params {
        [<MOD-SEP> <generic-args>]?
    }
}

our class QPathParams::Actions {

    method maybe-qpath-params:sym<a>($/) {
        make $<generic-args>.made
    }
}
