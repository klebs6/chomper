use grust-model;

our role GenericParams::Rules {

    rule generic-params { <generic-params-base>? }

    proto rule generic-params-base { * }

    rule generic-params-base:sym<a> { '<' '>' }
    rule generic-params-base:sym<b> { '<' <lifetimes> '>' }
    rule generic-params-base:sym<c> { '<' <lifetimes> ',' '>' }
    rule generic-params-base:sym<f> { '<' <lifetimes> ',' <ty-params> '>' }
    rule generic-params-base:sym<g> { '<' <lifetimes> ',' <ty-params> ',' '>' }
    rule generic-params-base:sym<j> { '<' <ty-params> '>' }
    rule generic-params-base:sym<k> { '<' <ty-params> ',' '>' }
}

our role GenericParams::Actions {

    method generic-params($/) {
        make $<generic-params-base>.made
    }

    method generic-params-base:sym<a>($/) {
        make Generics.new(

        )
    }

    method generic-params-base:sym<b>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
        )
    }

    method generic-params-base:sym<c>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
        )
    }

    method generic-params-base:sym<f>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params-base:sym<g>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params-base:sym<j>($/) {
        make Generics.new(
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params-base:sym<k>($/) {
        make Generics.new(
            ty-params =>  $<ty-params>.made,
        )
    }
}
