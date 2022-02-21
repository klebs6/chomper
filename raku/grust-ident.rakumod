our class Ident::Rules {

    proto rule maybe-ident { * }

    rule maybe-ident:sym<a> {

    }

    rule maybe-ident:sym<b> {
        <ident>
    }

    proto rule ident { * }

    rule ident:sym<a> {
        <IDENT>
    }

    # Weak keywords that can be used as identifiers
    rule ident:sym<b> {
        <CATCH>
    }

    rule ident:sym<c> {
        <DEFAULT>
    }

    rule ident:sym<d> {
        <UNION>
    }
}

our class Ident::Actions {

    method maybe-ident:sym<a>($/) {
        MkNone<140277797979904>
    }

    method maybe-ident:sym<b>($/) {
        make $<ident>.made
    }

    method ident:sym<a>($/) {
        make ident.new(

        )
    }

    method ident:sym<b>($/) {
        make ident.new(

        )
    }

    method ident:sym<c>($/) {
        make ident.new(

        )
    }

    method ident:sym<d>($/) {
        make ident.new(

        )
    }
}
