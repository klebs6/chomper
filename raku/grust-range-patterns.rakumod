our role RangePattern::Rules {

    proto rule range-pattern { * }

    rule range-pattern:sym<inclusive> { <inclusive-range-pattern> }
    rule range-pattern:sym<half-open> { <half-open-range-pattern> }
    rule range-pattern:sym<obsolete>  { <obsolete-range-pattern> }

    rule inclusive-range-pattern {
        <range-pattern-bound> <tok-dotdoteq> <range-pattern-bound>
    }

    rule half-open-range-pattern {
        <tok-or> <range-pattern-bound> <tok-dotdot>
    }

    rule obsolete-range-pattern {
        <range-pattern-bound> <tok-dotdotdot> <range-pattern-bound>
    }

    proto rule range-pattern-bound { * }

    rule range-pattern-bound:sym<char> {
        <char-literal>
    }

    rule range-pattern-bound:sym<byte> {
        <byte-literal>
    }

    rule range-pattern-bound:sym<int> {
        <tok-minus>? <integer-literal>
    }

    rule range-pattern-bound:sym<float> {
        <tok-minus>? <float-literal>
    }

    rule range-pattern-bound:sym<path-in> {
        <path-in-expression>
    }

    rule range-pattern-bound:sym<qualified-path-in> {
        <qualified-path-in-expression>
    }
}

our role RangePattern::Actions {}
