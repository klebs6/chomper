our role AssignmentExpression::Rules {

    rule assignment-expression {
        <expression> <tok-eq> <expression>
    }

    proto rule compound-assignment-expression { * }

    rule compound-assignment-expression:sym<+=> {
        <expression> <tok-pluseq> <expression>
    }

    rule compound-assignment-expression:sym<-=> {
        <expression> <tok-minuseq> <expression>
    }

    rule compound-assignment-expression:sym<*=> {
        <expression> <tok-stareq> <expression>
    }

    rule compound-assignment-expression:sym</=> {
        <expression> <tok-diveq> <expression>
    }

    rule compound-assignment-expression:sym<%=> {
        <expression> <tok-percenteq> <expression>
    }

    rule compound-assignment-expression:sym<&=> {
        <expression> <tok-andeq> <expression>
    }

    rule compound-assignment-expression:sym<|=> {
        <expression> <tok-oreq> <expression>
    }

    rule compound-assignment-expression:sym<^=> {
        <expression> <tok-careteq> <expression>
    }

    rule compound-assignment-expression:sym<shl-eq> {
        <expression> <tok-shleq> <expression>
    }

    rule compound-assignment-expression:sym<shr-eq> {
        <expression> <tok-shreq> <expression>
    }
}

our role AssignmentExpression::Actions {

}
