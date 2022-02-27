use grust-model;

our role Ident::Rules {

    rule maybe-ident {
        <ident>?
    }

    proto rule ident { * }

    rule ident:sym<ident>   { <IDENT> }

    # Weak keywords that can be used as identifiers
    rule ident:sym<catch>   { <CATCH> }
    rule ident:sym<default> { <DEFAULT> }
    rule ident:sym<union>   { <UNION> }
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
