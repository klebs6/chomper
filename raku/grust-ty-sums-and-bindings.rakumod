our class TySumsAndBindings {
    has $.bindings;
    has $.ty_sums;
}

our class TySumsAndBindings::G {

    proto rule maybe-ty_sums_and_or_bindings { * }

    rule maybe-ty_sums_and_or_bindings:sym<a> {
        <ty-sums>
    }

    rule maybe-ty_sums_and_or_bindings:sym<b> {
        <ty-sums> ','
    }

    rule maybe-ty_sums_and_or_bindings:sym<c> {
        <ty-sums> ',' <bindings>
    }

    rule maybe-ty_sums_and_or_bindings:sym<d> {
        <bindings>
    }

    rule maybe-ty_sums_and_or_bindings:sym<e> {
        <bindings> ','
    }

    rule maybe-ty_sums_and_or_bindings:sym<f> {

    }

    proto rule maybe-bindings { * }

    rule maybe-bindings:sym<a> {
        ',' <bindings>
    }

    rule maybe-bindings:sym<b> {

    }
}

our class TySumsAndBindings::A {

    method maybe-ty_sums_and_or_bindings:sym<a>($/) {
        make $<ty-sums>.made
    }

    method maybe-ty_sums_and_or_bindings:sym<b>($/) {

    }

    method maybe-ty_sums_and_or_bindings:sym<c>($/) {
        make TySumsAndBindings.new(
            ty-sums  =>  $<ty-sums>.made,
            bindings =>  $<bindings>.made,
        )
    }

    method maybe-ty_sums_and_or_bindings:sym<d>($/) {
        make $<bindings>.made
    }

    method maybe-ty_sums_and_or_bindings:sym<e>($/) {

    }

    method maybe-ty_sums_and_or_bindings:sym<f>($/) {
        MkNone<140698413986528>
    }

    method maybe-bindings:sym<a>($/) {
        make $<bindings>.made
    }

    method maybe-bindings:sym<b>($/) {
        MkNone<140698413986560>
    }
}
