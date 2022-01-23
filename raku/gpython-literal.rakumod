
our role Python3Literal {

    token string {
        | <STRING_LITERAL>
        | <BYTES_LITERAL>
    }

    token number {
        | <integer>
        | <FLOAT_NUMBER>
        | <IMAG_NUMBER>
    }

    token IMAG_NUMBER {
        [    
            | <FLOAT_NUMBER>
            | <INT_PART>
        ]
        <[ j J ]>
    }
}
