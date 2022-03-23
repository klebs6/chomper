use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-delete-expression;
use gcpp-noexcept;
use gcpp-postfix-expression;

our class UnaryExpression::New 
does IUnaryExpression { 

    has INewExpression $.new-expression is required;

    has $.text;

    method gist{
        $.new-expression.gist
    }
}

our class UnaryExpression::Case 
does IUnaryExpression {

    has IUnaryExpressionCase $.case is required;

    has $.text;

    method gist{
        $.case.gist
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
        $.postfix-expression.gist
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
        "++"
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
        "--"
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
        $.unary-operator.gist ~ " " ~ $.unary-expression.gist
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
        "sizeof " ~ $.unary-expression.gist
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
        "sizeof(" ~ $.the-type-id.gist ~ ")"
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
        "sizeof ... (" ~ $.identifier.gist ~ ")"
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
        "alignof(" ~ $.the-type-id.gist ~ ")"
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
        $.no-except-expression.gist
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
        $.delete-expression.gist
    }
}

#---------------------------

# rule unary-operator:sym<or_> { <or_> }
our class UnaryOperator::Or does IUnaryOperator { 

    has $.text;

    method gist{
        '|'
    }
}

# rule unary-operator:sym<star> { <star> }
our class UnaryOperator::Star does IUnaryOperator { 

    has $.text;

    method gist{
        '*'
    }
}

# rule unary-operator:sym<and_> { <and_> }
our class UnaryOperator::And does IUnaryOperator { 

    has $.text;

    method gist{
        '&'
    }
}

# rule unary-operator:sym<plus> { <plus> }
our class UnaryOperator::Plus does IUnaryOperator { 

    has $.text;

    method gist{
        '+'
    }
}

# rule unary-operator:sym<tilde> { <tilde> }
our class UnaryOperator::Tilde does IUnaryOperator { 

    has $.text;

    method gist{
        '~'
    }
}

# rule unary-operator:sym<minus> { 
#   <minus> 
# }
our class UnaryOperator::Minus 
does IUnaryOperator { 

    has $.text;

    method gist{
        '-'
    }
}

# rule unary-operator:sym<not> { 
#   <not_> 
# }
our class UnaryOperator::Not 
does IUnaryOperator { 

    has $.text;

    method gist{
        '!'
    }
}

our role UnaryExpression::Actions {

    # rule unary-expression { || <new-expression> || <unary-expression-case> }
    method unary-expression($/) {
        make do if $/<new-expression>:exists {
            $<new-expression>.made
        } else {
            $<unary-expression-case>.made
        }
    }

    # rule unary-expression-case:sym<postfix> { <postfix-expression> }
    method unary-expression-case:sym<postfix>($/) {
        make $<postfix-expression>.made
    }

    # rule unary-expression-case:sym<pp> { <plus-plus> <unary-expression> }
    method unary-expression-case:sym<pp>($/) {
        make UnaryExpressionCase::PlusPlus.new(
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<mm> { <minus-minus> <unary-expression> }
    method unary-expression-case:sym<mm>($/) {
        make UnaryExpressionCase::MinusMinus.new(
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
    method unary-expression-case:sym<unary-op>($/) {
        make UnaryExpressionCase::UnaryOp.new(
            unary-operator => $<unary-operator>.made,
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<sizeof> { <sizeof> <unary-expression> }
    method unary-expression-case:sym<sizeof>($/) {
        make UnaryExpressionCase::Sizeof.new(
            unary-expression => $<unary-expression>.made,
        )
    }

    # rule unary-expression-case:sym<sizeof-typeid> { <sizeof> <.left-paren> <the-type-id> <.right-paren> }
    method unary-expression-case:sym<sizeof-typeid>($/) {
        make UnaryExpressionCase::SizeofTypeid.new(
            the-type-id => $<the-type-id>.made,
        )
    }

    # rule unary-expression-case:sym<sizeof-ids> { <sizeof> <ellipsis> <.left-paren> <identifier> <.right-paren> }
    method unary-expression-case:sym<sizeof-ids>($/) {
        make UnaryExpressionCase::SizeofIds.new(
            identifier => $<identifier>.made,
        )
    }

    # rule unary-expression-case:sym<alignof> { <alignof> <.left-paren> <the-type-id> <.right-paren> }
    method unary-expression-case:sym<alignof>($/) {
        make UnaryExpressionCase::Alignof.new(
            the-type-id => $<the-type-id>.made,
        )
    }

    # rule unary-expression-case:sym<noexcept> { <no-except-expression> }
    method unary-expression-case:sym<noexcept>($/) {
        make $<no-except-expression>.made
    }

    # rule unary-expression-case:sym<delete> { <delete-expression> } 
    method unary-expression-case:sym<delete>($/) {
        make $<delete-expression>.made
    }

    # rule unary-operator:sym<or_> { <or_> }
    method unary-operator:sym<or_>($/) {
        make UnaryOperator::Or.new
    }

    # rule unary-operator:sym<star> { <star> }
    method unary-operator:sym<star>($/) {
        make UnaryOperator::Star.new
    }

    # rule unary-operator:sym<and_> { <and_> }
    method unary-operator:sym<and_>($/) {
        make UnaryOperator::And.new
    }

    # rule unary-operator:sym<plus> { <plus> }
    method unary-operator:sym<plus>($/) {
        make UnaryOperator::Plus.new
    }

    # rule unary-operator:sym<tilde> { <tilde> }
    method unary-operator:sym<tilde>($/) {
        make UnaryOperator::Tilde.new
    }

    # rule unary-operator:sym<minus> { <minus> }
    method unary-operator:sym<minus>($/) {
        make UnaryOperator::Minus.new
    }

    # rule unary-operator:sym<not> { <not_> } 
    method unary-operator:sym<not>($/) {
        make UnaryOperator::Not.new
    }
}

our role UnaryExpression::Rules {

    rule unary-expression { 
        || <new-expression>
        || <unary-expression-case>
    }

    proto rule unary-expression-case { * }
    rule unary-expression-case:sym<postfix>  { <postfix-expression> }
    rule unary-expression-case:sym<pp>       { <plus-plus> <unary-expression> }
    rule unary-expression-case:sym<mm>       { <minus-minus> <unary-expression> }
    rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
    rule unary-expression-case:sym<sizeof>   { <sizeof> <unary-expression> }

    rule unary-expression-case:sym<sizeof-typeid> {
        <sizeof>
        <left-paren>
        <the-type-id>
        <right-paren>
    }

    rule unary-expression-case:sym<sizeof-ids> {
        <sizeof>
        <ellipsis>
        <left-paren>
        <identifier>
        <right-paren>
    }

    rule unary-expression-case:sym<alignof>  { <alignof> <left-paren> <the-type-id> <right-paren> }
    rule unary-expression-case:sym<noexcept> { <no-except-expression> }
    rule unary-expression-case:sym<delete>   { <delete-expression> }

    proto rule unary-operator { * } 
    rule unary-operator:sym<or_>   { <or_>   } 
    rule unary-operator:sym<star>  { <star>  }
    rule unary-operator:sym<and_>  { <and_>  } 
    rule unary-operator:sym<plus>  { <plus>  } 
    rule unary-operator:sym<tilde> { <tilde> } 
    rule unary-operator:sym<minus> { <minus> } 
    rule unary-operator:sym<not>   { <not_>  } 
}
