our role ArrayExpression::Rules {

    proto rule array-elements { * }

    rule array-elements:sym<semi> {
        <expression> <tok-semi> <expression>
    }

    rule array-elements:sym<commas> {
        <expression>+ %% <tok-comma>
    }

    rule array-expression {
        <tok-lbrack> <array-elements>? <tok-rbrack> 
    }
}

our role ArrayExpression::Actions { }

our role TupleExpression::Rules {

    rule tuple-elements {
        <expression>* %% <tok-comma>
    }

    rule tuple-expression {
        <tok-lparen> <tuple-elements>? <tok-rparen> 
    }

    token tuple-index { <integer-literal> }
}

our role TupleExpression::Actions {}

