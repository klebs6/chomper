our role ComparisonExpression::Rules {

    proto rule lazy-boolean-expression { * }

    rule lazy-boolean-expression:sym<||> {
        <expression> <tok-oror> <expression>
    }

    rule lazy-boolean-expression:sym<&&> {
        <expression> <tok-andand> <expression>
    }

    proto rule comparison-expression { * }

    rule comparison-expression:sym<eq> {
        <expression> <tok-eqeq> <expression>
    }

    rule comparison-expression:sym<ne> {
        <expression> <tok-ne> <expression>
    }

    rule comparison-expression:sym<gt> {
        <expression> <tok-gt> <expression>
    }

    rule comparison-expression:sym<lt> {
        <expression> <tok-lt> <expression>
    }

    rule comparison-expression:sym<ge> {
        <expression> <tok-ge> <expression>
    }

    rule comparison-expression:sym<le> {
        <expression> <tok-le> <expression>
    }
}
