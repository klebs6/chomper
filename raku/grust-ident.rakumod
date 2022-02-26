our class Ident::Rules {

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

our class Ident::Actions {

    method maybe-ident($/) {
        make $<ident>.made
    }

    method ident:sym<ident>($/) {
        make ident.new(value => ~$/)
    }

    method ident:sym<catch>($/) {
        make ident.new(value => ~$/)
    }

    method ident:sym<default>($/) {
        make ident.new(value => ~$/)
    }

    method ident:sym<union>($/) {
        make ident.new(value => ~$/)
    }
}
