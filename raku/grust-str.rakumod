use grust-model;

our role String::Rules {

    proto rule str { * }

    rule str:sym<a> { <lit-str> }
    rule str:sym<b> { <lit-str-raw> }
    rule str:sym<c> { <lit-byte-str> }
    rule str:sym<d> { <lit-byte-str-raw> }
}

our role String::Actions {

    method str:sym<a>($/) {
        make LitStr.new( value => ~$/)
    }

    method str:sym<b>($/) {
        make LitStr.new( value => ~$/)
    }

    method str:sym<c>($/) {
        make LitByteStr.new( value => ~$/)
    }

    method str:sym<d>($/) {
        make LitByteStr.new( value => ~$/)
    }
}
