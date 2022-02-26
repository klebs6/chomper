our class Generics {
    has $.ty_params;
    has $.lifetimes;
}

our class GenericParams::Rules {

    proto rule generic-params { * }

    rule generic-params:sym<a> { '<' '>' }
    rule generic-params:sym<b> { '<' <lifetimes> '>' }
    rule generic-params:sym<c> { '<' <lifetimes> ',' '>' }
    rule generic-params:sym<f> { '<' <lifetimes> ',' <ty-params> '>' }
    rule generic-params:sym<g> { '<' <lifetimes> ',' <ty-params> ',' '>' }
    rule generic-params:sym<j> { '<' <ty-params> '>' }
    rule generic-params:sym<k> { '<' <ty-params> ',' '>' }
    rule generic-params:sym<n> { }
}

our class GenericParams::Actions {

    method generic-params:sym<a>($/) {
        make Generics.new(

        )
    }

    method generic-params:sym<b>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
        )
    }

    method generic-params:sym<c>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
        )
    }

    method generic-params:sym<f>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<g>($/) {
        make Generics.new(
            lifetimes =>  $<lifetimes>.made,
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<j>($/) {
        make Generics.new(
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<k>($/) {
        make Generics.new(
            ty-params =>  $<ty-params>.made,
        )
    }

    method generic-params:sym<n>($/) {
        MkNone<140527400197696>
    }
}
