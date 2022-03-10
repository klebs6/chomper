our role Punctuation::Rules {

    #`(Addition, Trait Bounds, Macro Kleene
    Matcher)
    token tok-plus         { '+'   } 

    #`(Subtraction, Negation)
    token tok-minus        { '-'   } 

    #`(Multiplication, Dereference, Raw Pointers,
    Macro Kleene Matcher, Use wildcards)
    token tok-star         { '*'   } 

    #`(Division)
    token tok-slash        { '/'   } 

    #`(Remainder)
    token tok-percent      { '%'   } 

    #`(Bitwise and Logical XOR)
    token tok-caret        { '^'   } 

    #`(Bitwise and Logical NOT, Macro Calls, Inner
    Attributes, Never Type, Negative impls)
    token tok-not          { '!'   } 

    token tok-bang         { '!'   } 

    #`(Bitwise and Logical AND, Borrow,
    #References, Reference patterns)
    token tok-and          { '&' <!before '&'>   } 

    #`(Bitwise and Logical OR, Closures, Patterns
    #in match, if let, and while let)
    token tok-or           { '|' <!before '|'>  } 

    #`(Lazy AND, Borrow, References, Reference
    #patterns)
    token tok-andand       { '&&'  } 

    #`(Lazy OR, Closures)
    token tok-oror         { '||'  } 

    #`(Shift Left, Nested Generics)
    token tok-shl          { '<<'  } 

    #`(Shift Right, Nested Generics)
    token tok-shr          { '>>'  } 

    #`(Addition assignment)
    token tok-pluseq       { '+='  } 

    #`(Subtraction assignment)
    token tok-minuseq      { '-='  } 

    #`(Multiplication assignment)
    token tok-stareq       { '*='  } 

    #`(Division assignment)
    token tok-slasheq      { '/='  } 

    #`(Remainder assignment)
    token tok-percenteq    { '%='  } 

    #`(Bitwise XOR assignment)
    token tok-careteq      { '^='  } 

    #`(Bitwise And assignment)
    token tok-andeq        { '&='  } 

    #`(Bitwise Or assignment)
    token tok-oreq         { '|='  } 

    #`(Shift Left assignment)
    token tok-shleq        { '<<=' } 

    #`(Shift Right assignment, Nested Generics)
    token tok-shreq        { '>>=' } 

    #`(Assignment, Attributes, Various type
    #definitions)
    token tok-eq           { '=' <!before '='>   } 

    #`(Equal)
    token tok-eqeq         { '=='  } 

    #`(Not Equal)
    token tok-ne           { '!='  } 

    #`(Greater than, Generics, Paths)
    token tok-gt           { '>'   } 

    #`(Less than, Generics, Paths)
    token tok-lt           { '<'   } 

    #`(Greater than or equal to, Generics)
    token tok-ge           { '>='  } 

    #`(Less than or equal to)
    token tok-le           { '<='  } 

    #`(Subpattern binding)
    token tok-at           { '@'   } 

    #`(Wildcard patterns, Inferred types, Unnamed
    items in constants, extern crates, and use
    declarations)
    token tok-underscore   { '_'   } 

    #`(Field access, Tuple index)
    token tok-dot          { '.'   } 

    #`(Range, Struct expressions, Patterns, Range
    Patterns)
    token tok-dotdot       { '..'  } 

    #`(Variadic functions, Range patterns)
    token tok-dotdotdot    { '...' } 

    #`(Inclusive Range, Range patterns)
    token tok-dotdoteq     { '..=' } 

    #`(Various separators)
    token tok-comma        { ','   } 

    #`(Terminator for various items and
    #statements, Array types)
    token tok-semi         { ';'   } 

    #`(Various separators)
    token tok-colon        { ':'   } 

    #`(Path separator)
    token tok-path-sep     { '::'  } 

    #`(Function return type, Closure return type,
    #Function pointer type)
    token tok-rarrow       { '->'  } 

    #`(Match arms, Macros)
    token tok-fat-rarrow   { '=>'  } 

    #`(Attributes)
    token tok-pound        { '#'  } 

    #`(Macros)
    token tok-dollar       { '$'  } 

    #`(Question mark operator, Questionably sized,
    #Macro Kleene Matcher)
    token tok-qmark        { '?'   } 

    token tok-qmark-qmark  { <tok-qmark> ** 2 }
    token tok-single-quote { \' }
    token tok-double-quote { \" }

    token tok-lparen { '(' }
    token tok-rparen { ')' }

    token tok-lbrace { '{' }
    token tok-rbrace { '}' }

    token tok-lbrack { '[' }
    token tok-rbrack { ']' }
}

our role Punctuation::Actions {}
