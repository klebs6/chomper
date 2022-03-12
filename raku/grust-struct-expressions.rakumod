our role StructExpression::Rules {

    proto rule struct-expression { * }

    rule struct-expression:sym<struct> {  
        <path-in-expression> 
        <tok-lbrace> 
        <struct-expr-struct-body>? 
        <tok-rbrace> 
    }

    rule struct-expression:sym<tuple> {  
        <path-in-expression> 
        <tok-lparen> 
        [ <expression>* %% <tok-comma> ] 
        <tok-rparen>
    }

    rule struct-expression:sym<unit> {  
        <path-in-expression> 
    }

    #--------------------
    proto rule struct-expr-struct-body { * }
    rule struct-expr-struct-body:sym<fields> { <struct-expr-fields> }
    rule struct-expr-struct-body:sym<base>   { <struct-base> }

    rule struct-expr-fields {
        [ <struct-expr-field>+ %% <tok-comma> ]
        [ <tok-comma>? <struct-base> ]?
    }

    proto rule struct-expr-field { * }
    rule struct-expr-field:sym<tup-expr> { <comment>? <tuple-index> <tok-colon> <expression> }
    rule struct-expr-field:sym<id-expr>  { <comment>? <identifier>  <tok-colon> <expression> }
    rule struct-expr-field:sym<id>       { <comment>? <identifier> }

    rule struct-base {
        <tok-dotdot> <expression>
    }

}

our role StructExpression::Actions {}
