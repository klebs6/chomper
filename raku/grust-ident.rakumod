use grust-model;

our role Ident::Rules {

    rule maybe-ident {
        <ident>?
    }

    proto rule ident { * }

    rule ident:sym<ident>   { <ident_> }

    # Weak keywords that can be used as identifiers
    rule ident:sym<catch>   { <kw-catch> }
    rule ident:sym<default> { <kw-default> }
    rule ident:sym<union>   { <kw-union> }
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
