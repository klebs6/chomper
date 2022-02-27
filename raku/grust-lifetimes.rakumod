use grust-model;

our role Lifetimes::Rules {

    rule maybe-lifetimes { [<lifetimes> ','?]? }

    rule lifetimes {
        <lifetime-and-bounds>+ %% ","
    }

    #---------------------
    proto rule lifetime-and-bounds { * }
    rule lifetime-and-bounds:sym<a> { <LIFETIME> <maybe-ltbounds> }
    rule lifetime-and-bounds:sym<b> { <STATIC-LIFETIME> }

    proto rule lifetime { * }
    rule lifetime:sym<a> { <LIFETIME> }
    rule lifetime:sym<b> { <STATIC-LIFETIME> }
}

our role Lifetimes::Actions {

    method maybe-lifetimes($/) {
        make $<lifetimes>.made
    }

    method lifetimes($/) {
        make $<lifetime-and-bounds>>>.made
    }

    method lifetime-and-bounds:sym<a>($/) {
        make Lifetime.new(
            maybe-ltbounds =>  $<maybe-ltbounds>.made,
        )
    }

    method lifetime-and-bounds:sym<b>($/) {
        make StaticLifetime.new
    }

    #------------------
    method lifetime:sym<a>($/) { make Lifetime.new() }
    method lifetime:sym<b>($/) { make StaticLifetime.new }
}

