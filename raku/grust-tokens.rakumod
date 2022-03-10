our role Tokens::Rules {

    proto token char-literal-body { * }

    token char-literal-body:sym<not-forbidden> { 
        <-[\' \\ \n \r \t ]>
    }

    token char-literal-body:sym<quote-escape> { 
        <quote-escape>
    }

    token char-literal-body:sym<ascii-escape> { 
        <ascii-escape>
    }

    token char-literal-body:sym<unicode-escape> { 
        <unicode-escape>
    }

    token char-literal {
        <tok-single-quote>
        <char-literal-body>
        <tok-single-quote>
    }

    token quote-escape {
        | \'
        | \"
    }

    proto token ascii-escape { * }

    token ascii-escape:sym<x> { \\x <oct-digit> <hex-digit> }
    token ascii-escape:sym<n> { \\n }
    token ascii-escape:sym<r> { \\r }
    token ascii-escape:sym<t> { \\t }
    token ascii-escape:sym<s> { \\\\ }
    token ascii-escape:sym<0> { \\0 }

    token unicode-escape {
        \\u 
        <tok-lbrace> 
        [[ <hex-digit> _* ] ** 1..6] 
        <tok-rbrace> 
    }

    token bin-digit {
        <[0..1]>
    }

    token oct-digit {
        <[0..7]>
    }

    token dec-digit {
        <[0..9]>
    }

    token hex-digit {
        <[0..9 a..f A..F]>
    }

    proto token integer-suffix { * }
    token integer-suffix:sym<u8>    { u8 }
    token integer-suffix:sym<u16>   { u16 }
    token integer-suffix:sym<u32>   { u32 }
    token integer-suffix:sym<u64>   { u64 }
    token integer-suffix:sym<u128>  { u128 }
    token integer-suffix:sym<usize> { usize }
    token integer-suffix:sym<i8>    { i8 }
    token integer-suffix:sym<i16>   { i16 }
    token integer-suffix:sym<i32>   { i32 }
    token integer-suffix:sym<i64>   { i64 }
    token integer-suffix:sym<i128>  { i128 }
    token integer-suffix:sym<isize> { isize }

    token tuple-index { <integer-literal> }

    proto token float-suffix { * }
    token float-suffix:sym<f32> { f32 }
    token float-suffix:sym<f64> { f64 }

    proto token boolean-literal { * }
    token boolean-literal:sym<t> { true }
    token boolean-literal:sym<f> { false }

    token integer-literal {
        <integer-literal-variant> <integer-suffix>?
    }

    proto token integer-literal-variant { * }

    token integer-literal-variant:sym<dec> { <dec-literal> }
    token integer-literal-variant:sym<bin> { <bin-literal> }
    token integer-literal-variant:sym<oct> { <oct-literal> }
    token integer-literal-variant:sym<hex> { <hex-literal> }

    token dec-literal {
        <dec-digit> [<dec-digit> | _]*
    }

    token bin-literal {
        0b [<bin-digit> | _]* <bin-digit> [<bin-digit> | _]*
    }

    token oct-literal {
        0o [<oct-digit> | _]* <oct-digit> [<oct-digit> | _]*
    }

    token hex-literal {
        0x [<hex-digit> | _]* <hex-digit> [<hex-digit> | _]*
    }

    token string-literal {
        <tok-double-quote>
        <string-literal-inner>*
        <tok-double-quote>
    }

    proto token string-literal-inner { * }

    token string-literal-inner:sym<not-forbidden>   { <-[\" \\ ]> <?{$/ !~~ <isolated-cr>}> }
    token string-literal-inner:sym<quote-escape>    { <quote-escape> }
    token string-literal-inner:sym<ascii-escape>    { <ascii-escape> }
    token string-literal-inner:sym<unicode-escape>  { <unicode-escape> }
    token string-literal-inner:sym<string-continue> { <string-continue> }

    token string-continue {
        \\ <?before \n>
    }

    token raw-string-literal {
        r <raw-string-content>
    }

    proto token raw-string-content { * }

    token raw-string-content:sym<a> {
        " ( ~ IsolatedCR )* (non-greedy) "
    }

    token raw-string-content:sym<b> {
        <tok-pound> 
        <raw-string-content>
        <tok-pound> 
    }

    token byte-literal {
        b 
        <tok-single-quote> 
        [ <ascii-for-char> | <byte-escape> ] 
        <tok-single-quote>
    }

    token ascii-for-char {
        <ascii-except-forbidden>
    }

    token ascii-except-forbidden {
        <any-ascii> <?{$/ !~~ /[\' | \\ | \n | \r | \t]/}>
    }

    proto token byte-escape { * }

    token byte-escape:sym<x>  { \\x <hex-digit> <hex-digit> }
    token byte-escape:sym<n>  { \\n }
    token byte-escape:sym<r>  { \\r }
    token byte-escape:sym<t>  { \\t }
    token byte-escape:sym<sl> { \\\\ }
    token byte-escape:sym<s0> { \\0 }
    token byte-escape:sym<sq> { \\\' }
    token byte-escape:sym<dq> { \\\" }

    token byte-string-literal {
        b <tok-double-quote> 
        [
            | <ascii-for-string>
            | <byte-escape>
            | <string-continue>
        ]* 
        <tok-double-quote>
    }

    token ascii-for-string {
        <ascii-except-forbidden2>
    }

    token ascii-except-forbidden2 {
        <any-ascii> <?{$/ !~~ /[\" | \\ | $Tokens::Rules::isolated-cr]/}>
    }

    token any-ascii {
        <:ASCII>
    }

    token raw-byte-string-literal {
        br <raw-byte-string-content>
    }

    proto token raw-byte-string-content { * }

    token raw-byte-string-content:sym<a> {
        <tok-double-quote> 
        <ascii>*? 
        <tok-double-quote>
    }

    token raw-byte-string-content:sym<b> {
        <tok-pound> 
        <raw-byte-string-content>
        <tok-pound>
    }

    token ascii {
        <any-ascii>
    }

    proto token float-literal { * }

    token float-literal:sym<a> {
        <dec-literal> 
        <tok-dot> 
        <!before [ <tok-dot> | <tok-underscore> | <identifier> ]>
    }

    token float-literal:sym<b> {
        <dec-literal> 
        <float-exponent>
    }

    token float-literal:sym<c> {
        <dec-literal> 
        <tok-dot>
        <dec-literal> 
        <float-exponent>?
    }

    token float-literal:sym<d> {
        <dec-literal> 
        [
            <tok-dot>
            <dec-literal> 
        ]?
        <float-exponent>?
        <float-suffix>
    }

    token float-exponent {
        [ e | E ]
        [ \+ | \- ]?
        [<dec-digit> | <tok-underscore>]*
        <dec-digit>
        [<dec-digit> | <tok-underscore>]*
    }
}

our role Tokens::Actions {}
