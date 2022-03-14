our class StructExpressionStruct {
    has $.path-in-expression;
    has $.maybe-struct-expr-struct-body;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExpressionTuple {
    has $.path-in-expression;
    has @.expressions;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExpressionUnit {
    has $.path-in-expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExprFields {
    has @.struct-expr-fields;
    has $.maybe-struct-base;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExprFieldTupleExpr {
    has $.maybe-comment;
    has $.tuple-index;
    has $.expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExprFieldIdExpr {
    has $.maybe-comment;
    has $.identifier;
    has $.expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructExprFieldId {
    has $.maybe-comment;
    has $.identifier;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StructBase {
    has $.expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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

our role StructExpression::Actions {

    method struct-expression:sym<struct>($/) {  
        <path-in-expression> 
        <tok-lbrace> 
        <struct-expr-struct-body>? 
        <tok-rbrace> 
    }

    method struct-expression:sym<tuple>($/) {  
        <path-in-expression> 
        <tok-lparen> 
        [ <expression>* %% <tok-comma> ] 
        <tok-rparen>
    }

    method struct-expression:sym<unit>($/) {  
        <path-in-expression> 
    }

    #--------------------
    method struct-expr-struct-body:sym<fields>($/) { <struct-expr-fields> }
    method struct-expr-struct-body:sym<base>($/)   { <struct-base> }

    method struct-expr-fields($/) {
        [ <struct-expr-field>+ %% <tok-comma> ]
        [ <tok-comma>? <struct-base> ]?
    }

    method struct-expr-field:sym<tup-expr>($/) { <comment>? <tuple-index> <tok-colon> <expression> }
    method struct-expr-field:sym<id-expr>($/)  { <comment>? <identifier>  <tok-colon> <expression> }
    method struct-expr-field:sym<id>($/)       { <comment>? <identifier> }

    method struct-base($/) {
        <tok-dotdot> <expression>
    }
}
