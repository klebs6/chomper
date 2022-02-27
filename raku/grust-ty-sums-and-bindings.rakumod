our class TySumsAndBindings {
    has $.bindings;
    has $.ty_sums;
}

our class TySumsAndBindings::Rules {

    proto rule maybe-ty_sums_and_or_bindings { * }
    rule maybe-ty_sums_and_or_bindings:sym<c> { <ty-sums> [',' <bindings>?]? }
    rule maybe-ty_sums_and_or_bindings:sym<e> { [<bindings> ','?]? }

    rule maybe-bindings:sym<a> { [',' <bindings>]? }
}

our class TySumsAndBindings::Actions {

    method maybe-ty_sums_and_or_bindings:sym<c>($/) {
        make TySumsAndBindings.new(
            ty-sums  =>  $<ty-sums>.made,
            bindings =>  $<bindings>.made,
        )
    }

    method maybe-ty_sums_and_or_bindings:sym<e>($/) {
        make $<bindings>.made
    }

    method maybe-bindings:sym<a>($/) {
        make $<bindings>.made
    }
}
