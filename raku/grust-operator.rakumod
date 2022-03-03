use grust-model;

our role Rust::Operator {

    rule comma-comment    { ',' <comment>? } 
    #-------------------------------

    token tok-and              { '&'      } 
    token tok-andand           { \&\&     } 
    token tok-andeq            { '&='     } 
    token tok-at               { '@'      } 
    token tok-caret            { '^'      } 
    token tok-careteq          { '^='     } 
    token tok-colon            { ':'      } 
    token tok-comma            { ','      } 
    token tok-copytok          { 'copy'   } 
    token tok-darrow           { '<->'    } 
    token tok-div              { '/'      } 
    token tok-dollar           { '$'      } 
    token tok-dot              { '.'      } 
    token tok-dotdot           { '..'     } 
    token tok-dotdotdot        { '...'    } 
    token tok-drop             { 'drop'   } 
    token tok-eq               { '='      } 
    token tok-eqeq             { '=='     } 
    token tok-fat-arrow        { '=>'     } 
    token tok-ge               { '>='     } 
    token tok-gt               { '>'      } 
    token tok-larrow           { '<-'     } 
    token tok-lbrace           { '{'      } 
    token tok-lbracket         { '['      } 
    token tok-le               { '<='     } 
    token tok-log              { '_log'  } 
    token tok-lparen           { '('      } 
    token tok-lt               { '<'      } 
    token tok-minus            { '-'      } 
    token tok-minuseq          { '-='     } 
    token tok-mod-sep          { '::'     } 
    token tok-ne               { '!='     } 
    token tok-not              { '!'      } 
    token tok-once             { 'once'   } 
    token tok-or               { '|'      } 
    token tok-oreq             { '|='     } 
    token tok-oror             { '||'     } 
    token tok-percenteq        { '%='     } 
    token tok-plus             { '+'      } 
    token tok-pluseq           { '+='     } 
    token tok-pound            { '#'      } 
    token tok-rarrow           { '->'     } 
    token tok-rbrace           { '}'      } 
    token tok-rbracket         { ']'      } 
    token tok-rem              { '%'      } 
    token tok-rparen           { ')'      } 
    token tok-semi             { ';'      } 
    token tok-shl              { '<<'     } 
    token tok-shleq            { '<<='    } 
    token tok-shr              { '>>'     } 
    token tok-shreq            { '>>='    } 
    token tok-slasheq          { '/='     } 
    token tok-star             { '*'      } 
    token tok-stareq           { '*='     } 
    token tok-tilde            { '~'      } 
    token tok-underscore       { '_'      } 

    proto token tok-binopeq { * }
    token tok-binopeq:sym<div-eq>    { '/=' }
    token tok-binopeq:sym<mod-eq>    { '%=' }
    token tok-binopeq:sym<caret-eq>  { '^=' }
    token tok-binopeq:sym<pipe-eq>   { '|=' }
    token tok-binopeq:sym<minus-eq>  { '-=' }
    token tok-binopeq:sym<star-eq>   { '*=' }
    token tok-binopeq:sym<amp-eq>    { '&=' }
    token tok-binopeq:sym<plus-eq>   { '+=' }
    token tok-binopeq:sym<lshift-eq> { '<<=' }
    token tok-binopeq:sym<rshift-eq> { '>>=' }
}
