unit module Chomper::Cpp::GcppUnaryExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppDeleteExpression;
use Chomper::Cpp::GcppNoexcept;
use Chomper::Cpp::GcppPostfixExpression;

package UnaryExpression is export {

    our class New does IUnaryExpression { 

        has INewExpression $.new-expression is required;

        has $.text;

        method gist(:$treemark=False) {
            $.new-expression.gist(:$treemark)
        }
    }

    our class Case does IUnaryExpression {

        has IUnaryExpressionCase $.case is required;

        has $.text;

        method gist(:$treemark=False) {
            $.case.gist(:$treemark)
        }
    }
}

package UnaryExpressionCase is export {

    # rule unary-expression-case:sym<postfix> { 
    #   <postfix-expression> 
    # }
    our class Postfix does IUnaryExpressionCase {

        has PostfixExpression $.postfix-expression is required;

        has $.text;

        method gist(:$treemark=False) {
            $.postfix-expression.gist(:$treemark)
        }
    }

    # rule unary-expression-case:sym<pp> { 
    #   <plus-plus> 
    #   <unary-expression> 
    # }
    our class PlusPlus does IUnaryExpressionCase {

        has IUnaryExpression $.unary-expression is required;

        has $.text;

        method gist(:$treemark=False) {
            "++" ~ $.unary-expression.gist(:$treemark)
        }
    }

    # rule unary-expression-case:sym<mm> { 
    #   <minus-minus> 
    #   <unary-expression> 
    # }
    our class MinusMinus does IUnaryExpressionCase {

        has IUnaryExpression $.unary-expression is required;
        has $.text;

        method gist(:$treemark=False) {
            "--" ~ $.unary-expression.gist(:$treemark)
        }
    }

    # rule unary-expression-case:sym<unary-op> { 
    #   <unary-operator> 
    #   <unary-expression> 
    # }
    our class UnaryOp 
    does IPostfixExpressionBody 
    does IUnaryExpressionCase {

        has IUnaryOperator   $.unary-operator   is required;
        has IUnaryExpression $.unary-expression is required;

        has $.text;

        method gist(:$treemark=False) {
            $.unary-operator.gist(:$treemark) ~ " " ~ $.unary-expression.gist(:$treemark)
        }
    }

    # rule unary-expression-case:sym<sizeof> { 
    #   <sizeof> 
    #   <unary-expression> 
    # }
    our class Sizeof 
    does IUnaryExpressionCase {

        has IUnaryExpression $.unary-expression is required;
        has $.text;

        method gist(:$treemark=False) {
            "sizeof " ~ $.unary-expression.gist(:$treemark)
        }
    }

    # rule unary-expression-case:sym<sizeof-typeid> { 
    #   <sizeof> 
    #   <.left-paren> 
    #   <the-type-id> 
    #   <.right-paren> 
    # }
    our class SizeofTypeid 
    does IUnaryExpressionCase {

        has ITheTypeId $.the-type-id is required;
        has $.text;

        method gist(:$treemark=False) {
            "sizeof(" ~ $.the-type-id.gist(:$treemark) ~ ")"
        }
    }

    # rule unary-expression-case:sym<sizeof-ids> { 
    #   <sizeof> 
    #   <ellipsis> 
    #   <.left-paren> 
    #   <identifier> 
    #   <.right-paren> 
    # }
    our class SizeofIds 
    does IUnaryExpressionCase {

        has Identifier $.identifier is required;
        has $.text;

        method gist(:$treemark=False) {
            "sizeof ... (" ~ $.identifier.gist(:$treemark) ~ ")"
        }
    }

    # rule unary-expression-case:sym<alignof> { 
    #   <alignof> 
    #   <.left-paren> 
    #   <the-type-id> 
    #   <.right-paren> 
    # }
    our class Alignof 
    does IUnaryExpressionCase {

        has ITheTypeId $.the-type-id is required;
        has $.text;

        method gist(:$treemark=False) {
            "alignof(" ~ $.the-type-id.gist(:$treemark) ~ ")"
        }
    }

    # rule unary-expression-case:sym<noexcept> { 
    #   <no-except-expression> 
    # }
    our class Noexcept 
    does IUnaryExpressionCase {

        has NoExceptExpression $.no-except-expression is required;
        has $.text;

        method gist(:$treemark=False) {
            $.no-except-expression.gist(:$treemark)
        }
    }

    # rule unary-expression-case:sym<delete> { 
    #   <delete-expression> 
    # }
    our class Delete 
    does IUnaryExpressionCase {

        has DeleteExpression $.delete-expression is required;
        has $.text;

        method gist(:$treemark=False) {
            $.delete-expression.gist(:$treemark)
        }
    }
}

#---------------------------

package UnaryOperator is export {

    # rule unary-operator:sym<or_> { <or_> }
    our class Or does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '|'
        }
    }

    # rule unary-operator:sym<star> { <star> }
    our class Star does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '*'
        }
    }

    # rule unary-operator:sym<and_> { <and_> }
    our class And does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '&'
        }
    }

    # rule unary-operator:sym<plus> { <plus> }
    our class Plus does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '+'
        }
    }

    # rule unary-operator:sym<tilde> { <tilde> }
    our class Tilde does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '~'
        }
    }

    # rule unary-operator:sym<minus> { 
    #   <minus> 
    # }
    our class Minus does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '-'
        }
    }

    # rule unary-operator:sym<not> { 
    #   <not_> 
    # }
    our class Not does IUnaryOperator { 

        has $.text;

        method gist(:$treemark=False) {
            '!'
        }
    }
}

package UnaryExpressionGrammar is export {

    our role Actions {

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
                text             => ~$/,
            )
        }

        # rule unary-expression-case:sym<mm> { <minus-minus> <unary-expression> }
        method unary-expression-case:sym<mm>($/) {
            make UnaryExpressionCase::MinusMinus.new(
                unary-expression => $<unary-expression>.made,
                text             => ~$/,
            )
        }

        # rule unary-expression-case:sym<unary-op> { <unary-operator> <unary-expression> }
        method unary-expression-case:sym<unary-op>($/) {
            make UnaryExpressionCase::UnaryOp.new(
                unary-operator   => $<unary-operator>.made,
                unary-expression => $<unary-expression>.made,
                text             => ~$/,
            )
        }

        # rule unary-expression-case:sym<sizeof> { <sizeof> <unary-expression> }
        method unary-expression-case:sym<sizeof>($/) {
            make UnaryExpressionCase::Sizeof.new(
                unary-expression => $<unary-expression>.made,
                text             => ~$/,
            )
        }

        # rule unary-expression-case:sym<sizeof-typeid> { <sizeof> <.left-paren> <the-type-id> <.right-paren> }
        method unary-expression-case:sym<sizeof-typeid>($/) {
            make UnaryExpressionCase::SizeofTypeid.new(
                the-type-id => $<the-type-id>.made,
                text        => ~$/,
            )
        }

        # rule unary-expression-case:sym<sizeof-ids> { <sizeof> <ellipsis> <.left-paren> <identifier> <.right-paren> }
        method unary-expression-case:sym<sizeof-ids>($/) {
            make UnaryExpressionCase::SizeofIds.new(
                identifier => $<identifier>.made,
                text       => ~$/,
            )
        }

        # rule unary-expression-case:sym<alignof> { <alignof> <.left-paren> <the-type-id> <.right-paren> }
        method unary-expression-case:sym<alignof>($/) {
            make UnaryExpressionCase::Alignof.new(
                the-type-id => $<the-type-id>.made,
                text        => ~$/,
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

    our role Rules {

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
}
