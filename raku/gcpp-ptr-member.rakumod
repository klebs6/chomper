
# rule pointer-member-operator:sym<dot> { 
#   <dot-star> 
# }
our class PointerMemberOperator::Dot does IPointerMemberOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-member-operator:sym<arrow> { 
#   <arrow-star> 
# }
our class PointerMemberOperator::Arrow does IPointerMemberOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-member-expression { 
#   <cast-expression> 
#   <pointer-member-expression-tail>* 
# }
our class PointerMemberExpression does IPointerMemberExpression { 
    has ICastExpression             $.cast-expression is required;
    has PointerMemberExpressionTail @.pointer-member-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pointer-member-expression-tail { 
#   <pointer-member-operator> 
#   <cast-expression> 
# }
our class PointerMemberExpressionTail { 
    has IPointerMemberOperator $.pointer-member-operator is required;
    has ICastExpression         $.cast-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
