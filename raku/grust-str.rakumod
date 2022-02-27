use grust-model;

our role String::Rules {

    proto rule str { * }

    rule str:sym<a> { <LIT-STR> }
    rule str:sym<b> { <LIT-STR_RAW> }
    rule str:sym<c> { <LIT-BYTE_STR> }
    rule str:sym<d> { <LIT-BYTE_STR_RAW> }
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
