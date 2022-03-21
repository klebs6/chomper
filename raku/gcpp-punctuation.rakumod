use Data::Dump::Tree;

use gcpp-roles;

our role Punctuation::Rules {
    token left-paren       { '('                } 
    token right-paren      { ')'                } 
    token left-bracket     { '['                } 
    token right-bracket    { ']'                } 
    token left-brace       { '{'                } 
    token right-brace      { '}'                } 
    token plus             { '+'                } 
    token minus            { '-'                } 
    token star             { '*'                } 
    token div_             { '/'                } 
    token mod_             { '%'                } 
    token caret            { '^'                } 
    token and_             { '&'  <!before '&'>  } 
    token or_              { '|'  <!before '|'>  } 
    token tilde            { '~'                 } 
    token assign           { '='                 } 
    token less             { '<'  <!before '='>  } 
    token greater          { '>'  <!before '='>  } 
    token plus-assign      { '+='                } 
    token minus-assign     { '-='                } 
    token star-assign      { '*='                } 
    token div-assign       { '/='                } 
    token mod-assign       { '%='                } 
    token xor-assign       { '^='                } 
    token and-assign       { '&='                } 
    token or-assign        { '|='                } 
    token left-shift-assign  { '<<='             } 
    token right-shift-assign { '>>='             } 
    token equal            { '=='                } 
    token not-equal        { '!='                } 
    token less-equal       { '<='                } 
    token greater-equal    { '>='                } 
    token plus-plus        { '++'                } 
    token minus-minus      { '--'                } 
    token comma            { ','                 } 
    token arrow-star       { '->*'               } 
    token arrow            { '->'                } 
    token question         { '?'                 } 
    token colon            { ':'                 } 
    token doublecolon      { '::'                } 
    rule semi              { ';' <comment>?      }
    token dot              { '.'                 } 
    token dot-star         { '.*'                } 
    token ellipsis         { '...'               } 

    proto token not_        { * }
    token not_:sym<!>       { <sym> }
    token not_:sym<not>     { <sym> }

    proto token and-and     { * }
    token and-and:sym<&&>   { <sym> }
    token and-and:sym<and>  { <sym> }

    proto token or-or       { * }
    token or-or:sym<||>     { <sym> }
    token or-or:sym<or>     { <sym> }
}

