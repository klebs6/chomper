our class NEW_INDENTATION { }

#-------------------------------------------------------------------
our role Python3Braces {
    token OPEN_PAREN         { '('  {$*opened++; }} 
    token CLOSE_PAREN        { ')'  {$*opened--; }} 
    token OPEN_BRACK         { '['  {$*opened++; }} 
    token CLOSE_BRACK        { ']'  {$*opened--; }} 
    token OPEN_BRACE         { '{'  {$*opened++; }} 
    token CLOSE_BRACE        { '}'  {$*opened--; }} 
}

our role Python3Operators {

    proto token augassign { * }
    token augassign:sym<PLUS_EQUALS>      { <PLUS_EQUALS> }
    token augassign:sym<MINUS_EQUALS>     { <MINUS_EQUALS> }
    token augassign:sym<STAR_EQUALS>      { <STAR_EQUALS> }
    token augassign:sym<AT_EQUALS>        { <AT_EQUALS> }
    token augassign:sym<DIV_EQUALS>       { <DIV_EQUALS> }
    token augassign:sym<MOD_EQUALS>       { <MOD_EQUALS> }
    token augassign:sym<AMPERSAND_EQUALS> { <AMPERSAND_EQUALS> }
    token augassign:sym<PIPE_EQUALS>      { <PIPE_EQUALS> }
    token augassign:sym<CARET_EQUALS>     { <CARET_EQUALS> }
    token augassign:sym<LSHIFT_EQUALS>    { <LSHIFT_EQUALS> }
    token augassign:sym<RSHIFT_EQUALS>    { <RSHIFT_EQUALS> }
    token augassign:sym<STARSTAR_EQUALS>  { <STARSTAR_EQUALS> }
    token augassign:sym<DIVDIV_EQUALS>    { <DIVDIV_EQUALS> }

    proto token comp-op { * }
    token comp-op:sym<NOT_IN>       { <NOT_IN> }
    token comp-op:sym<IN>           { <IN> }
    token comp-op:sym<IS_NOT>       { <IS_NOT> }
    token comp-op:sym<IS>           { <IS> }
    token comp-op:sym<LESS_THAN>    { <LESS_THAN> }
    token comp-op:sym<GREATER_THAN> { <GREATER_THAN> }
    token comp-op:sym<EQUALS>       { <EQUALS> }
    token comp-op:sym<GT_EQ>        { <GT_EQ> }
    token comp-op:sym<LT_EQ>        { <LT_EQ> }
    token comp-op:sym<NOT_EQ_1>     { <NOT_EQ_1> }
    token comp-op:sym<NOT_EQ_2>     { <NOT_EQ_2> }

    rule NOT_IN { <NOT> <IN>  }
    rule IS_NOT { <IS>  <NOT> }

    token SLASH            { '/'  }
    token BACKSLASH        { '\\'  }
    token PLUS_EQUALS      { '+=' }
    token MINUS_EQUALS     { '-=' }
    token STAR_EQUALS      { '*=' }
    token AT_EQUALS        { '@=' }
    token DIV_EQUALS       { '/=' }
    token MOD_EQUALS       { '%=' }
    token AMPERSAND_EQUALS { '&=' }
    token PIPE_EQUALS      { '|=' }
    token CARET_EQUALS     { '^=' }
    token LSHIFT_EQUALS    { '<<=' }
    token RSHIFT_EQUALS    { '>>=' }
    token STARSTAR_EQUALS  { '**=' }
    token DIVDIV_EQUALS    { '//=' }
    token DOT              { '.'   }
    token POUND            { '#'   }
    token ELLIPSIS         { '...' }
    token STAR             { '*'   }
    token COMMA            { ','   }
    token COLON            { ':'   }
    token SEMI_COLON       { ';'   }
    token POWER            { '**'  }
    token ASSIGN           { '='   }
    token OR_OP            { '|'   }
    token XOR              { '^'   }
    token AND_OP           { '&'   }
    token LEFT_SHIFT       { '<<'  }
    token RIGHT_SHIFT      { '>>'  }
    token ADD              { <PLUS>   }
    token MINUS            { '-'   }
    token PLUS             { '+'   }
    token DIV              { <.SLASH> }
    token MOD              { '%'   }
    token IDIV             { '//'  }
    token NOT_OP           { '~'   }
    token LESS_THAN        { '<'   }
    token GREATER_THAN     { '>'   }
    token EQUALS           { '=='  }
    token GT_EQ            { '>='  }
    token LT_EQ            { '<='  }
    token NOT_EQ_1         { '<>'  }
    token NOT_EQ_2         { '!='  }
    token AT               { '@'   }
    token ARROW            { '->'  }
    token UNDERSCORE       { '_'   }
}

our role Python3Keywords {
    token DEF      { 'def'      } 
    token RETURN   { 'return'   } 
    token RAISE    { 'raise'    } 
    token FROM     { 'from'     } 
    token IMPORT   { 'import'   } 
    token AS       { 'as'       } 
    token GLOBAL   { 'global'   } 
    token NONLOCAL { 'nonlocal' } 
    token ASSERT   { 'assert'   } 
    token IF       { 'if'       } 
    token ELIF     { 'elif'     } 
    token ELSE     { 'else'     } 
    token WHILE    { 'while'    } 
    token FOR      { 'for'      } 
    token IN       { 'in'       } 
    token TRY      { 'try'      } 
    token FINALLY  { 'finally'  } 
    token WITH     { 'with'     } 
    token EXCEPT   { 'except'   } 
    token LAMBDA   { 'lambda'   } 
    token OR       { 'or'       } 
    token AND      { 'and'      } 
    token NOT      { 'not'      } 
    token IS       { 'is'       } 
    token NONE     { 'None'     } 
    token TRUE     { 'True'     } 
    token FALSE    { 'False'    } 
    token CLASS    { 'class'    } 
    token YIELD    { 'yield'    } 
    token DEL      { 'del'      } 
    token PASS     { 'pass'     } 
    token CONTINUE { 'continue' } 
    token BREAK    { 'break'    } 
}

our role Python3Digit {
    token NON_ZERO_DIGIT { <[ 1 .. 9 ]> }
    token DIGIT          { <[ 0 .. 9 ]> }
    token OCT_DIGIT      { <[ 0 .. 7 ]> }
    token HEX_DIGIT      { <[ 0 .. 9 a .. f A .. F ]> }
    token BIN_DIGIT      { <[ 0 1 ]>    }
}

