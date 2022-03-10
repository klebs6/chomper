our role ClosureExpression::Rules {

    rule closure-expression {
        <kw-move>?
        <closure-expression-opener>
        <closure-body>
    }

    rule closure-expression-opener {
        <tok-or>
        <closure-parameters>?
        <tok-or>
    }

    proto rule closure-body { * }

    rule closure-body:sym<expr> {
        <expression>
    }

    rule closure-body:sym<with-return-type-and-block> {
        <tok-rarrow>
        <type-no-bounds>
        <block-expression>
    }

    #---------------

    rule closure-parameters {
        <closure-param>+ %% <tok-comma>
    }

    rule closure-param {
        <outer-attribute>*
        <pattern-no-top-alt>
        [
            <tok-colon>
            <type>
        ]?
    }
}

our role ClosureExpression::Actions {

}
