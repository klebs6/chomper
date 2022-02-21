our class QPathParams::G {

    proto rule maybe-qpath_params { * }

    rule maybe-qpath_params:sym<a> {
        <MOD-SEP> <generic-args>
    }

    rule maybe-qpath_params:sym<b> {

    }
}

our class QPathParams::A {

    method maybe-qpath_params:sym<a>($/) {
        make $<generic_args>.made
    }

    method maybe-qpath_params:sym<b>($/) {
        MkNone<140654400390368>
    }
}
