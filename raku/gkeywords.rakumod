our role Keywords {
    token class      { 'class' }
    token enum_      { 'enum' }
    token mutable    { 'mutable' }
    token virtual    { 'virtual' }
    token volatile   { 'volatile' }
    token using      { 'using' }
    token typedef    { 'typedef' }
    token final      { 'final' }
    token public     { 'public' }
    token private    { 'private' }
    token struct     { 'struct' }
    token friend     { 'friend' }
    token typename   { 'typename' }
    token template   { 'template' }
    token constexpr  { 'constexpr' }
    token noexcept   { 'noexcept' }
    token override   { 'override' }
    token const      { 'const' }
    token const2     { 'const' }
    token const3     { 'const' }
    token static     { 'static' }
    token inline-noforce {
        | 'inline' 
        | 'ILINE'
    }
    token inline-never {
        | 'XXH_NO_INLINE'
    }
    token inline-force {
        | 'forcedinline' 
        | 'XXH_FORCE_INLINE' 
    }
    token inline     { 
        | <inline-noforce>
        | <inline-never>
        | <inline-force>
    }
    token explicit   { 'explicit' }
    token semicolon  { ';' }
}

our role Sigils {
    token ref { 
        | '&' 
        | <double-ref>
    }
    token double-ref { 
        '&&'
    }
    token mut        { 'mut' }
    token ptr        { '*' }
    token ptr-ref    { '&' }
    token terminator { ';' }
    token priv       { '_' }
}
