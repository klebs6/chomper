our role Python3ShortBytes {

    token SHORT_BYTES_SINGLE_QUOTED {
        '\''
            [    
                | <SHORT_BYTES_CHAR_NO_SINGLE_QUOTE>
                | <BYTES_ESCAPE_SEQ>
            ]*
        '\''
    }

    token SHORT_BYTES_DOUBLE_QUOTED {
        '"'
        [    
            | <SHORT_BYTES_CHAR_NO_DOUBLE_QUOTE>
            | <BYTES_ESCAPE_SEQ>
        ]*
        '"'
    }

    token SHORT_BYTES {
        | <SHORT_BYTES_SINGLE_QUOTED>
        | <SHORT_BYTES_DOUBLE_QUOTED>
    }

    token SHORT_BYTES_CHAR_NO_SINGLE_QUOTE {
        || <[ \x[0000] .. \x[0009] ]>
        || <[ \x[000B] .. \x[000C] ]>
        || <[ \x[000E] .. \x[0026] ]>
        || <[ \x[0028] .. \x[005B] ]>
        || <[ \x[005D] .. \x[007F] ]>
    }

    token SHORT_BYTES_CHAR_NO_DOUBLE_QUOTE {
        || <[ \x[0000] .. \x[0009] ]>
        || <[ \x[000B] .. \x[000C] ]>
        || <[ \x[000E] .. \x[0021] ]>
        || <[ \x[0023] .. \x[005B] ]>
        || <[ \x[005D] .. \x[007F] ]>
    }
}

our role Python3LongBytes {

    token LONG_BYTES {
        || '\'\'\'' <LONG_BYTES_ITEM>*?  '\'\'\''
        || '"""' <LONG_BYTES_ITEM>*?  '"""'
    }

    token LONG_BYTES_ITEM {
        || <LONG_BYTES_CHAR>
        || <BYTES_ESCAPE_SEQ>
    }


    token LONG_BYTES_CHAR {
        || <[ \x[0000] .. \x[005B] ]>
        || <[ \x[005D] .. \x[007F] ]>
    }
}

our role Python3Bytes 
does Python3ShortBytes
does Python3LongBytes {

    token BYTES_LITERAL {
        <[ b B ]>
        <[ r R ]>?
        [    
            || <SHORT_BYTES>
            || <LONG_BYTES>
        ]
    }

    token BYTES_ESCAPE_SEQ {
        '\\' <[ \x[0000] .. \x[007F] ]>
    }
}

