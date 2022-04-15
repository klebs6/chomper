unit module Chomper::Rust::GrustTokens;

use Data::Dump::Tree;

our class RustToken {
    has $.value;

    has $.text;

    method gist {
        $.value.gist
    }
}

our class UnicodeEscape {
    has $.value;
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

    method rust-keyword:sym<strict>($/)                         { make $<strict-keyword>.made }
    method rust-keyword:sym<weak>($/)                           { make $<weak-keyword>.made }
    method rust-keyword:sym<reserved>($/)                       { make $<reserved-keyword>.made }
    method rust-token-no-delim:sym<id>($/)                      { make $<identifier>.made }
    method rust-token-no-delim:sym<keyword>($/)                 { make $<rust-keyword>.made }
    method rust-token-no-delim:sym<lit>($/)                     { make $<literal-expression>.made }
    method rust-token-no-delim:sym<lt>($/)                      { make $<lifetime-token>.made }
    method rust-token-no-delim:sym<punc>($/)                    { make $<punctuation>.made }
    method rust-token:sym<no-delim>($/)                         { make $<rust-token-no-delim>.made }
    method rust-token:sym<delim>($/)                            { make $<delimiter>.made }
    method token-except-dollar-and-delimiters($/)               { make $<rust-token-no-delim>.made }
    method token-except-delimiters-and-repetition-operators($/) { make $<rust-token-no-delim>.made }
    
    method unicode-escape($/) {
        make UnicodeEscape.new(
            value => $/.Str
        )
    }
}