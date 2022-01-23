
our role Python3Float {

    token FLOAT_NUMBER {
        | <POINT_FLOAT>
        | <EXPONENT_FLOAT>
    }

    token POINT_FLOAT {
        | <INT_PART>?  <FRACTION>
        | <INT_PART> '.'
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
        '.' <DIGIT>+
    }

    token EXPONENT {
        <[ e E ]> <[ + - ]>?  <DIGIT>+
    }

    token NON_ZERO_DIGIT { <[ 1 .. 9 ]> }
    token DIGIT          { <[ 0 .. 9 ]> }
    token OCT_DIGIT      { <[ 0 .. 7 ]> }
    token HEX_DIGIT      { <[ 0 .. 9 ]> }
    token BIN_DIGIT      { <[ 0 1 ]> }
}
