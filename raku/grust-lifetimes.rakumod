our class Lifetimes {
    has $.lifetime_and_bounds;
}

our class Lifetime {
    has $.maybe_ltbounds;
}

our class Lifetimes::Rules {

    rule maybe-lifetimes { [<lifetimes> ','?]? }

    rule lifetimes {
        <lifetime-and_bounds>+ %% ","
    }

    #---------------------
    proto rule lifetime-and_bounds { * }
    rule lifetime-and_bounds:sym<a> { <LIFETIME> <maybe-ltbounds> }
    rule lifetime-and_bounds:sym<b> { <STATIC-LIFETIME> }

    proto rule lifetime { * }
    rule lifetime:sym<a> { <LIFETIME> }
    rule lifetime:sym<b> { <STATIC-LIFETIME> }
}

our class Lifetimes::Actions {

    method maybe-lifetimes($/) {
        make $<lifetimes>.made
    }

    method lifetimes($/) {
        make $<lifetime-and_bounds>>>.made
    }

    method lifetime-and_bounds:sym<a>($/) {
        make lifetime.new(
            maybe-ltbounds =>  $<maybe-ltbounds>.made,
        )
    }

    method lifetime-and_bounds:sym<b>($/) {
        make static_lifetime.new
    }

    #------------------
    method lifetime:sym<a>($/) { make lifetime.new() }
    method lifetime:sym<b>($/) { make static_lifetime.new }
}
