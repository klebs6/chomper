our class TySumsAndBindings {
    has $.bindings;
    has $.ty-sums;
}

our class TySumsAndBindings::Rules {

    proto rule maybe-ty-sums-and-or-bindings { * }
    rule maybe-ty-sums-and-or-bindings:sym<c> { <ty-sums> [',' <bindings>?]? }
    rule maybe-ty-sums-and-or-bindings:sym<e> { [<bindings> ','?]? }

    rule maybe-bindings:sym<a> { [',' <bindings>]? }
}

our class TySumsAndBindings::Actions {

    method maybe-ty-sums-and-or-bindings:sym<c>($/) {
        make TySumsAndBindings.new(
            ty-sums  =>  $<ty-sums>.made,
            bindings =>  $<bindings>.made,
        )
    }

    method maybe-ty-sums-and-or-bindings:sym<e>($/) {
        make $<bindings>.made
    }

    method maybe-bindings:sym<a>($/) {
        make $<bindings>.made
    }
}

