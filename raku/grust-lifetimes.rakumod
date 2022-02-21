our class Lifetimes {
    has $.lifetime_and_bounds;
}

our class Lifetime {
    has $.maybe_ltbounds;
}

our class Lifetimes::G {

    proto rule maybe-lifetimes { * }

    rule maybe-lifetimes:sym<a> {
        <lifetimes>
    }

    rule maybe-lifetimes:sym<b> {
        <lifetimes> ','
    }

    rule maybe-lifetimes:sym<c> {

    }

    proto rule lifetimes { * }

    rule lifetimes:sym<a> {
        <lifetime-and_bounds>
    }

    rule lifetimes:sym<b> {
        <lifetimes> ',' <lifetime-and_bounds>
    }

    proto rule lifetime-and_bounds { * }

    rule lifetime-and_bounds:sym<a> {
        <LIFETIME> <maybe-ltbounds>
    }

    rule lifetime-and_bounds:sym<b> {
        <STATIC-LIFETIME>
    }

    proto rule lifetime { * }

    rule lifetime:sym<a> {
        <LIFETIME>
    }

    rule lifetime:sym<b> {
        <STATIC-LIFETIME>
    }
}

our class Lifetimes::A {

    method maybe-lifetimes:sym<a>($/) {
        make $<lifetimes>.made
    }

    method maybe-lifetimes:sym<b>($/) {

    }

    method maybe-lifetimes:sym<c>($/) {
        MkNone<140203792891008>
    }

    method lifetimes:sym<a>($/) {
        make Lifetimes.new(
            lifetime-and_bounds =>  $<lifetime-and_bounds>.made,
        )
    }

    method lifetimes:sym<b>($/) {
        ExtNode<140203790912376>
    }

    method lifetime-and_bounds:sym<a>($/) {
        make lifetime.new(
            maybe-ltbounds =>  $<maybe-ltbounds>.made,
        )
    }

    method lifetime-and_bounds:sym<b>($/) {
        make static_lifetime.new
    }

    method lifetime:sym<a>($/) {
        make lifetime.new(

        )
    }

    method lifetime:sym<b>($/) {
        make static_lifetime.new
    }
}
