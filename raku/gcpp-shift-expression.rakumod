
# rule shift-expression-tail { <shift-operator> <additive-expression> }
our class ShiftExpressionTail {
    has IShiftOperator      $.shift-operator      is required;
    has IAdditiveExpression $.additive-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-expression { <additive-expression> <shift-expression-tail>* } #-----------------------
our class ShiftExpression does IShiftExpression {
    has IAdditiveExpression  $.additive-expression is required;
    has ShiftExpressionTail @.shift-expression-tail is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-operator:sym<right> { <.greater> <.greater> }
our class ShiftOperator::Right does IShiftOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule shift-operator:sym<left> { <.less> <.less> } #-----------------------
our class ShiftOperator::Left does IShiftOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


