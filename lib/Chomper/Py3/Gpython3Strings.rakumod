our role Python3ShortBytes {

    regex SINGLE_QUOTED_SHORT_BYTES {
       "'"
       <SINGLE_QUOTED_SHORT_BYTES_INNER>
       "'"
    }

    regex SINGLE_QUOTED_SHORT_BYTES_INNER {
       [    
           || <SHORT_BYTES_CHAR_NO_SINGLE_QUOTE>
           || <BYTES_ESCAPE_SEQ>
       ]*
    }

    regex DOUBLE_QUOTED_SHORT_BYTES {
       '"'
       <DOUBLE_QUOTED_SHORT_BYTES_INNER>
       '"'
    }

    regex DOUBLE_QUOTED_SHORT_BYTES_INNER {
       [    
           || <SHORT_BYTES_CHAR_NO_DOUBLE_QUOTE>
           || <BYTES_ESCAPE_SEQ>
       ]*
    }

    proto regex SHORT_BYTES { * }
    regex SHORT_BYTES:sym<single> { <SINGLE_QUOTED_SHORT_BYTES> }
    regex SHORT_BYTES:sym<double> { <DOUBLE_QUOTED_SHORT_BYTES> }

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

    proto regex LONG_BYTES { * }
    regex LONG_BYTES:sym<single> { <.ws> <SINGLE_QUOTED_LONG_BYTES> <.ws> }
    regex LONG_BYTES:sym<double> { <.ws> <DOUBLE_QUOTED_LONG_BYTES> <.ws> }

    regex SINGLE_QUOTED_LONG_BYTES {
        "'''" <LONG_BYTES_INNER> "'''"
    }

    regex DOUBLE_QUOTED_LONG_BYTES {
        '"""' <LONG_BYTES_INNER> '"""'
    }

    regex LONG_BYTES_INNER {
        <LONG_BYTES_ITEM>*? 
    }

    token LONG_BYTES_ITEM {
        | <BYTES_ESCAPE_SEQ>
        | <LONG_BYTES_CHAR>
    }

    token LONG_BYTES_CHAR {
        || <[ \x[0000] .. \x[005B] ]>
        || <[ \x[005D] .. \x[007F] ]>
    }
}



our role Python3ShortString {

    proto regex SHORT_STRING { * }
    regex SHORT_STRING:sym<single> { <.ws> <SINGLE_QUOTED_SHORT_STRING> <.ws> }
    regex SHORT_STRING:sym<double> { <.ws> <DOUBLE_QUOTED_SHORT_STRING> <.ws> }

    regex SINGLE_QUOTED_SHORT_STRING {
         "'"
         <SINGLE_QUOTED_SHORT_STRING_INNER>
         "'"
    }

    regex SINGLE_QUOTED_SHORT_STRING_INNER {
         [   
             ||    <STRING_ESCAPE_SEQ>
             ||    <-[ \\ \r \n \' ]>
         ]*
    }

    regex DOUBLE_QUOTED_SHORT_STRING {
        '"'
        <DOUBLE_QUOTED_SHORT_STRING_INNER>
        '"'
    }

    regex DOUBLE_QUOTED_SHORT_STRING_INNER {
        [    
            ||    <STRING_ESCAPE_SEQ>
            ||    <-[ \\ \r \n " ]>
        ]*
    }
}

our role Python3LongString {

    regex SINGLE_QUOTED_LONG_STRING {
        "'''" 
        <SINGLE_QUOTED_LONG_STRING_INNER>
        "'''"
    }

    regex SINGLE_QUOTED_LONG_STRING_INNER {
        <?after "'''"> 
        <LONG_STRING_ITEM>*? 
        <?before "'''">
    }

    regex DOUBLE_QUOTED_LONG_STRING {
        '"""' 
        <DOUBLE_QUOTED_LONG_STRING_INNER>
        '"""'
    }

    regex DOUBLE_QUOTED_LONG_STRING_INNER {
        <?after '"""'>
        <LONG_STRING_ITEM>*? 
        <?before '"""'>
    }

    proto token LONG_STRING { * }
    token LONG_STRING:sym<single> { <SINGLE_QUOTED_LONG_STRING> }
    token LONG_STRING:sym<double> { <DOUBLE_QUOTED_LONG_STRING> }

    token LONG_STRING_ITEM {
        | <LONG_STRING_CHAR>
        | <STRING_ESCAPE_SEQ>
    }

    token LONG_STRING_CHAR {
        ||    <-[ \\ ]>
    }
}

our role Python3String 
does Python3ShortBytes
does Python3LongBytes
does Python3ShortString
does Python3LongString {

    proto token string { * }

    token string:sym<long-string>  { <long-string> }
    token string:sym<short-string> { <short-string> }
    token string:sym<long-bytes>   { <long-bytes> }
    token string:sym<short-bytes>  { <short-bytes> }

    token short-string { <string-prefix> <SHORT_STRING> }
    token long-string  { <string-prefix> <LONG_STRING> }
    token short-bytes  { <bytes-prefix>  <SHORT_BYTES> }
    token long-bytes   { <bytes-prefix>  <LONG_BYTES> }

    token string-prefix {
        <[ u U ]>?  
        <[ r R ]>?  
        <[ f F ]>?  
        <[ r R ]>?  
        <bytes-prefix>? #can we do this?
    }
    token bytes-prefix {
        <[ b B ]> <[ r R ]>?  
    }

    token UNKNOWN_CHAR {
        ||    .
    }

    token STRING_ESCAPE_SEQ {
        \\ .
    }

    token BYTES_ESCAPE_SEQ {
        ||    '\\' <[ \x[0000] .. \x[007F] ]>
    }
}
