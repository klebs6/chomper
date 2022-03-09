our role MatchExpression::Rules {

    rule match-expression {
        <kw-match> 
        <scrutinee> 
        <tok-lbrace>
        <inner-attribute>*
        <match-arms>?
        <tok-rbrace>
    }

    rule scrutinee {
        <expression-except-struct-expression>
    }

    #------------------
    rule match-arms {
        <match-arms-inner-item>*
        <match-arms-outer-item>
    }

    proto rule match-arms-inner-item { * }

    rule match-arms-inner-item:sym<without-block> {  
        <match-arm> 
        <tok-fat-rarrow> 
        <expression-without-block> 
        <tok-comma>
    }

    rule match-arms-inner-item:sym<with-block> {  
        <match-arm>
        <tok-fat-rarrow>
        <expression-with-block>
        <tok-comma>?
    }

    rule match-arms-outer-item {
        <match-arm> 
        <tok-fat-rarrow> 
        <expression> 
        <tok-comma>?
    }

    rule match-arm {
        <outer-attribute>*
        <pattern>
        <match-arm-guard>?
    }

    rule match-arm-guard {
        <kw-if> <expression>
    }
}
