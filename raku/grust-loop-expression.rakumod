our role LoopExpression::Rules {

    rule loop-expression {
        <loop-label>?
        <loop-expression-variant>
    }

    proto rule loop-expression-variant { * }

    rule loop-expression-variant:sym<infinite-loop> {
        <infinite-loop-expression>
    }

    rule loop-expression-variant:sym<predicate-loop> {
        <predicate-loop-expression>
    }

    rule loop-expression-variant:sym<predicate-pattern-loop> {
        <predicate-pattern-loop-expression>
    }

    rule loop-expression-variant:sym<iterator-loop> {
        <iterator-loop-expression>
    }

    rule infinite-loop-expression {
        <kw-loop> <block-expression>
    }

    rule predicate-loop-expression {
        <kw-while> <expression-nostruct> <block-expression>
    }

    rule predicate-pattern-loop-expression {
        <kw-while>
        <kw-let>
        <pattern>
        <tok-eq>
        <scrutinee-except-lazy-boolean-operator-expression>
        <block-expression>
    }

    rule iterator-loop-expression {
        <kw-for>
        <pattern>
        <kw-in>
        <expression-nostruct>
        <block-expression>
    }

    rule loop-label {
        <lifetime-or-label> 
        <tok-colon>
    }
}

our role LoopExpression::Actions {}
