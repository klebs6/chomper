
our role Python3Digit {
    token NON_ZERO_DIGIT { <[ 1 .. 9 ]> }
    token DIGIT          { <[ 0 .. 9 ]> }
    token OCT_DIGIT      { <[ 0 .. 7 ]> }
    token HEX_DIGIT      { <[ 0 .. 9 a .. f A .. F ]> }
    token BIN_DIGIT      { <[ 0 1 ]>    }
}

our role Python3Integer {

    token DECIMAL_INTEGER {
        || <NON_ZERO_DIGIT> [<DIGIT> | <UNDERSCORE>]*
        || '0'+
    }

    token OCT_INTEGER {
        '0' <[ o O ]> <OCT_DIGIT> [<OCT_DIGIT> | <UNDERSCORE>]*
    }

    token HEX_INTEGER {
        '0' <[ x X ]> <HEX_DIGIT> [<HEX_DIGIT> | <UNDERSCORE>]*
    }

    token BIN_INTEGER {
        '0' <[ b B ]> <BIN_DIGIT> [<BIN_DIGIT> | <UNDERSCORE>]*
    }

    token integer {
        | <HEX_INTEGER>
        | <DECIMAL_INTEGER>
        | <OCT_INTEGER>
        | <BIN_INTEGER>
    }
}

our role Python3Float {

    token FLOAT_NUMBER {
        | <POINT_FLOAT>
        | <EXPONENT_FLOAT>
    }

    token POINT_FLOAT {
        | <INT_PART>?  <FRACTION>
        | <INT_PART> <DOT>
    }

    token EXPONENT_FLOAT {
        [ 
            | <INT_PART>
            | <POINT_FLOAT>
        ]
        <EXPONENT>
    }

    token INT_PART {
        <DIGIT>+
    }

    token FRACTION {
        <DOT> <DIGIT>+
    }

    token EXPONENT {
        <[ e E ]> <[ + - ]>?  <DIGIT>+
    }
}

our role Python3Number 
does Python3Digit
does Python3Integer 
does Python3Float {

    proto token number { * }
    token number:sym<integer> { <integer> }
    token number:sym<float>   { <FLOAT_NUMBER> }
    token number:sym<imag>    { <IMAG_NUMBER> }

    token IMAG_NUMBER {
        [    
          | <FLOAT_NUMBER>
          | <INT_PART>
        ] 
        <[ j J ]>
    }
}

