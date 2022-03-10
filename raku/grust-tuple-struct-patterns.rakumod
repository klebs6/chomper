our role TupleStructPattern::Rules {

    rule tuple-struct-pattern {
        <path-in-expression> 
        <tok-lparen> 
        <tuple-struct-items>? 
        <tok-rparen>
    }

    rule tuple-struct-items {
        <pattern>+ %% <tok-comma>
    }

    rule tuple-pattern {
        <tok-lparen> 
        <tuple-pattern-items>? 
        <tok-rparen>
    }

    proto rule tuple-pattern-items { * }

    rule tuple-pattern-items:sym<rest-pat> {
        <rest-pattern>
    }

    rule tuple-pattern-items:sym<pat> {
        <pattern>+ %% <tok-comma>
    }

    rule grouped-pattern {
        <tok-lparen>
        <pattern>
        <tok-rparen>
    }

    rule slice-pattern {
        <tok-lbrack>
        <slice-pattern-items>?
        <tok-rbrack>
    }

    rule slice-pattern-items {
        <pattern>+ %% <tok-comma>
    }

    proto rule path-pattern { * }
    rule path-pattern:sym<a> { <path-in-expression> }
    rule path-pattern:sym<b> { <qualified-path-in-expression> }
}

our role TupleStructPattern::Actions {}
