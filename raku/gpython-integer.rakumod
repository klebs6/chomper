
our role Python3Integer {

    token integer {
        | <DECIMAL_INTEGER>
        | <OCT_INTEGER>
        | <HEX_INTEGER>
        | <BIN_INTEGER>
    }

    token ZEROES {
        '0'+
    }

    token DECIMAL_INTEGER {
        | <NON_ZERO_DIGIT> <DIGIT>*
        | <ZEROES>
    }

    token OCT_INTEGER { '0' <[ o O ]> <OCT_DIGIT>+ }
    token HEX_INTEGER { '0' <[ x X ]> <HEX_DIGIT>+ }
    token BIN_INTEGER { '0' <[ b B ]> <BIN_DIGIT>+ }
}
