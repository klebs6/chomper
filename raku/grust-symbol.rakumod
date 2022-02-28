use grust-model;


our role Rust::Symbol {
    token semicolon  { ';'    } 
    token comma      { ','    } 
    token dotdotdot  { \.\.\. } 
    token dotdot     { \.\.   } 
    token dot        { \.     } 
    token lparen     { '('    } 
    token rparen     { ')'    } 
    token lbrace     { '{'    } 
    token rbrace     { '} '   } 
    token lbrack     { '['    } 
    token rbrack     { ']'    } 
    token at         { '@'    } 
    token tilde      { '~'    } 
    token mod-sep    { '::'   } 
    token colon      { ':'    } 
    token dollar     { \$     } 
    token question   { \?     } 
    token eqeq       { '=='   } 
    token fat-arrow  { '=>'   } 
    token equals     { '='    } 
    token n-equals   { '!='   } 
    token bang       { '!'    } 
    token l-equals   { '<='   } 
    token shl        { '<<'   } 
    token shr        { '>>'   } 
    token shl-eq     { '<<='  } 
    token shr-eq     { '>>='  } 
    token less       { '<'    } 
    token greater    { '>'    } 
    token g-equals   { '>='   } 
    token larrow     { '<-'   } 
    token rarrow     { '->'   } 
    token dash       { '-'    } 
    token minus-eq   { '-='   } 
    token and-and    { '&&'   } 
    token and_       { '&'    } 
    token and-eq     { '&='   } 
    token or-or      { '||'   } 
    token or_        { '|'    } 
    token or-eq      { '|='   } 
    token plus       { '+'    } 
    token plus-eq    { '+='   } 
    token star       { '*'    } 
    token star-eq    { '*='   } 
    token slash      { '/'    } 
    token slash-eq   { '/='   } 
    token caret      { '^'    } 
    token caret-eq   { '^='   } 
    token percent    { '%'    } 
    token percent-eq { '%='   } 
}

