our class RustToken {
    has $.value;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

our role Tokens::Actions {

    method rust-keyword:sym<strict>($/)         { <strict-keyword> }
    method rust-keyword:sym<weak>($/)           { <weak-keyword> }
    method rust-keyword:sym<reserved>($/)       { <reserved-keyword> }

    method rust-token-no-delim:sym<id>($/)      { <identifier> }
    method rust-token-no-delim:sym<keyword>($/) { <rust-keyword> }
    method rust-token-no-delim:sym<lit>($/)     { <literal-expression> }
    method rust-token-no-delim:sym<lt>($/)      { <lifetime-token> }
    method rust-token-no-delim:sym<punc>($/)    { <punctuation> }

    method rust-token:sym<no-delim>($/)         { <rust-token-no-delim> }
    method rust-token:sym<delim>($/)            { <delimiter> }

    method token-except-dollar-and-delimiters($/) {
        (<rust-token-no-delim>) <?{$0 !~~ /\$/}>
    }

    method token-except-delimiters-and-repetition-operators($/) {
        (<rust-token-no-delim>) <?{$0 !~~ /<[\$ \*]>/}>
    }
    
    method quote-escape($/) {
        | \\\'
        | \\\"
    }

    method unicode-escape($/) {
        \\u 
        <tok-lbrace> 
        [[ <hex-digit> _* ] ** 1..6] 
        <tok-rbrace> 
    }
}
