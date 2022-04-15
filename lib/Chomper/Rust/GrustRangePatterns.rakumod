unit module Chomper::Rust::GrustRangePatterns;

use Data::Dump::Tree;

our class RangePatternInclusive {
    has $.range-pattern-bound-begin;
    has $.range-pattern-bound-end;

    has $.text;

    method gist {
        $.range-pattern-bound-begin.gist 
        ~ "..="
        ~ $.range-pattern-bound-end.gist 
    }
}

our class RangePatternHalfOpen {
    has $.range-pattern-bound-begin;

    has $.text;

    method gist {
        $.range-pattern-bound-begin.gist 
        ~ ".."
        ~ $.range-pattern-bound-end.gist 
    }
}

our class RangePatternObsolete {
    has $.range-pattern-bound-begin;
    has $.range-pattern-bound-end;

    has $.text;

    method gist {
        $.range-pattern-bound-begin.gist 
        ~ "..."
        ~ $.range-pattern-bound-end.gist 
    }
}

our role RangePattern::Rules {

    proto rule range-pattern { * }

    rule range-pattern:sym<inclusive> { 
        <range-pattern-bound> 
        <tok-dotdoteq> 
        <range-pattern-bound>
    }

    rule range-pattern:sym<half-open> { 
        <tok-or> 
        <range-pattern-bound> 
        <tok-dotdot>
    }

    rule range-pattern:sym<obsolete>  { 
        <range-pattern-bound> 
        <tok-dotdotdot> 
        <range-pattern-bound>
    }

    proto rule range-pattern-bound { * }

    rule range-pattern-bound:sym<char>              { <char-literal> }
    rule range-pattern-bound:sym<byte>              { <byte-literal> }
    rule range-pattern-bound:sym<int>               { <integer-literal-pattern> }
    rule range-pattern-bound:sym<float>             { <float-literal-pattern> }
    rule range-pattern-bound:sym<path-in>           { <path-in-expression> }
    rule range-pattern-bound:sym<qualified-path-in> { <qualified-path-in-expression> }
}

our role RangePattern::Actions {

    method range-pattern:sym<inclusive>($/) { 
        make RangePatternInclusive.new(
            range-pattern-bound-begin => $<range-pattern-bound>>>.made[0],
            range-pattern-bound-end   => $<range-pattern-bound>>>.made[1],
            text                      => $/.Str,
        )
    }

    method range-pattern:sym<half-open>($/) { 
        make RangePatternHalfOpen.new(
            range-pattern-bound-begin => $<range-pattern-bound>.made,
            text                      => $/.Str,
        )
    }

    method range-pattern:sym<obsolete>($/)  { 
        make RangePatternObsolete.new(
            range-pattern-bound-begin => $<range-pattern-bound>>>.made[0],
            range-pattern-bound-end   => $<range-pattern-bound>>>.made[1],
            text                      => $/.Str,
        )
    }

    method range-pattern-bound:sym<char>($/) { make $<char-literal>.made }
    method range-pattern-bound:sym<byte>($/) { make $<byte-literal>.made }

    method range-pattern-bound:sym<int>($/) { 
        make $<integer-literal-pattern>.made
    }

    method range-pattern-bound:sym<float>($/) { 
        make $<float-literal-pattern>.made
    }

    method range-pattern-bound:sym<path-in>($/)           { make $<path-in-expression>.made }
    method range-pattern-bound:sym<qualified-path-in>($/) { make $<qualified-path-in-expression>.made }
}