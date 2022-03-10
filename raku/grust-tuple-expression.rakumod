our role TupleExpression::Rules {

    rule tuple-elements {
        <expression>* %% <tok-comma>
    }
}

our role TupleExpression::Actions {}