#-------------------------------------------------------------------
our role Python3ShortBytes {

    regex SINGLE_QUOTED_SHORT_BYTES {
       "'"
       [    
           || <SHORT_BYTES_CHAR_NO_SINGLE_QUOTE>
           || <BYTES_ESCAPE_SEQ>
       ]*
       "'"
    }

    regex DOUBLE_QUOTED_SHORT_BYTES {
       '"'
       [    
           || <SHORT_BYTES_CHAR_NO_DOUBLE_QUOTE>
           || <BYTES_ESCAPE_SEQ>
       ]*
       '"'
    }

    regex SHORT_BYTES {
        | <SINGLE_QUOTED_SHORT_BYTES>
        | <DOUBLE_QUOTED_SHORT_BYTES>
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

    regex SINGLE_QUOTED_LONG_BYTES {
        "'''" <LONG_BYTES_ITEM>*?  "'''"
    }

    regex DOUBLE_QUOTED_LONG_BYTES {
        '"""' <LONG_BYTES_ITEM>*?  '"""'
    }

    regex LONG_BYTES {
        | <SINGLE_QUOTED_LONG_BYTES>
        | <DOUBLE_QUOTED_LONG_BYTES>
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

    regex SINGLE_QUOTED_SHORT_STRING {
         "'"
         [   
             ||    <STRING_ESCAPE_SEQ>
             ||    <-[ \\ \r \n \' ]>
         ]*
         "'"
    }

    regex DOUBLE_QUOTED_SHORT_STRING {
        '"'
        [    
            ||    <STRING_ESCAPE_SEQ>
            ||    <-[ \\ \r \n " ]>
        ]*
        '"'
    }

    token SHORT_STRING {
        || <SINGLE_QUOTED_SHORT_STRING>
        || <DOUBLE_QUOTED_SHORT_STRING>
    }
}

our role Python3LongString {

    token SINGLE_QUOTED_LONG_STRING {
        "'''" <LONG_STRING_ITEM>*?  "'''"
    }

    token DOUBLE_QUOTED_LONG_STRING {
        '"""' <LONG_STRING_ITEM>*?  '"""'
    }

    token LONG_STRING {
        || <SINGLE_QUOTED_LONG_STRING>
        || <DOUBLE_QUOTED_LONG_STRING>
    }

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

    token string { 
        || <long-string>
        || <short-string>
        || <long-bytes>
        || <short-bytes>
    }

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

#-------------------------------------------------------------------
our role Python3Name {

    token NAME {
        <ID_START> <ID_CONTINUE>*
    }

    token dotted_name {
        <NAME> [    <DOT> <NAME> ]*
    }

    token ID_START {
        ||    <UNDERSCORE>
        ||    <[ A .. Z ]>
        ||    <[ a .. z ]>
        ||    '\x[00AA]'
        ||    '\x[00B5]'
        ||    '\x[00BA]'
        ||    <[ \x[00C0] .. \x[00D6] ]>
        ||    <[ \x[00D8] .. \x[00F6] ]>
        ||    <[ \x[00F8] .. \x[01BA] ]>
        ||    '\x[01BB]'
        ||    <[ \x[01BC] .. \x[01BF] ]>
        ||    <[ \x[01C0] .. \x[01C3] ]>
        ||    <[ \x[01C4] .. \x[0241] ]>
        ||    <[ \x[0250] .. \x[02AF] ]>
        ||    <[ \x[02B0] .. \x[02C1] ]>
        ||    <[ \x[02C6] .. \x[02D1] ]>
        ||    <[ \x[02E0] .. \x[02E4] ]>
        ||    '\x[02EE]'
        ||    '\x[037A]'
        ||    '\x[0386]'
        ||    <[ \x[0388] .. \x[038A] ]>
        ||    '\x[038C]'
        ||    <[ \x[038E] .. \x[03A1] ]>
        ||    <[ \x[03A3] .. \x[03CE] ]>
        ||    <[ \x[03D0] .. \x[03F5] ]>
        ||    <[ \x[03F7] .. \x[0481] ]>
        ||    <[ \x[048A] .. \x[04CE] ]>
        ||    <[ \x[04D0] .. \x[04F9] ]>
        ||    <[ \x[0500] .. \x[050F] ]>
        ||    <[ \x[0531] .. \x[0556] ]>
        ||    '\x[0559]'
        ||    <[ \x[0561] .. \x[0587] ]>
        ||    <[ \x[05D0] .. \x[05EA] ]>
        ||    <[ \x[05F0] .. \x[05F2] ]>
        ||    <[ \x[0621] .. \x[063A] ]>
        ||    '\x[0640]'
        ||    <[ \x[0641] .. \x[064A] ]>
        ||    <[ \x[066E] .. \x[066F] ]>
        ||    <[ \x[0671] .. \x[06D3] ]>
        ||    '\x[06D5]'
        ||    <[ \x[06E5] .. \x[06E6] ]>
        ||    <[ \x[06EE] .. \x[06EF] ]>
        ||    <[ \x[06FA] .. \x[06FC] ]>
        ||    '\x[06FF]'
        ||    '\x[0710]'
        ||    <[ \x[0712] .. \x[072F] ]>
        ||    <[ \x[074D] .. \x[076D] ]>
        ||    <[ \x[0780] .. \x[07A5] ]>
        ||    '\x[07B1]'
        ||    <[ \x[0904] .. \x[0939] ]>
        ||    '\x[093D]'
        ||    '\x[0950]'
        ||    <[ \x[0958] .. \x[0961] ]>
        ||    '\x[097D]'
        ||    <[ \x[0985] .. \x[098C] ]>
        ||    <[ \x[098F] .. \x[0990] ]>
        ||    <[ \x[0993] .. \x[09A8] ]>
        ||    <[ \x[09AA] .. \x[09B0] ]>
        ||    '\x[09B2]'
        ||    <[ \x[09B6] .. \x[09B9] ]>
        ||    '\x[09BD]'
        ||    '\x[09CE]'
        ||    <[ \x[09DC] .. \x[09DD] ]>
        ||    <[ \x[09DF] .. \x[09E1] ]>
        ||    <[ \x[09F0] .. \x[09F1] ]>
        ||    <[ \x[0A05] .. \x[0A0A] ]>
        ||    <[ \x[0A0F] .. \x[0A10] ]>
        ||    <[ \x[0A13] .. \x[0A28] ]>
        ||    <[ \x[0A2A] .. \x[0A30] ]>
        ||    <[ \x[0A32] .. \x[0A33] ]>
        ||    <[ \x[0A35] .. \x[0A36] ]>
        ||    <[ \x[0A38] .. \x[0A39] ]>
        ||    <[ \x[0A59] .. \x[0A5C] ]>
        ||    '\x[0A5E]'
        ||    <[ \x[0A72] .. \x[0A74] ]>
        ||    <[ \x[0A85] .. \x[0A8D] ]>
        ||    <[ \x[0A8F] .. \x[0A91] ]>
        ||    <[ \x[0A93] .. \x[0AA8] ]>
        ||    <[ \x[0AAA] .. \x[0AB0] ]>
        ||    <[ \x[0AB2] .. \x[0AB3] ]>
        ||    <[ \x[0AB5] .. \x[0AB9] ]>
        ||    '\x[0ABD]'
        ||    '\x[0AD0]'
        ||    <[ \x[0AE0] .. \x[0AE1] ]>
        ||    <[ \x[0B05] .. \x[0B0C] ]>
        ||    <[ \x[0B0F] .. \x[0B10] ]>
        ||    <[ \x[0B13] .. \x[0B28] ]>
        ||    <[ \x[0B2A] .. \x[0B30] ]>
        ||    <[ \x[0B32] .. \x[0B33] ]>
        ||    <[ \x[0B35] .. \x[0B39] ]>
        ||    '\x[0B3D]'
        ||    <[ \x[0B5C] .. \x[0B5D] ]>
        ||    <[ \x[0B5F] .. \x[0B61] ]>
        ||    '\x[0B71]'
        ||    '\x[0B83]'
        ||    <[ \x[0B85] .. \x[0B8A] ]>
        ||    <[ \x[0B8E] .. \x[0B90] ]>
        ||    <[ \x[0B92] .. \x[0B95] ]>
        ||    <[ \x[0B99] .. \x[0B9A] ]>
        ||    '\x[0B9C]'
        ||    <[ \x[0B9E] .. \x[0B9F] ]>
        ||    <[ \x[0BA3] .. \x[0BA4] ]>
        ||    <[ \x[0BA8] .. \x[0BAA] ]>
        ||    <[ \x[0BAE] .. \x[0BB9] ]>
        ||    <[ \x[0C05] .. \x[0C0C] ]>
        ||    <[ \x[0C0E] .. \x[0C10] ]>
        ||    <[ \x[0C12] .. \x[0C28] ]>
        ||    <[ \x[0C2A] .. \x[0C33] ]>
        ||    <[ \x[0C35] .. \x[0C39] ]>
        ||    <[ \x[0C60] .. \x[0C61] ]>
        ||    <[ \x[0C85] .. \x[0C8C] ]>
        ||    <[ \x[0C8E] .. \x[0C90] ]>
        ||    <[ \x[0C92] .. \x[0CA8] ]>
        ||    <[ \x[0CAA] .. \x[0CB3] ]>
        ||    <[ \x[0CB5] .. \x[0CB9] ]>
        ||    '\x[0CBD]'
        ||    '\x[0CDE]'
        ||    <[ \x[0CE0] .. \x[0CE1] ]>
        ||    <[ \x[0D05] .. \x[0D0C] ]>
        ||    <[ \x[0D0E] .. \x[0D10] ]>
        ||    <[ \x[0D12] .. \x[0D28] ]>
        ||    <[ \x[0D2A] .. \x[0D39] ]>
        ||    <[ \x[0D60] .. \x[0D61] ]>
        ||    <[ \x[0D85] .. \x[0D96] ]>
        ||    <[ \x[0D9A] .. \x[0DB1] ]>
        ||    <[ \x[0DB3] .. \x[0DBB] ]>
        ||    '\x[0DBD]'
        ||    <[ \x[0DC0] .. \x[0DC6] ]>
        ||    <[ \x[0E01] .. \x[0E30] ]>
        ||    <[ \x[0E32] .. \x[0E33] ]>
        ||    <[ \x[0E40] .. \x[0E45] ]>
        ||    '\x[0E46]'
        ||    <[ \x[0E81] .. \x[0E82] ]>
        ||    '\x[0E84]'
        ||    <[ \x[0E87] .. \x[0E88] ]>
        ||    '\x[0E8A]'
        ||    '\x[0E8D]'
        ||    <[ \x[0E94] .. \x[0E97] ]>
        ||    <[ \x[0E99] .. \x[0E9F] ]>
        ||    <[ \x[0EA1] .. \x[0EA3] ]>
        ||    '\x[0EA5]'
        ||    '\x[0EA7]'
        ||    <[ \x[0EAA] .. \x[0EAB] ]>
        ||    <[ \x[0EAD] .. \x[0EB0] ]>
        ||    <[ \x[0EB2] .. \x[0EB3] ]>
        ||    '\x[0EBD]'
        ||    <[ \x[0EC0] .. \x[0EC4] ]>
        ||    '\x[0EC6]'
        ||    <[ \x[0EDC] .. \x[0EDD] ]>
        ||    '\x[0F00]'
        ||    <[ \x[0F40] .. \x[0F47] ]>
        ||    <[ \x[0F49] .. \x[0F6A] ]>
        ||    <[ \x[0F88] .. \x[0F8B] ]>
        ||    <[ \x[1000] .. \x[1021] ]>
        ||    <[ \x[1023] .. \x[1027] ]>
        ||    <[ \x[1029] .. \x[102A] ]>
        ||    <[ \x[1050] .. \x[1055] ]>
        ||    <[ \x[10A0] .. \x[10C5] ]>
        ||    <[ \x[10D0] .. \x[10FA] ]>
        ||    '\x[10FC]'
        ||    <[ \x[1100] .. \x[1159] ]>
        ||    <[ \x[115F] .. \x[11A2] ]>
        ||    <[ \x[11A8] .. \x[11F9] ]>
        ||    <[ \x[1200] .. \x[1248] ]>
        ||    <[ \x[124A] .. \x[124D] ]>
        ||    <[ \x[1250] .. \x[1256] ]>
        ||    '\x[1258]'
        ||    <[ \x[125A] .. \x[125D] ]>
        ||    <[ \x[1260] .. \x[1288] ]>
        ||    <[ \x[128A] .. \x[128D] ]>
        ||    <[ \x[1290] .. \x[12B0] ]>
        ||    <[ \x[12B2] .. \x[12B5] ]>
        ||    <[ \x[12B8] .. \x[12BE] ]>
        ||    '\x[12C0]'
        ||    <[ \x[12C2] .. \x[12C5] ]>
        ||    <[ \x[12C8] .. \x[12D6] ]>
        ||    <[ \x[12D8] .. \x[1310] ]>
        ||    <[ \x[1312] .. \x[1315] ]>
        ||    <[ \x[1318] .. \x[135A] ]>
        ||    <[ \x[1380] .. \x[138F] ]>
        ||    <[ \x[13A0] .. \x[13F4] ]>
        ||    <[ \x[1401] .. \x[166C] ]>
        ||    <[ \x[166F] .. \x[1676] ]>
        ||    <[ \x[1681] .. \x[169A] ]>
        ||    <[ \x[16A0] .. \x[16EA] ]>
        ||    <[ \x[16EE] .. \x[16F0] ]>
        ||    <[ \x[1700] .. \x[170C] ]>
        ||    <[ \x[170E] .. \x[1711] ]>
        ||    <[ \x[1720] .. \x[1731] ]>
        ||    <[ \x[1740] .. \x[1751] ]>
        ||    <[ \x[1760] .. \x[176C] ]>
        ||    <[ \x[176E] .. \x[1770] ]>
        ||    <[ \x[1780] .. \x[17B3] ]>
        ||    '\x[17D7]'
        ||    '\x[17DC]'
        ||    <[ \x[1820] .. \x[1842] ]>
        ||    '\x[1843]'
        ||    <[ \x[1844] .. \x[1877] ]>
        ||    <[ \x[1880] .. \x[18A8] ]>
        ||    <[ \x[1900] .. \x[191C] ]>
        ||    <[ \x[1950] .. \x[196D] ]>
        ||    <[ \x[1970] .. \x[1974] ]>
        ||    <[ \x[1980] .. \x[19A9] ]>
        ||    <[ \x[19C1] .. \x[19C7] ]>
        ||    <[ \x[1A00] .. \x[1A16] ]>
        ||    <[ \x[1D00] .. \x[1D2B] ]>
        ||    <[ \x[1D2C] .. \x[1D61] ]>
        ||    <[ \x[1D62] .. \x[1D77] ]>
        ||    '\x[1D78]'
        ||    <[ \x[1D79] .. \x[1D9A] ]>
        ||    <[ \x[1D9B] .. \x[1DBF] ]>
        ||    <[ \x[1E00] .. \x[1E9B] ]>
        ||    <[ \x[1EA0] .. \x[1EF9] ]>
        ||    <[ \x[1F00] .. \x[1F15] ]>
        ||    <[ \x[1F18] .. \x[1F1D] ]>
        ||    <[ \x[1F20] .. \x[1F45] ]>
        ||    <[ \x[1F48] .. \x[1F4D] ]>
        ||    <[ \x[1F50] .. \x[1F57] ]>
        ||    '\x[1F59]'
        ||    '\x[1F5B]'
        ||    '\x[1F5D]'
        ||    <[ \x[1F5F] .. \x[1F7D] ]>
        ||    <[ \x[1F80] .. \x[1FB4] ]>
        ||    <[ \x[1FB6] .. \x[1FBC] ]>
        ||    '\x[1FBE]'
        ||    <[ \x[1FC2] .. \x[1FC4] ]>
        ||    <[ \x[1FC6] .. \x[1FCC] ]>
        ||    <[ \x[1FD0] .. \x[1FD3] ]>
        ||    <[ \x[1FD6] .. \x[1FDB] ]>
        ||    <[ \x[1FE0] .. \x[1FEC] ]>
        ||    <[ \x[1FF2] .. \x[1FF4] ]>
        ||    <[ \x[1FF6] .. \x[1FFC] ]>
        ||    '\x[2071]'
        ||    '\x[207F]'
        ||    <[ \x[2090] .. \x[2094] ]>
        ||    '\x[2102]'
        ||    '\x[2107]'
        ||    <[ \x[210A] .. \x[2113] ]>
        ||    '\x[2115]'
        ||    '\x[2118]'
        ||    <[ \x[2119] .. \x[211D] ]>
        ||    '\x[2124]'
        ||    '\x[2126]'
        ||    '\x[2128]'
        ||    <[ \x[212A] .. \x[212D] ]>
        ||    '\x[212E]'
        ||    <[ \x[212F] .. \x[2131] ]>
        ||    <[ \x[2133] .. \x[2134] ]>
        ||    <[ \x[2135] .. \x[2138] ]>
        ||    '\x[2139]'
        ||    <[ \x[213C] .. \x[213F] ]>
        ||    <[ \x[2145] .. \x[2149] ]>
        ||    <[ \x[2160] .. \x[2183] ]>
        ||    <[ \x[2C00] .. \x[2C2E] ]>
        ||    <[ \x[2C30] .. \x[2C5E] ]>
        ||    <[ \x[2C80] .. \x[2CE4] ]>
        ||    <[ \x[2D00] .. \x[2D25] ]>
        ||    <[ \x[2D30] .. \x[2D65] ]>
        ||    '\x[2D6F]'
        ||    <[ \x[2D80] .. \x[2D96] ]>
        ||    <[ \x[2DA0] .. \x[2DA6] ]>
        ||    <[ \x[2DA8] .. \x[2DAE] ]>
        ||    <[ \x[2DB0] .. \x[2DB6] ]>
        ||    <[ \x[2DB8] .. \x[2DBE] ]>
        ||    <[ \x[2DC0] .. \x[2DC6] ]>
        ||    <[ \x[2DC8] .. \x[2DCE] ]>
        ||    <[ \x[2DD0] .. \x[2DD6] ]>
        ||    <[ \x[2DD8] .. \x[2DDE] ]>
        ||    '\x[3005]'
        ||    '\x[3006]'
        ||    '\x[3007]'
        ||    <[ \x[3021] .. \x[3029] ]>
        ||    <[ \x[3031] .. \x[3035] ]>
        ||    <[ \x[3038] .. \x[303A] ]>
        ||    '\x[303B]'
        ||    '\x[303C]'
        ||    <[ \x[3041] .. \x[3096] ]>
        ||    <[ \x[309B] .. \x[309C] ]>
        ||    <[ \x[309D] .. \x[309E] ]>
        ||    '\x[309F]'
        ||    <[ \x[30A1] .. \x[30FA] ]>
        ||    <[ \x[30FC] .. \x[30FE] ]>
        ||    '\x[30FF]'
        ||    <[ \x[3105] .. \x[312C] ]>
        ||    <[ \x[3131] .. \x[318E] ]>
        ||    <[ \x[31A0] .. \x[31B7] ]>
        ||    <[ \x[31F0] .. \x[31FF] ]>
        ||    <[ \x[3400] .. \x[4DB5] ]>
        ||    <[ \x[4E00] .. \x[9FBB] ]>
        ||    <[ \x[A000] .. \x[A014] ]>
        ||    '\x[A015]'
        ||    <[ \x[A016] .. \x[A48C] ]>
        ||    <[ \x[A800] .. \x[A801] ]>
        ||    <[ \x[A803] .. \x[A805] ]>
        ||    <[ \x[A807] .. \x[A80A] ]>
        ||    <[ \x[A80C] .. \x[A822] ]>
        ||    <[ \x[AC00] .. \x[D7A3] ]>
        ||    <[ \x[F900] .. \x[FA2D] ]>
        ||    <[ \x[FA30] .. \x[FA6A] ]>
        ||    <[ \x[FA70] .. \x[FAD9] ]>
        ||    <[ \x[FB00] .. \x[FB06] ]>
        ||    <[ \x[FB13] .. \x[FB17] ]>
        ||    '\x[FB1D]'
        ||    <[ \x[FB1F] .. \x[FB28] ]>
        ||    <[ \x[FB2A] .. \x[FB36] ]>
        ||    <[ \x[FB38] .. \x[FB3C] ]>
        ||    '\x[FB3E]'
        ||    <[ \x[FB40] .. \x[FB41] ]>
        ||    <[ \x[FB43] .. \x[FB44] ]>
        ||    <[ \x[FB46] .. \x[FBB1] ]>
        ||    <[ \x[FBD3] .. \x[FD3D] ]>
        ||    <[ \x[FD50] .. \x[FD8F] ]>
        ||    <[ \x[FD92] .. \x[FDC7] ]>
        ||    <[ \x[FDF0] .. \x[FDFB] ]>
        ||    <[ \x[FE70] .. \x[FE74] ]>
        ||    <[ \x[FE76] .. \x[FEFC] ]>
        ||    <[ \x[FF21] .. \x[FF3A] ]>
        ||    <[ \x[FF41] .. \x[FF5A] ]>
        ||    <[ \x[FF66] .. \x[FF6F] ]>
        ||    '\x[FF70]'
        ||    <[ \x[FF71] .. \x[FF9D] ]>
        ||    <[ \x[FF9E] .. \x[FF9F] ]>
        ||    <[ \x[FFA0] .. \x[FFBE] ]>
        ||    <[ \x[FFC2] .. \x[FFC7] ]>
        ||    <[ \x[FFCA] .. \x[FFCF] ]>
        ||    <[ \x[FFD2] .. \x[FFD7] ]>
        ||    <[ \x[FFDA] .. \x[FFDC] ]>
    }

    token ID_CONTINUE {
        ||    <ID_START>
        ||    <[ 0 .. 9 ]>
        ||    <[ \x[0300] .. \x[036F] ]>
        ||    <[ \x[0483] .. \x[0486] ]>
        ||    <[ \x[0591] .. \x[05B9] ]>
        ||    <[ \x[05BB] .. \x[05BD] ]>
        ||    '\x[05BF]'
        ||    <[ \x[05C1] .. \x[05C2] ]>
        ||    <[ \x[05C4] .. \x[05C5] ]>
        ||    '\x[05C7]'
        ||    <[ \x[0610] .. \x[0615] ]>
        ||    <[ \x[064B] .. \x[065E] ]>
        ||    <[ \x[0660] .. \x[0669] ]>
        ||    '\x[0670]'
        ||    <[ \x[06D6] .. \x[06DC] ]>
        ||    <[ \x[06DF] .. \x[06E4] ]>
        ||    <[ \x[06E7] .. \x[06E8] ]>
        ||    <[ \x[06EA] .. \x[06ED] ]>
        ||    <[ \x[06F0] .. \x[06F9] ]>
        ||    '\x[0711]'
        ||    <[ \x[0730] .. \x[074A] ]>
        ||    <[ \x[07A6] .. \x[07B0] ]>
        ||    <[ \x[0901] .. \x[0902] ]>
        ||    '\x[0903]'
        ||    '\x[093C]'
        ||    <[ \x[093E] .. \x[0940] ]>
        ||    <[ \x[0941] .. \x[0948] ]>
        ||    <[ \x[0949] .. \x[094C] ]>
        ||    '\x[094D]'
        ||    <[ \x[0951] .. \x[0954] ]>
        ||    <[ \x[0962] .. \x[0963] ]>
        ||    <[ \x[0966] .. \x[096F] ]>
        ||    '\x[0981]'
        ||    <[ \x[0982] .. \x[0983] ]>
        ||    '\x[09BC]'
        ||    <[ \x[09BE] .. \x[09C0] ]>
        ||    <[ \x[09C1] .. \x[09C4] ]>
        ||    <[ \x[09C7] .. \x[09C8] ]>
        ||    <[ \x[09CB] .. \x[09CC] ]>
        ||    '\x[09CD]'
        ||    '\x[09D7]'
        ||    <[ \x[09E2] .. \x[09E3] ]>
        ||    <[ \x[09E6] .. \x[09EF] ]>
        ||    <[ \x[0A01] .. \x[0A02] ]>
        ||    '\x[0A03]'
        ||    '\x[0A3C]'
        ||    <[ \x[0A3E] .. \x[0A40] ]>
        ||    <[ \x[0A41] .. \x[0A42] ]>
        ||    <[ \x[0A47] .. \x[0A48] ]>
        ||    <[ \x[0A4B] .. \x[0A4D] ]>
        ||    <[ \x[0A66] .. \x[0A6F] ]>
        ||    <[ \x[0A70] .. \x[0A71] ]>
        ||    <[ \x[0A81] .. \x[0A82] ]>
        ||    '\x[0A83]'
        ||    '\x[0ABC]'
        ||    <[ \x[0ABE] .. \x[0AC0] ]>
        ||    <[ \x[0AC1] .. \x[0AC5] ]>
        ||    <[ \x[0AC7] .. \x[0AC8] ]>
        ||    '\x[0AC9]'
        ||    <[ \x[0ACB] .. \x[0ACC] ]>
        ||    '\x[0ACD]'
        ||    <[ \x[0AE2] .. \x[0AE3] ]>
        ||    <[ \x[0AE6] .. \x[0AEF] ]>
        ||    '\x[0B01]'
        ||    <[ \x[0B02] .. \x[0B03] ]>
        ||    '\x[0B3C]'
        ||    '\x[0B3E]'
        ||    '\x[0B3F]'
        ||    '\x[0B40]'
        ||    <[ \x[0B41] .. \x[0B43] ]>
        ||    <[ \x[0B47] .. \x[0B48] ]>
        ||    <[ \x[0B4B] .. \x[0B4C] ]>
        ||    '\x[0B4D]'
        ||    '\x[0B56]'
        ||    '\x[0B57]'
        ||    <[ \x[0B66] .. \x[0B6F] ]>
        ||    '\x[0B82]'
        ||    <[ \x[0BBE] .. \x[0BBF] ]>
        ||    '\x[0BC0]'
        ||    <[ \x[0BC1] .. \x[0BC2] ]>
        ||    <[ \x[0BC6] .. \x[0BC8] ]>
        ||    <[ \x[0BCA] .. \x[0BCC] ]>
        ||    '\x[0BCD]'
        ||    '\x[0BD7]'
        ||    <[ \x[0BE6] .. \x[0BEF] ]>
        ||    <[ \x[0C01] .. \x[0C03] ]>
        ||    <[ \x[0C3E] .. \x[0C40] ]>
        ||    <[ \x[0C41] .. \x[0C44] ]>
        ||    <[ \x[0C46] .. \x[0C48] ]>
        ||    <[ \x[0C4A] .. \x[0C4D] ]>
        ||    <[ \x[0C55] .. \x[0C56] ]>
        ||    <[ \x[0C66] .. \x[0C6F] ]>
        ||    <[ \x[0C82] .. \x[0C83] ]>
        ||    '\x[0CBC]'
        ||    '\x[0CBE]'
        ||    '\x[0CBF]'
        ||    <[ \x[0CC0] .. \x[0CC4] ]>
        ||    '\x[0CC6]'
        ||    <[ \x[0CC7] .. \x[0CC8] ]>
        ||    <[ \x[0CCA] .. \x[0CCB] ]>
        ||    <[ \x[0CCC] .. \x[0CCD] ]>
        ||    <[ \x[0CD5] .. \x[0CD6] ]>
        ||    <[ \x[0CE6] .. \x[0CEF] ]>
        ||    <[ \x[0D02] .. \x[0D03] ]>
        ||    <[ \x[0D3E] .. \x[0D40] ]>
        ||    <[ \x[0D41] .. \x[0D43] ]>
        ||    <[ \x[0D46] .. \x[0D48] ]>
        ||    <[ \x[0D4A] .. \x[0D4C] ]>
        ||    '\x[0D4D]'
        ||    '\x[0D57]'
        ||    <[ \x[0D66] .. \x[0D6F] ]>
        ||    <[ \x[0D82] .. \x[0D83] ]>
        ||    '\x[0DCA]'
        ||    <[ \x[0DCF] .. \x[0DD1] ]>
        ||    <[ \x[0DD2] .. \x[0DD4] ]>
        ||    '\x[0DD6]'
        ||    <[ \x[0DD8] .. \x[0DDF] ]>
        ||    <[ \x[0DF2] .. \x[0DF3] ]>
        ||    '\x[0E31]'
        ||    <[ \x[0E34] .. \x[0E3A] ]>
        ||    <[ \x[0E47] .. \x[0E4E] ]>
        ||    <[ \x[0E50] .. \x[0E59] ]>
        ||    '\x[0EB1]'
        ||    <[ \x[0EB4] .. \x[0EB9] ]>
        ||    <[ \x[0EBB] .. \x[0EBC] ]>
        ||    <[ \x[0EC8] .. \x[0ECD] ]>
        ||    <[ \x[0ED0] .. \x[0ED9] ]>
        ||    <[ \x[0F18] .. \x[0F19] ]>
        ||    <[ \x[0F20] .. \x[0F29] ]>
        ||    '\x[0F35]'
        ||    '\x[0F37]'
        ||    '\x[0F39]'
        ||    <[ \x[0F3E] .. \x[0F3F] ]>
        ||    <[ \x[0F71] .. \x[0F7E] ]>
        ||    '\x[0F7F]'
        ||    <[ \x[0F80] .. \x[0F84] ]>
        ||    <[ \x[0F86] .. \x[0F87] ]>
        ||    <[ \x[0F90] .. \x[0F97] ]>
        ||    <[ \x[0F99] .. \x[0FBC] ]>
        ||    '\x[0FC6]'
        ||    '\x[102C]'
        ||    <[ \x[102D] .. \x[1030] ]>
        ||    '\x[1031]'
        ||    '\x[1032]'
        ||    <[ \x[1036] .. \x[1037] ]>
        ||    '\x[1038]'
        ||    '\x[1039]'
        ||    <[ \x[1040] .. \x[1049] ]>
        ||    <[ \x[1056] .. \x[1057] ]>
        ||    <[ \x[1058] .. \x[1059] ]>
        ||    '\x[135F]'
        ||    <[ \x[1369] .. \x[1371] ]>
        ||    <[ \x[1712] .. \x[1714] ]>
        ||    <[ \x[1732] .. \x[1734] ]>
        ||    <[ \x[1752] .. \x[1753] ]>
        ||    <[ \x[1772] .. \x[1773] ]>
        ||    '\x[17B6]'
        ||    <[ \x[17B7] .. \x[17BD] ]>
        ||    <[ \x[17BE] .. \x[17C5] ]>
        ||    '\x[17C6]'
        ||    <[ \x[17C7] .. \x[17C8] ]>
        ||    <[ \x[17C9] .. \x[17D3] ]>
        ||    '\x[17DD]'
        ||    <[ \x[17E0] .. \x[17E9] ]>
        ||    <[ \x[180B] .. \x[180D] ]>
        ||    <[ \x[1810] .. \x[1819] ]>
        ||    '\x[18A9]'
        ||    <[ \x[1920] .. \x[1922] ]>
        ||    <[ \x[1923] .. \x[1926] ]>
        ||    <[ \x[1927] .. \x[1928] ]>
        ||    <[ \x[1929] .. \x[192B] ]>
        ||    <[ \x[1930] .. \x[1931] ]>
        ||    '\x[1932]'
        ||    <[ \x[1933] .. \x[1938] ]>
        ||    <[ \x[1939] .. \x[193B] ]>
        ||    <[ \x[1946] .. \x[194F] ]>
        ||    <[ \x[19B0] .. \x[19C0] ]>
        ||    <[ \x[19C8] .. \x[19C9] ]>
        ||    <[ \x[19D0] .. \x[19D9] ]>
        ||    <[ \x[1A17] .. \x[1A18] ]>
        ||    <[ \x[1A19] .. \x[1A1B] ]>
        ||    <[ \x[1DC0] .. \x[1DC3] ]>
        ||    <[ \x[203F] .. \x[2040] ]>
        ||    '\x[2054]'
        ||    <[ \x[20D0] .. \x[20DC] ]>
        ||    '\x[20E1]'
        ||    <[ \x[20E5] .. \x[20EB] ]>
        ||    <[ \x[302A] .. \x[302F] ]>
        ||    <[ \x[3099] .. \x[309A] ]>
        ||    '\x[A802]'
        ||    '\x[A806]'
        ||    '\x[A80B]'
        ||    <[ \x[A823] .. \x[A824] ]>
        ||    <[ \x[A825] .. \x[A826] ]>
        ||    '\x[A827]'
        ||    '\x[FB1E]'
        ||    <[ \x[FE00] .. \x[FE0F] ]>
        ||    <[ \x[FE20] .. \x[FE23] ]>
        ||    <[ \x[FE33] .. \x[FE34] ]>
        ||    <[ \x[FE4D] .. \x[FE4F] ]>
        ||    <[ \x[FF10] .. \x[FF19] ]>
        ||    '\x[FF3F]'
    }
}

#-------------------------------------------------------------------
our role Python3Literal 
does Python3String
does Python3Number
does Python3Name { }

our role Python3 
does Python3Operators
does Python3Braces
does Python3Literal
does Python3Keywords {

    token ws { 
        | <?{$*opened > 0}>  \s*
        | <?{$*opened eq 0}> [\h | \\ \v]* 
    }

    token maybe-vertical-ws {
        \s*
    }

    token TOP {
        :my $*opened = 0;
        :my $*debug = False;
        :my $*indents-needed = 0;
        :my $*dedents-needed = 0;
        :my @*INDENTATION = (0,);
        <file-input>
    }

    token single_input {
        <stmt>? <COMMENT>? <NEWLINE>
    }

    token comment-newline {
        <COMMENT_NONEWLINE>? <NEWLINE>
    }

    #------------------------------
    proto token file-input-item { * }

    token file-input-item:sym<comment-newline> {
        <comment-newline>
    }

    token file-input-item:sym<stmt> {
        <stmt>
    }

    #------------------------------
    token file-input {
        <file-input-item>*
        $
    }

    token eval_input {
        <testlist> <COMMENT>? <NEWLINE>* $
    }

    token at-dotted-name {
        '@' <dotted_name>
    }

    token decorator {
        <at-dotted-name>
        [ <parenthesized-arglist> ]?
        <COMMENT_NONEWLINE>? <NEWLINE>
    }

    rule parenthesized-arglist {
        <OPEN_PAREN> <arglist>?  <CLOSE_PAREN>
    }

    rule parenthesized-typedarglist {
        <OPEN_PAREN> <typedargslist>?  <CLOSE_PAREN>
    }

    token decorators {
        <decorator>+
    }

    rule funcdef {
        <DEF>
        <NAME>
        <parameters>
        [ '->' <test> ]?
        <COLON>
        <suite>
    }

    rule parameters {
        <parenthesized-typedarglist>
    }

    #---------------------------------------
    proto rule typedargslist { * }

    rule tfpdef-maybe-test {
        <tfpdef> [ '=' <test> ]?
    }


    rule just-basic-args {
        <tfpdef-maybe-test>+ % <comma-maybe-comment>
    }

    rule star-args {
        '*' <tfpdef>?  [ <COMMA> <tfpdef> [ '=' <test> ]? ]*
    }

    rule arglist-extension {
        <comma-maybe-comment>
        [    
            | <star-args> [ <COMMA> <typedargslist-kwargs> ]?
            | <typedargslist-kwargs>
        ]?
    }

    rule typedargslist:sym<full> {
        <just-basic-args>
        <arglist-extension>?
    }

    rule typedargslist:sym<args> {
       '*'
        <tfpdef>?
        [ <COMMA> <tfpdef> [ '=' <test> ]?  ]*
        [ <COMMA> <typedargslist-kwargs> ]?
    }

    rule typedargslist:sym<just-kwargs> {
        <typedargslist-kwargs>
    }

    rule typedargslist:sym<just-basic> {
        <just-basic-args>
    }

    rule typedargslist-kwargs {
        '**' <tfpdef>
    }

    #---------------------------------------
    rule tfpdef {
        <NAME> [ <COLON> <test> ]?
    }

    rule varargslist {
        ||    <vfpdef>
            [ '=' <test> ]?
            [ <COMMA> <vfpdef> [ '=' <test> ]?  ]*
            [    ||    <COMMA>
                    [    ||    '*'
                            <vfpdef>?
                            [  <COMMA> <vfpdef> [ '=' <test> ]?  ]*
                            [ <COMMA> '**' <vfpdef> ]?
                        ||    '**' <vfpdef>
                    ]?
            ]?
        ||    '*'
            <vfpdef>?
            [ <COMMA> <vfpdef> [ '=' <test> ]?  ]*
            [  <COMMA> '**' <vfpdef> ]?
        ||    '**' <vfpdef>
    }

    token vfpdef {
        <NAME>
    }


    token import-from-src {
        | [ <DOT> | '...' ]* <dotted_name>
        | [ <DOT> | '...' ]+
    }

    proto token import-from-target { * }
    token import-from-target:sym<*>                             { <STAR> }
    token import-from-target:sym<parenthesized-import-as-names> { <parenthesized-import-as-names> }
    token import-from-target:sym<import-as-names>               { <import-as-names> }

    rule parenthesized-import-as-names {
        <OPEN_PAREN> <COMMENT_NONEWLINE>? <import-as-names> <CLOSE_PAREN>
    }

    rule import_from {
        <FROM>
        <import-from-src>
        <IMPORT>
        <import-from-target>
    }

    rule import_as_name {
        <NAME> [ <AS> <NAME> ]?
    }

    rule dotted_as_name {
        <dotted_name> [ <AS> <NAME> ]?
    }

    rule import-as-names {
        <import_as_name>+ %% <COMMA>
    }

    rule dotted_as_names {
        <dotted_as_name> [ <COMMA> <dotted_as_name> ]*
    }

    #------------------------------------------
    proto token decorated-item { * }

    token decorated-item:sym<class> {
        <classdef>
    }

    token decorated-item:sym<func> {
        <funcdef>
    }

    #------------------------------------------
    proto token compound-stmt { * }

    token compound-stmt:sym<decorated> {
        <decorators>
        <decorated-item>
    }

    rule compound-stmt:sym<if> {
        <IF> <test> <COLON> <COMMENT_NONEWLINE>?
        <suite>
        <elif-suite>*
        <else-suite>?
    }

    rule elif-suite {
        <COMMENT>*
        <ELIF> <test> <COLON> <COMMENT_NONEWLINE>?
        <suite> 
    }

    rule compound-stmt:sym<while> {
        <WHILE> <test> <COLON> <COMMENT_NONEWLINE>?
        <suite>
        <else-suite>?
    }

    rule compound-stmt:sym<for> {
        <FOR> <exprlist> <IN> <testlist> <COLON> <COMMENT_NONEWLINE>?
        <suite>
        <else-suite>?
    }

    rule compound-stmt:sym<try> {
        <TRY> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
        <try-control-suite>
    }

    #------------------------
    proto token try-control-suite { * }
    token try-control-suite:sym<full>    { <try-block-except-suite> }
    token try-control-suite:sym<finally> { <finally-suite> }

    rule try-block-except-suite {
        <COMMENT>*
        <except-clause-suite>+
        <else-suite>?
        <finally-suite>?
    }

    rule except-clause-suite {
        <COMMENT>*
        <except_clause> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    rule else-suite {
        <COMMENT>*
        <ELSE> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite> 
    }

    rule finally-suite {
        <COMMENT>*
        <FINALLY> <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    rule compound-stmt:sym<with> {
        <COMMENT>*
        <WITH> <with-item> [ <COMMA> <with-item> ]* <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    rule compound-stmt:sym<func>  { <funcdef> }
    rule compound-stmt:sym<class> { <classdef> }

    rule classdef {
        <CLASS> <NAME> [ <parenthesized-arglist> ]?  <COLON> 
        <COMMENT_NONEWLINE>?
        <suite>
    }

    proto token with-item { * }
    token with-item:sym<basic> { <test> }
    rule  with-item:sym<as>    { <test> <AS> <expr> }

    rule except_clause {
        <EXCEPT> [ <test> [ <AS> <NAME> ]?  ]?
    }

    proto token SKIP { * }
    token SKIP:sym<SPACES>       { <SPACES> }
    token SKIP:sym<COMMENT>      { <COMMENT> }
    token SKIP:sym<LINE_JOINING> { <LINE_JOINING> }

    token SPACES {
        <[ \h  \t ]>+
    }

    rule COMMENT {
        <COMMENT_NONEWLINE> <NEWLINE>?
    }

    rule COMMENT_NONEWLINE {
        <POUND> <-[ \r \n ]>* 
    }

    token LINE_JOINING {
        '\\' <SPACES>?
        <newline-token>
    }

    token newline-token {
        || \r?  \n
        || \r
    }

    token enter_scope { <?> { so $*debug and say "entering scope" } }
    token leave_scope { <?> { so $*debug and say "leaving scope"  } }

    token INDENT {
        <?{ $*indents-needed > 0 }>
        <.enter_scope>
        { $*indents-needed--; }
    }

    token DEDENT {
        <?{ $*dedents-needed > 0 }>
        <.leave_scope>
        { $*dedents-needed--; }
    }

    token NEWLINE {
        <?{$*opened eq 0}>
        [    
            || ^ <SPACES>
            || <newline-token>+ <SPACES>?
        ]
        { 
            if not self.should-skip-indent($/) {
                if $/<SPACES>:exists {
                    my $indent = $/<SPACES>.Str.chars;
                    self.handle-indentation($indent, $/) 
                } else {
                    self.handle-indentation(0, $/) 
                }
            }
        }
        [ <INDENT> | <DEDENT>* ]?
    }

    method peek-indent-stack {
        @*INDENTATION.elems ?? @*INDENTATION[*-1] !! 0
    }

    method handle-indentation($indent,$/) {

        my $previous = self.peek-indent-stack();

        so $*debug and say "handle-indentation, prematch: \n{$/.prematch}\n--------indent: $indent, previous: $previous";

        if $indent eq $previous {
            return;

        } elsif $indent > $previous {

            @*INDENTATION.push: $indent;
            $*indents-needed++;

        } else {

            # Possibly emit more than 1 DEDENT token.
            while @*INDENTATION.elems > 0 and @*INDENTATION[*-1] > $indent {
                @*INDENTATION.pop();
                $*dedents-needed++;
            }
        }

        so $*debug and say "handle-indentation finished, {@*INDENTATION}, indents-needed: {$*indents-needed}, dedents-needed: {$*dedents-needed}";
    }

    method on-blank-line($/) {
        my $postmatch-line = $/.postmatch.Str.split("\n")[0];
        my Bool $on-blank-line = not so $postmatch-line.chomp.trim;
        if $on-blank-line {
            so $*debug and say "on-blank-line, prematch:\n{$/.prematch}";;
        }
        $on-blank-line
    }

    method should-skip-indent($/) {
        my Bool $opened = $*opened > 0;
        my Bool $blank-line = self.on-blank-line($/);
        my Bool $should-skip = $opened || $blank-line;
        if $should-skip {
            so $*debug and say "should-skip:\n{$/.prematch}";
        }
        $should-skip
    }

    #----------------------------------------
    proto token stmt { * }
    rule stmt:sym<compound> { <compound-stmt> }
    rule stmt:sym<simple>   { <simple-suite> }
    rule stmt:sym<comment>  { <COMMENT_NONEWLINE> }

    token simple-suite {
        <simple-stmt> <COMMENT>? <NEWLINE>?
    }

    rule simple-stmt {
        <small-stmt> [ ';' <small-stmt> ]* ';'? 
    }

    rule testlist-star-expr {
        [ <test> || <star-expr> ]
        [ <COMMA> [ <test> || <star-expr> ] ]* 
        <COMMA>?
    }

    #------------------------------------------------
    proto token small-stmt { * }

    rule small-stmt:sym<expr-augassign> {
        <testlist-star-expr> 
        <augassign> 
        <expr-augassign-rhs> 
    }

    #--------------------
    proto token expr-augassign-rhs { * }
    token expr-augassign-rhs:sym<yield>    { <yield_expr> }
    token expr-augassign-rhs:sym<testlist> { <testlist> }

    #--------------------
    proto token expr-equals-rhs { * }
    token expr-equals-rhs:sym<yield>              { <yield_expr> }
    token expr-equals-rhs:sym<testlist-star-expr> { <testlist-star-expr> }

    #--------------------
    rule small-stmt:sym<expr-equals> {
        <testlist-star-expr>
        [ <ASSIGN> <expr-equals-rhs> ]*
    }

    token small-stmt:sym<return>      { <RETURN> [\h+ <testlist>]? }
    token small-stmt:sym<raise>       { <RAISE> \h+ [  <test> \h+ [ <FROM> \h+ <test> ]?  ]?  }
    token small-stmt:sym<import-name> { <IMPORT> \h+ <dotted_as_names> }
    token small-stmt:sym<nonlocal>    { <NONLOCAL> \h+ <NAME> \h* [ <COMMA> \h+ <NAME> ]* }
    token small-stmt:sym<assert>      { <ASSERT> \h+  <test> \h* [ <COMMA> \h+ <test> ]? }
    token small-stmt:sym<pass>        { <PASS> }
    token small-stmt:sym<break>       { <BREAK> }
    token small-stmt:sym<contine>     { <CONTINUE> }
    token small-stmt:sym<yield>       { <yield_expr> }
    token small-stmt:sym<import-from> { <import_from> }
    token small-stmt:sym<global>      { <GLOBAL> \h+  <NAME> \h* [ <COMMA> \h+ <NAME> ]* }
    token small-stmt:sym<del>         { <DEL> \h+ <exprlist> }


    #<NEWLINE> <INDENT> <stmt>+ <DEDENT>
    token stmt-suite {

        [<NEWLINE> | <COMMENT>]*

        :my $current-indent = self.peek-indent-stack();
        {so $*debug and say "stmt-suite open. {:$current-indent}";}

        [<?{
            my $peek-indent-stack = self.peek-indent-stack();
            my $b = so $current-indent <= $peek-indent-stack;
            so $*debug and say "checking current-indent $current-indent <= peek-indent-stack $peek-indent-stack -- $b, prematch:\n{$/.prematch}";
            $b
        }> <stmt-maybe-comments>]+ 
    }

    token stmt-maybe-comments {
        <stmt> <COMMENT>*
    }

    proto token suite { * }

    token suite:sym<simple> { <simple-suite> }
    token suite:sym<stmt>   { <stmt-suite> }

    proto token test { * }
    token test:sym<basic>   { <or-test> }
    token test:sym<lambdef> { <lambdef> }
    token test:sym<ternary> { <or-test> <IF> <or-test> <ELSE> <test> }

    proto token test-nocond { * }
    token test-nocond:sym<basic>   { <or-test> }
    token test-nocond:sym<lambdef> { <lambdef_nocond> }

    rule lambdef {
        <LAMBDA> <varargslist>?  <COLON> <test>
    }

    rule lambdef_nocond {
        <LAMBDA> <varargslist>?  <COLON> <test-nocond>
    }

    rule or-test {
        <and-test> [ <OR> <COMMENT>? <and-test> ]*
    }

    rule and-test {
        <not-test> [  <AND> <COMMENT>? <not-test> ]*
    }

    rule not-test {
        || <NOT> <not-test>
        || <comparison>
    }

    rule comparison {
        <star-expr> [ <comp-op> <star-expr> ]*
    }

    token star-expr {
        '*'?  <expr>
    }

    rule expr {
        <xor_expr> [  '|' <xor_expr> ]*
    }

    rule xor_expr {
        <and_expr> [ '^' <and_expr> ]*
    }

    rule and_expr {
        <shift_expr> [ '&' <shift_expr> ]*
    }

    rule shift_expr {
        <arith_expr>
        [   
            || '<<' <arith_expr>
            || '>>' <arith_expr>
        ]*
    }

    rule arith_expr {
        <term>
        [    
            || <plus-maybe-comment> <term>
            || <minus-maybe-comment> <term>
        ]*
    }

    rule plus-maybe-comment {
        <COMMENT>* <PLUS> <COMMENT>*
    }

    rule minus-maybe-comment {
        <COMMENT>* <MINUS> <COMMENT>*
    }

    rule term {
        <factor>+ %% <term-delim-maybe-comment>
    }

    rule term-delim-maybe-comment {
        <COMMENT>* <term-delim> <COMMENT>*
    }

    proto token term-delim { * }
    token term-delim:sym<*>  { <sym> }
    token term-delim:sym</>  { <sym> }
    token term-delim:sym<%>  { <sym> }
    token term-delim:sym<//> { <sym> }
    token term-delim:sym<@>  { <sym> }

    rule factor {
        || '+' <factor>
        || '-' <factor>
        || '~' <factor>
        || <power>
    }

    rule power {
        <augmented-atom> [ '**' <factor> ]?
    }

    token augmented-atom {
        <atom> <trailer>*
    }

    proto rule atom { * }
    rule  atom:sym<strings>  { <strings> }
    token atom:sym<NONE>     { <NONE> }
    token atom:sym<true>     { <TRUE> }
    token atom:sym<false>    { <FALSE> }
    token atom:sym<NAME>     { <NAME> }
    rule  atom:sym<parens>   { <OPEN_PAREN> <COMMENT>* [ <yield_expr> || <testlist_comp> ]?  <COMMENT>* <CLOSE_PAREN> }
    rule  atom:sym<list>     { <OPEN_BRACK> <COMMENT>* <testlist_comp>?  <COMMENT>* <CLOSE_BRACK> }
    rule  atom:sym<dict>     { <OPEN_BRACE> <COMMENT>* <dictorsetmaker>?  <COMMENT>* <CLOSE_BRACE> }
    token atom:sym<number>   { <number> }
    token atom:sym<ellipsis> { <ELLIPSIS> }

    rule strings {
        <string>+ % \s 
    }

    rule testlist_comp {
        <test>
        [    
            | <comp-for>
            | [ <comma-maybe-comment> <test> ]* <comma-maybe-comment>?
        ]
    }

    #-------------------------------
    proto token trailer { * }

    token trailer:sym<dot-name>      { <DOT> <maybe-vertical-ws>? <NAME> }
    rule  trailer:sym<subscriptlist> { <OPEN_BRACK> <subscriptlist> <.CLOSE_BRACK> }
    rule  trailer:sym<arglist>       { <parenthesized-arglist> }

    #-------------------------------
    rule subscriptlist {
        <subscript> [ <COMMA> <subscript> ]* <COMMA>?
    }

    rule subscript {
        || <test>?  <COLON> <test>?  <sliceop>?
        || <test>
    }

    token sliceop {
        <COLON> <test>?
    }

    rule exprlist {
        <star-expr> [ <COMMA> <star-expr> ]* <COMMA>?
    }

    rule testlist {
        <test> [ <COMMA> <test> ]* <COMMA>?
    }

    proto rule setmaker-item { * }
    rule setmaker-item:sym<test>       { <test> }
    rule setmaker-item:sym<stars-test> { '**' <test> }

    rule dictmaker-item { <COMMENT>? <test> <COLON> <test> }

    proto rule dictorsetmaker { * }

    rule dictorsetmaker:sym<dict> {
        <dictmaker-item>
        [   
            | <comp-for>
            | [ <comma-maybe-comment> <dictmaker-item> ]* <comma-maybe-comment>?
        ]
    }

    rule comma-maybe-comment {
        <COMMA> <COMMENT>*
    }

    rule dictorsetmaker:sym<set> {
        <setmaker-item>
        [   
            | <comp-for>
            | [ <comma-maybe-comment> <setmaker-item> ]* <comma-maybe-comment>?
        ]
    }

    rule argument-comma-comment {
        <argument> <comma-maybe-comment>
    }

    rule arglist {
        [ <argument-comma-comment> ]*
        [   
            || <argument> <comma-maybe-comment>?
            || '*' <test> [ <comma-maybe-comment>  <argument> ]* [ <comma-maybe-comment> '**' <test> ]?
            || '**' <test>
        ]
    }

    rule argument {
        || <test> '=' <test>
        || <test> <comp-for>?
    }

    token comp-iter {
        || <comp-for>
        || <comp-if>
    }

    rule comp-for {
        <FOR>
        <exprlist>
        <IN>
        <or-test>
        <comp-iter>?
    }

    rule comp-if {
        <IF> <test-nocond> <comp-iter>?
    }

    rule yield_expr {
        <YIELD> <yield-arg>?
    }

    rule yield-arg {
        || <FROM> <test>
        || <testlist>
    }
}
