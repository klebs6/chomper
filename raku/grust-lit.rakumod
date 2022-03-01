use grust-model;

#----------------------------------
our role Lit::Rules {

    proto rule lit { * }

    rule lit:sym<a> { <lit-byte> }
    rule lit:sym<b> { <lit-char> }
    rule lit:sym<c> { <lit-int> }
    rule lit:sym<d> { <lit-float> }
    rule lit:sym<e> { <kw-true> }
    rule lit:sym<f> { <kw-false> }
    rule lit:sym<g> { <str> }
}

our role Lit::Actions {

    method lit:sym<a>($/) {
        make LitByte.new( val => ~$/)
    }

    method lit:sym<b>($/) {
        make LitChar.new( val => ~$/)
    }

    method lit:sym<c>($/) {
        make LitInteger.new( val => ~$/)
    }

    method lit:sym<d>($/) {
        make LitFloat.new( val => ~$/)
    }

    method lit:sym<e>($/) {
        make LitBool.new( val => ~$/)
    }

    method lit:sym<f>($/) {
        make LitBool.new( val => ~$/)
    }

    method lit:sym<g>($/) {
        make $<str>.made
    }
}
