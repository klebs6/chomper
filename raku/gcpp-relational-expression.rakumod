
# rule relational-operator:sym<less> { <.less> }
our class RelationalOperator::Less does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule relational-operator:sym<greater> { <.greater> }
our class RelationalOperator::Greater does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule relational-operator:sym<less-eq> { <.less-equal> }
our class RelationalOperator::LessEq does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule relational-operator:sym<greater-eq> { <.greater-equal> }
our class RelationalOperator::GreaterEq does IRelationalOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex relational-expression-tail { 
#   <.ws> 
#   <relational-operator> 
#   <.ws> 
#   <shift-expression> 
# }
our class RelationalExpressionTail {
    has IRelationalOperator  $.relational-operator is required;
    has IShiftExpression     $.shift-expression    is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex relational-expression { 
#   <shift-expression> 
#   <relational-expression-tail>* 
# }
our class RelationalExpression does IRelationalExpression {
    has IShiftExpression         $.shift-expression is required;
    has RelationalExpressionTail @.relational-expression-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

