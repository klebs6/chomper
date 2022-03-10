our role TupleExpression::Rules {

    rule tuple-expression {
        <tok-lparen>
        <tuple-elements>?
        <tok-rparen>
    }

    rule tuple-elements {
        <expression>* %% <tok-comma>
    }

    rule tuple-indexing-expression {
        <expression> <tok-dot> <tuple-index>
    }
}

our role TupleExpression::Actions {}
