our role StructExpression::Rules {

    #--------------------
    proto rule struct-expression { * }

    rule struct-expression:sym<struct> {
        <struct-expr-struct>
    }

    rule struct-expression:sym<tuple> {
        <struct-expr-tuple>
    }

    rule struct-expression:sym<unit> {
        <struct-expr-unit>
    }

    #--------------------
    rule struct-expr-struct {
        <path-in-expression>
        <tok-lbrace>
        <struct-expr-struct-body>?
        <tok-rbrace>
    }

    proto rule struct-expr-struct-body { * }
    rule struct-expr-struct-body:sym<fields> { <struct-expr-fields> }
    rule struct-expr-struct-body:sym<base>   { <struct-base> }

    rule struct-expr-fields {
        [ <struct-expr-field>+ %% <tok-comma> ]
        [ <tok-comma> <struct-base> ]?
    }

    proto rule struct-expr-field { * }
    rule struct-expr-field:sym<id>       { <identifier> }
    rule struct-expr-field:sym<id-expr>  { <identifier>  <tok-colon> <expression> }
    rule struct-expr-field:sym<tup-expr> { <tuple-index> <tok-colon> <expression> }

    rule struct-base {
        <tok-dotdot> <expression>
    }

    rule struct-expr-tuple {
        <path-in-expression> 
        <tok-lparen> 
        [ <expression>* %% <tok-comma> ] 
        <tok-rparen>
    }

    rule struct-expr-unit {
        <path-in-expression>
    }
}

our role StructExpression::Actions {}
