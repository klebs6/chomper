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
    token ASSIGN           { '=' <!before '='> }
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

