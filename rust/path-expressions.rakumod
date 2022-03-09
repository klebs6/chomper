our role PathExpression::Rules {

    proto rule path-expression { * }

    rule path-expression:sym<path-in> {
        <path-in-expression>
    }

    rule path-expression:sym<qualified-path-in> {
        <qualified-path-in-expression>
    }
}
