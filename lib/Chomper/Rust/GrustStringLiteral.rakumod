unit module Chomper::Rust::GrustStringLiteral;

use Data::Dump::Tree;

our class StringLiteral {
    has $.value;

    has $.text;

    method gist {
        $.value
    }
}

our role StringLiteral::Rules {

    token string-literal {
        <tok-double-quote>
        <.string-literal-inner>*
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
        <tok-double-quote>
        <-[\r]>*?
        <tok-double-quote>
    }

    token raw-string-content:sym<b> {
        <tok-pound> 
        <raw-string-content>
        <tok-pound> 
    }
}

our role StringLiteral::Actions {

    method string-literal($/) {
        make StringLiteral.new(
            value => $/.Str
        )
    }
}