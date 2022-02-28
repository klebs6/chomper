use grust-model;

our role Ident::Rules {

    rule maybe-ident {
        <ident>?
    }

    proto rule ident { * }

    rule ident:sym<ident>   { <ident_> }

    # Weak keywords that can be used as identifiers
    rule ident:sym<catch>   { <catch> }
    rule ident:sym<default> { <default_> }
    rule ident:sym<union>   { <union> }
}

our role Ident::Actions {

    method maybe-ident($/) {
        make $<ident>.made
    }

    method ident:sym<ident>($/) {
        make Ident.new(value => ~$/)
    }

    method ident:sym<catch>($/) {
        make Ident.new(value => ~$/)
    }

    method ident:sym<default>($/) {
        make Ident.new(value => ~$/)
    }

    method ident:sym<union>($/) {
        make Ident.new(value => ~$/)
    }
}
