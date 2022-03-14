our class RangePatternInclusive {
    has $.range-pattern-bound-begin;
    has $.range-pattern-bound-end;

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

our class RangePatternHalfOpen {
    has $.range-pattern-bound-begin;

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

our class RnagePatternObsolete {
    has $.range-pattern-bound-begin;
    has $.range-pattern-bound-end;

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
    rule range-pattern-bound:sym<int>               { <tok-minus>? <integer-literal> }
    rule range-pattern-bound:sym<float>             { <tok-minus>? <float-literal> }
    rule range-pattern-bound:sym<path-in>           { <path-in-expression> }
    rule range-pattern-bound:sym<qualified-path-in> { <qualified-path-in-expression> }
}

our role RangePattern::Actions {

    method range-pattern:sym<inclusive>($/) { 
        <range-pattern-bound> 
        <tok-dotdoteq> 
        <range-pattern-bound>
    }

    method range-pattern:sym<half-open>($/) { 
        <tok-or> 
        <range-pattern-bound> 
        <tok-dotdot>
    }

    method range-pattern:sym<obsolete>($/)  { 
        <range-pattern-bound> 
        <tok-dotdotdot> 
        <range-pattern-bound>
    }

    method range-pattern-bound:sym<char>($/)              { <char-literal> }
    method range-pattern-bound:sym<byte>($/)              { <byte-literal> }
    method range-pattern-bound:sym<int>($/)               { <tok-minus>? <integer-literal> }
    method range-pattern-bound:sym<float>($/)             { <tok-minus>? <float-literal> }
    method range-pattern-bound:sym<path-in>($/)           { <path-in-expression> }
    method range-pattern-bound:sym<qualified-path-in>($/) { <qualified-path-in-expression> }
}
