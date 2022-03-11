our role Statement::Rules {

    rule statements {  
        <statement>*
        <expression-noblock>?
    }

    proto rule statement { * }

    rule statement:sym<semi>          { <tok-semi> }
    regex statement:sym<let>           { <comment>? <let-statement> <line-comment>? }
    rule statement:sym<expr>          { <comment>? <expression-statement> }
    rule statement:sym<macro>         { <comment>? <macro-invocation> }
    rule statement:sym<item>          { <comment>? <crate-item> }

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

    rule expression-statement:sym<noblock> { <expression-noblock> <tok-semi> }
    rule expression-statement:sym<block>   { <expression-with-block> <tok-semi>? }
}

our role Statement::Actions {}
