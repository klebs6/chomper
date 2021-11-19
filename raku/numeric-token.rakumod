our role NumericToken {

    token numeric-value {
        [ '+' | '-' | '~' ]? 
        <[ 0..9 ]>+ 
        [ '.' <[ 0..9 ]>* ]? 
        [ 'e' <.numeric-value> ]? 
    }

    token numeric-suffix {
        | 'f'
        | 'F'
        | 'u'
        | 'U'
    }

    token numeric {
        <numeric-value> <numeric-suffix>? 
    }

    token hexadecimal {
        [ '+' | '-' | '~' ]?
        [ "0x" | '0X' ] <[ A..F a..f 0..9 ]>+     
    }
}
