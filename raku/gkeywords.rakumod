our role Keywords {
    token class      { 'class' }
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
    token static     { 'static' }
    token inline     { 'inline' }
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
    token terminator { ';' }
    token priv       { '_' }
}
