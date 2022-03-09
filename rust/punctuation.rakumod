
our role Punctuation::Rules {
    token tok-plus        { +   } #Addition, Trait Bounds, Macro Kleene Matcher
    token tok-minus       { -   } #Subtraction, Negation
    token tok-star        { *   } #Multiplication, Dereference, Raw Pointers, Macro Kleene Matcher, Use wildcards
    token tok-slash       { /   } #Division
    token tok-percent     { %   } #Remainder
    token tok-caret       { ^   } #Bitwise and Logical XOR
    token tok-not         { !   } #Bitwise and Logical NOT, Macro Calls, Inner Attributes, Never Type, Negative impls
    token tok-and         { &   } #Bitwise and Logical AND, Borrow, References, Reference patterns
    token tok-or          { |   } #Bitwise and Logical OR, Closures, Patterns in match, if let, and while let
    token tok-andand      { &&  } #Lazy AND, Borrow, References, Reference patterns
    token tok-oror        { ||  } #Lazy OR, Closures
    token tok-shl         { <<  } #Shift Left, Nested Generics
    token tok-shr         { >>  } #Shift Right, Nested Generics
    token tok-pluseq      { +=  } #Addition assignment
    token tok-minuseq     { -=  } #Subtraction assignment
    token tok-stareq      { *=  } #Multiplication assignment
    token tok-slasheq     { /=  } #Division assignment
    token tok-percenteq   { %=  } #Remainder assignment
    token tok-careteq     { ^=  } #Bitwise XOR assignment
    token tok-andeq       { &=  } #Bitwise And assignment
    token tok-oreq        { |=  } #Bitwise Or assignment
    token tok-shleq       { <<= } #Shift Left assignment
    token tok-shreq       { >>= } #Shift Right assignment, Nested Generics
    token tok-eq          { =   } #Assignment, Attributes, Various type definitions
    token tok-eqeq        { ==  } #Equal
    token tok-ne          { !=  } #Not Equal
    token tok-gt          { >   } #Greater than, Generics, Paths
    token tok-lt          { \<  } #Less than, Generics, Paths
    token tok-ge          { >=  } #Greater than or equal to, Generics
    token tok-le          { <=  } #Less than or equal to
    token tok-at          { @   } #Subpattern binding
    token tok-underscore  { _   } #Wildcard patterns, Inferred types, Unnamed items in constants, extern crates, and use declarations
    token tok-dot         { .   } #Field access, Tuple index
    token tok-dotdot      { ..  } #Range, Struct expressions, Patterns, Range Patterns
    token tok-dotdotdot   { ... } #Variadic functions, Range patterns
    token tok-dotdoteq    { ..= } #Inclusive Range, Range patterns
    token tok-comma       { ,   } #Various separators
    token tok-semi        { ;   } #Terminator for various items and statements, Array types
    token tok-colon       { :   } #Various separators
    token tok-path-sep    { ::  } #Path separator
    token tok-rarrow      { ->  } #Function return type, Closure return type, Function pointer type
    token tok-fat-rarrow  { =>  } #Match arms, Macros
    token tok-pound       { \#  } #Attributes
    token tok-dollar      { \$  } #Macros
    token tok-question    { ?   } #Question mark operator, Questionably sized, Macro Kleene Matcher
}
