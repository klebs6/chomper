our class UnaryExpression::New 
does IUnaryExpression { 

    has INewExpression $.new-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UnaryExpression::Case 
does IUnaryExpression {

    has IUnaryExpressionCase $.case is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<postfix> { 
#   <postfix-expression> 
# }
our class UnaryExpressionCase::Postfix 
does IUnaryExpressionCase {

    has PostfixExpression $.postfix-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<pp> { 
#   <plus-plus> 
#   <unary-expression> 
# }
our class UnaryExpressionCase::PlusPlus 
does IUnaryExpressionCase {

    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<mm> { 
#   <minus-minus> 
#   <unary-expression> 
# }
our class UnaryExpressionCase::MinusMinus 
does IUnaryExpressionCase {

    has IUnaryExpression $.unary-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<unary-op> { 
#   <unary-operator> 
#   <unary-expression> 
# }
our class UnaryExpressionCase::UnaryOp 
does IPostfixExpressionBody 
does IUnaryExpressionCase {

    has IUnaryOperator   $.unary-operator   is required;
    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<sizeof> { 
#   <sizeof> 
#   <unary-expression> 
# }
our class UnaryExpressionCase::Sizeof 
does IUnaryExpressionCase {

    has IUnaryExpression $.unary-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<sizeof-typeid> { 
#   <sizeof> 
#   <.left-paren> 
#   <the-type-id> 
#   <.right-paren> 
# }
our class UnaryExpressionCase::SizeofTypeid 
does IUnaryExpressionCase {

    has ITheTypeId $.the-type-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<sizeof-ids> { 
#   <sizeof> 
#   <ellipsis> 
#   <.left-paren> 
#   <identifier> 
#   <.right-paren> 
# }
our class UnaryExpressionCase::SizeofIds 
does IUnaryExpressionCase {

    has Identifier $.identifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<alignof> { 
#   <alignof> 
#   <.left-paren> 
#   <the-type-id> 
#   <.right-paren> 
# }
our class UnaryExpressionCase::Alignof 
does IUnaryExpressionCase {

    has ITheTypeId $.the-type-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<noexcept> { 
#   <no-except-expression> 
# }
our class UnaryExpressionCase::Noexcept 
does IUnaryExpressionCase {

    has NoExceptExpression $.no-except-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-expression-case:sym<delete> { 
#   <delete-expression> 
# }
our class UnaryExpressionCase::Delete 
does IUnaryExpressionCase {

    has DeleteExpression $.delete-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

#---------------------------

# rule unary-operator:sym<or_> { <or_> }
our class UnaryOperator::Or does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<star> { <star> }
our class UnaryOperator::Star does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<and_> { <and_> }
our class UnaryOperator::And does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<plus> { <plus> }
our class UnaryOperator::Plus does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<tilde> { <tilde> }
our class UnaryOperator::Tilde does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<minus> { 
#   <minus> 
# }
our class UnaryOperator::Minus 
does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule unary-operator:sym<not> { 
#   <not_> 
# }
our class UnaryOperator::Not 
does IUnaryOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
