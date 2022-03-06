our class TySumsAndBindings {
    has $.bindings;
    has $.ty-sums;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role TySumsAndBindings::Rules {

    proto rule maybe-ty-sums-and-or-bindings { * }
    rule maybe-ty-sums-and-or-bindings:sym<c> { <ty-sums> [',' <bindings>?]? }
    rule maybe-ty-sums-and-or-bindings:sym<e> { [<bindings> ','?]? }

    rule maybe-bindings:sym<a> { [',' <bindings>]? }
}

our role TySumsAndBindings::Actions {

    method maybe-ty-sums-and-or-bindings:sym<c>($/) {
        make TySumsAndBindings.new(
            ty-sums  => $<ty-sums>.made,
            bindings => $<bindings>.made,
            text     => ~$/,
        )
    }

    method maybe-ty-sums-and-or-bindings:sym<e>($/) {
        make $<bindings>.made
    }

    method maybe-bindings:sym<a>($/) {
        make $<bindings>.made
    }
}
