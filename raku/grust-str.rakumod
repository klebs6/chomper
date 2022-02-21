our class String::G {

    proto rule str { * }

    rule str:sym<a> {
        <LIT-STR>
    }

    rule str:sym<b> {
        <LIT-STR_RAW>
    }

    rule str:sym<c> {
        <LIT-BYTE_STR>
    }

    rule str:sym<d> {
        <LIT-BYTE_STR_RAW>
    }
}

our class String::A {

    method str:sym<a>($/) {
        make LitStr.new(

        )
    }

    method str:sym<b>($/) {
        make LitStr.new(

        )
    }

    method str:sym<c>($/) {
        make LitByteStr.new(

        )
    }

    method str:sym<d>($/) {
        make LitByteStr.new(

        )
    }
}


