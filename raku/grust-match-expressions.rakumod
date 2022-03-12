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
        <expression-nostruct>
    }

    rule scrutinee-except-lazy-boolean-operator-expression {
        <scrutinee> <?{$0 !~~ <binary-oror-expression>}>
    }

    #------------------
    rule match-arms {
        <match-arms-inner-item>*
        <match-arms-outer-item>
        <comment>?
    }

    proto rule match-arms-inner-item { * }

    rule match-arms-inner-item:sym<with-block> {  
        <comment>?
        <match-arm>
        <tok-fat-rarrow>
        <expression-with-block>
        <tok-comma>?
    }

    rule match-arms-inner-item:sym<without-block> {  
        <comment>?
        <match-arm> 
        <tok-fat-rarrow> 
        <expression-noblock> 
        <tok-comma>
    }

    rule match-arms-outer-item {
        <comment>?
        <match-arm> 
        <tok-fat-rarrow> 
        [
            | <expression-with-block> 
            | <expression-noblock> 
        ]
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

our role MatchExpression::Actions {}
