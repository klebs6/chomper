our role Python3String 
does Python3ShortString
does Python3LongString
{

    token STRING_LITERAL {
        <[ u U ]>?
        <[ r R ]>?
        [    
            | <SHORT_STRING>
            | <LONG_STRING>
        ]
    }

    token STRING_ESCAPE_SEQ {
        '\\' .
    }
}

our role Python3ShortString {

    token SHORT_STRING_SINGLE_QUOTED {
        '\''
        [    
            | <STRING_ESCAPE_SEQ>
            | <-[ \\ \r \n \' ]>
        ]*
        '\''
    }

    token SHORT_STRING_DOUBLE_QUOTED {
        '"'
        [    
            | <STRING_ESCAPE_SEQ>
            | <-[ \\ \r \n " ]>
        ]*
        '"'
    }

    token SHORT_STRING {
        | <SHORT_STRING_SINGLE_QUOTED>
        | <SHORT_STRING_DOUBLE_QUOTED>
    }

}

our role Python3LongString {

    token LONG_STRING_TRIPLE_DOUBLE_QUOTES {
        '"""'
        <LONG_STRING_ITEM>*?
        '"""'
    }

    token LONG_STRING_TRIPLE_SINGLE_QUOTES {
        '\'\'\''
        <LONG_STRING_ITEM>*?
        '\'\'\''
    }

    token LONG_STRING {
        | <LONG_STRING_TRIPLE_SINGLE_QUOTES>
        | <LONG_STRING_TRIPLE_DOUBLE_QUOTES>
    }

    token LONG_STRING_ITEM {
        | <LONG_STRING_CHAR>
        | <STRING_ESCAPE_SEQ>
    }

    token LONG_STRING_CHAR {
        <-[ \\ ]>
    }

}
