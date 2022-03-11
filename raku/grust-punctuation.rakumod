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

    #-------------------------
    proto token punctuation { * }
    token punctuation:sym<tok-plus>         { <tok-plus> } 
    token punctuation:sym<tok-minus>        { <tok-minus> } 
    token punctuation:sym<tok-star>         { <tok-star> } 
    token punctuation:sym<tok-slash>        { <tok-slash> } 
    token punctuation:sym<tok-percent>      { <tok-percent> } 
    token punctuation:sym<tok-caret>        { <tok-caret> } 
    token punctuation:sym<tok-not>          { <tok-not> } 
    token punctuation:sym<tok-bang>         { <tok-bang> } 
    token punctuation:sym<tok-and>          { <tok-and> } 
    token punctuation:sym<tok-or>           { <tok-or> } 
    token punctuation:sym<tok-andand>       { <tok-andand> } 
    token punctuation:sym<tok-oror>         { <tok-oror> } 
    token punctuation:sym<tok-shl>          { <tok-shl> } 
    token punctuation:sym<tok-shr>          { <tok-shr> } 
    token punctuation:sym<tok-pluseq>       { <tok-pluseq> } 
    token punctuation:sym<tok-minuseq>      { <tok-minuseq> } 
    token punctuation:sym<tok-stareq>       { <tok-stareq> } 
    token punctuation:sym<tok-slasheq>      { <tok-slasheq> } 
    token punctuation:sym<tok-percenteq>    { <tok-percenteq> } 
    token punctuation:sym<tok-careteq>      { <tok-careteq> } 
    token punctuation:sym<tok-andeq>        { <tok-andeq> } 
    token punctuation:sym<tok-oreq>         { <tok-oreq> } 
    token punctuation:sym<tok-shleq>        { <tok-shleq> } 
    token punctuation:sym<tok-shreq>        { <tok-shreq> } 
    token punctuation:sym<tok-eq>           { <tok-eq> } 
    token punctuation:sym<tok-eqeq>         { <tok-eqeq> } 
    token punctuation:sym<tok-ne>           { <tok-ne> } 
    token punctuation:sym<tok-gt>           { <tok-gt> } 
    token punctuation:sym<tok-lt>           { <tok-lt> } 
    token punctuation:sym<tok-ge>           { <tok-ge> } 
    token punctuation:sym<tok-le>           { <tok-le> } 
    token punctuation:sym<tok-at>           { <tok-at> } 
    token punctuation:sym<tok-underscore>   { <tok-underscore> } 
    token punctuation:sym<tok-dot>          { <tok-dot> } 
    token punctuation:sym<tok-dotdot>       { <tok-dotdot> } 
    token punctuation:sym<tok-dotdotdot>    { <tok-dotdotdot> } 
    token punctuation:sym<tok-dotdoteq>     { <tok-dotdoteq> } 
    token punctuation:sym<tok-comma>        { <tok-comma> } 
    token punctuation:sym<tok-semi>         { <tok-semi> } 
    token punctuation:sym<tok-colon>        { <tok-colon> } 
    token punctuation:sym<tok-path-sep>     { <tok-path-sep> } 
    token punctuation:sym<tok-rarrow>       { <tok-rarrow> } 
    token punctuation:sym<tok-fat-rarrow>   { <tok-fat-rarrow> } 
    token punctuation:sym<tok-pound>        { <tok-pound> } 
    token punctuation:sym<tok-dollar>       { <tok-dollar> } 
    token punctuation:sym<tok-qmark>        { <tok-qmark> } 
    token punctuation:sym<tok-qmark-qmark>  { <tok-qmark-qmark> }
    token punctuation:sym<tok-single-quote> { <tok-single-quote> }
    token punctuation:sym<tok-double-quote> { <tok-double-quote> }
}

our role Punctuation::Actions {}
