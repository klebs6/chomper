our role ReferencePattern::Rules {

    proto rule reference-pattern { * }

    rule reference-pattern:sym<ref>    { <tok-ref> <kw-mut>? <pattern-without-range> }
    rule reference-pattern:sym<refref> { <tok-refref> <kw-mut>? <pattern-without-range> }
}

our role ReferencePattern::Actions {}
