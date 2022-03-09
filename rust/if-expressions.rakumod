our role IfExpressions::Rules {
    rule if-expression {
        <kw-if>
        <expression-nostruct>
        <block-expression>
        <else-clause>?
    }

    rule if-let-expression {
        <kw-if>
        <kw-let>
        <pattern>
        <tok-eq>
        <scrutinee-except-lazy-boolean-operator-expression>
        <block-expression>
        <else-clause>?
    }

    rule else-clause {
        <kw-else>
        <else-clause-variant>
    }

    proto rule else-clause-variant { * }

    rule else-clause-variant:sym<block> {  
        <block-expression>
    }

    rule else-clause-variant:sym<if> {  
        <if-expression>
    }

    rule else-clause-variant:sym<if-let> {  
        <if-let-expression>
    }
}
