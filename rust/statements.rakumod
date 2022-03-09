
our role Statement::Rules {

    proto rule statement { * }

    rule statement:sym<semi>  { <tok-semi> }
    rule statement:sym<item>  { <item> }
    rule statement:sym<let>   { <let-statement> }
    rule statement:sym<expr>  { <expression-statement> }
    rule statement:sym<macro> { <macro-invocation-semi> }

    rule let-statement {
        <outer-attribute>*
        <kw-let>
        <pattern-no-top-alt>
        [
            <tok-colon>
            <type>
        ]?
        [
            <tok-eq>
            <expression>
        ]?
        <tok-semi>
    }

    proto rule expression-statement { * }

    rule expression-statement:sym<noblock> {
        <expression-without-block>
        <tok-semi>
    }

    rule expression-statement:sym<block> { 
        <expression-with-block>
        <tok-semi>?
    }
}
