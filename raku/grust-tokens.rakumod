our role Tokens::Rules 
{
    proto token rust-keyword { * }
    token rust-keyword:sym<strict>   { <strict-keyword> }
    token rust-keyword:sym<weak>     { <weak-keyword> }
    token rust-keyword:sym<reserved> { <reserved-keyword> }

    proto rule rust-token-no-delim { * }
    rule rust-token-no-delim:sym<id>      { <identifier> }
    rule rust-token-no-delim:sym<keyword> { <rust-keyword> }
    rule rust-token-no-delim:sym<lit>     { <literal-expression> }
    rule rust-token-no-delim:sym<lt>      { <lifetime-token> }
    rule rust-token-no-delim:sym<punc>    { <punctuation> }

    proto token rust-token { * }
    token rust-token:sym<no-delim>  { <rust-token-no-delim> }
    token rust-token:sym<delim>     { <delimiter> }

    token token-except-dollar-and-delimiters {
        (<rust-token-no-delim>) <?{$0 !~~ /\$/}>
    }

    token token-except-delimiters-and-repetition-operators {
        (<rust-token-no-delim>) <?{$0 !~~ /<[\$ \*]>/}>
    }
    
    token quote-escape {
        | \\\'
        | \\\"
    }

    token unicode-escape {
        \\u 
        <tok-lbrace> 
        [[ <hex-digit> _* ] ** 1..6] 
        <tok-rbrace> 
    }
}

our role Tokens::Actions {}
