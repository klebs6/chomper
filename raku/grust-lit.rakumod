our class Lit::Rules {

    proto rule lit { * }

    rule lit:sym<a> { <LIT-BYTE> }
    rule lit:sym<b> { <LIT-CHAR> }
    rule lit:sym<c> { <LIT-INTEGER> }
    rule lit:sym<d> { <LIT-FLOAT> }
    rule lit:sym<e> { <TRUE> }
    rule lit:sym<f> { <FALSE> }
    rule lit:sym<g> { <str> }
}

our class Lit::Actions {

    method lit:sym<a>($/) {
        make LitByte.new(

        )
    }

    method lit:sym<b>($/) {
        make LitChar.new(

        )
    }

    method lit:sym<c>($/) {
        make LitInteger.new(

        )
    }

    method lit:sym<d>($/) {
        make LitFloat.new(

        )
    }

    method lit:sym<e>($/) {
        make LitBool.new(

        )
    }

    method lit:sym<f>($/) {
        make LitBool.new(

        )
    }

    method lit:sym<g>($/) {
        make $<str>.made
    }
}
