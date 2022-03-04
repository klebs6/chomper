use grust-model;

our role Rust::Keyword {

    token kw-abstract      { 'abstract' } 
    token kw-alignof       { 'alignof'  } 
    token kw-as            { 'as'       } 
    token kw-become        { 'become'   } 
    token kw-box           { 'box'      } 
    token kw-break         { 'break'    } 
    token kw-catch         { 'catch'    } 
    token kw-const         { 'const'    } 
    token kw-continue      { 'continue' }
    token kw-crate         { 'crate'    }
    token kw-default       { 'default'  }
    token kw-do            { 'do'       }
    token kw-else          { else       }
    token kw-enum          { 'enum'     } 
    token kw-extern        { 'extern'   } 
    token kw-false         { 'false'    } 
    token kw-final         { 'final'    } 
    token kw-fn            { 'fn'       } 
    token kw-for           { 'for'      } 
    token kw-if            { 'if'       } 
    token kw-impl          { 'impl'     } 
    token kw-in            { 'in'       } 
    token kw-let           { 'let'      } 
    token kw-loop          { 'loop'     } 
    token kw-macro         { 'macro'    } 
    token kw-dyn           { 'dyn'    } 

    token kw-match         { 'match'    } 

    token kw-mod           { 'mod'      } 
    token kw-move          { 'move'     } 
    token kw-mut           { 'mut'      } 
    token kw-offsetof      { 'offsetof' } 
    token kw-override      { 'override' } 
    token kw-priv          { 'priv'     } 
    token kw-proc          { 'proc'     } 
    token kw-pub           { 'pub'      } 
    token kw-pure          { 'pure'     } 
    token kw-ref           { 'ref'      } 
    token kw-return        { 'return'   } 
    token kw-self          { 'self'     } 
    token kw-sizeof        { 'sizeof'   } 
    token kw-static        { 'static'   } 
    token kw-struct        { 'struct'   } 
    token kw-super         { 'super'    } 
    token kw-trait         { 'trait'    } 
    token kw-true          { 'true'     } 
    token kw-type          { 'type'     } 
    token kw-typeof        { 'typeof'   } 
    token kw-union         { 'union'    } 
    token kw-unsafe        { 'unsafe'   } 
    token kw-unsized       { 'unsized'  } 
    token kw-use           { 'use'      } 
    token kw-virtual       { 'virtual'  } 
    token kw-where         { 'where'    } 
    token kw-while         { 'while'    } 
    token kw-yield         { 'yield'    } 

    #token ws { <[   \t \r \n ]>+ }

    token non-slash-or-ws { 
        <-[   \t \r \n / ]>
    }
}
