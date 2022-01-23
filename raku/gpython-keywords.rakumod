
our role PythonKeywords {
    token pass  { 'pass' }
    token class { 'class' }
    token def { 'def' }
    token python-ident { <[A..Z a..z 0..9 _]>+ }
}

our role Python3Keywords {
    token DEF                { 'def'      } 
    token RETURN             { 'return'   } 
    token RAISE              { 'raise'    } 
    token FROM               { 'from'     } 
    token IMPORT             { 'import'   } 
    token AS                 { 'as'       } 
    token GLOBAL             { 'global'   } 
    token NONLOCAL           { 'nonlocal' } 
    token ASSERT             { 'assert'   } 
    token IF                 { 'if'       } 
    token ELIF               { 'elif'     } 
    token ELSE               { 'else'     } 
    token WHILE              { 'while'    } 
    token FOR                { 'for'      } 
    token IN                 { 'in'       } 
    token TRY                { 'try'      } 
    token FINALLY            { 'finally'  } 
    token WITH               { 'with'     } 
    token EXCEPT             { 'except'   } 
    token LAMBDA             { 'lambda'   } 
    token OR                 { 'or'       } 
    token AND                { 'and'      } 
    token NOT                { 'not'      } 
    token IS                 { 'is'       } 
    token NONE               { 'None'     } 
    token TRUE               { 'True'     } 
    token FALSE              { 'False'    } 
    token CLASS              { 'class'    } 
    token YIELD              { 'yield'    } 
    token DEL                { 'del'      } 
    token PASS               { 'pass'     } 
    token CONTINUE           { 'continue' } 
    token BREAK              { 'break'    } 

    token DOT                { '.'   }
    token ELLIPSIS           { '...' }
    token STAR               { '*'   }
    token COMMA              { ','   } 
    token COLON              { ':'   } 
    token SEMI_COLON         { ';'   } 
    token POWER              { '**'  } 
    token ASSIGN             { '='   } 
    token OR_OP              { '|'   } 
    token XOR                { '^'   } 
    token AND_OP             { '&'   } 
    token LEFT_SHIFT         { '<<'  } 
    token RIGHT_SHIFT        { '>>'  } 
    token ADD                { '+'   } 
    token MINUS              { '-'   } 
    token DIV                { '/'   } 
    token MOD                { '%'   } 
    token IDIV               { '//'  } 
    token NOT_OP             { '~'   } 
    token LESS_THAN          { '<'   } 
    token GREATER_THAN       { '>'   } 
    token EQUALS             { '=='  } 
    token GT_EQ              { '>='  } 
    token LT_EQ              { '<='  } 
    token NOT_EQ_1           { '<>'  } 
    token NOT_EQ_2           { '!='  } 
    token AT                 { '@'   } 
    token ARROW              { '->'  } 
    token ADD_ASSIGN         { '+='  } 
    token SUB_ASSIGN         { '-='  } 
    token MULT_ASSIGN        { '*='  } 
    token AT_ASSIGN          { '@='  } 
    token DIV_ASSIGN         { '/='  } 
    token MOD_ASSIGN         { '%='  } 
    token AND_ASSIGN         { '&='  } 
    token OR_ASSIGN          { '|='  } 
    token XOR_ASSIGN         { '^='  } 
    token LEFT_SHIFT_ASSIGN  { '<<=' } 
    token RIGHT_SHIFT_ASSIGN { '>>=' } 
    token POWER_ASSIGN       { '**=' } 
    token IDIV_ASSIGN        { '//=' } 

    token augassign {
        | '+='
        | '-='
        | '*='
        | '@='
        | '/='
        | '%='
        | '&='
        | '|='
        | '^='
        | '<<='
        | '>>='
        | '**='
        | '//='
    }

    token OPEN_PAREN  { '('  { $*opened++; }}
    token CLOSE_PAREN { ')'  { $*opened--; }}
    token OPEN_BRACK  { '['  { $*opened++; }} 
    token CLOSE_BRACK { '\]' { $*opened--; }} 
    token OPEN_BRACE  { '{'  { $*opened++; }} 
    token CLOSE_BRACE { '}'  { $*opened--; }} 
}
