unit module Chomper::Cpp::GcppPostfixExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppTypeId;
use Chomper::Cpp::GcppExpression;

use Chomper::TreeMark;

# rule postfix-expression-cast { 
#   <cast-token> 
#   <less> 
#   <the-type-id> 
#   <greater> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
class PostfixExpressionCast 
does IInitializer 
does IUnaryExpression 
does IPostfixExpressionBody is export { 

    has ICastToken  $.cast-token  is required;
    has ITheTypeId  $.the-type-id is required;
    has IExpression $.expression  is required;

    has $.text;

    method name {
        'PostfixExpressionCast'
    }

    method gist(:$treemark=False) {
        $.cast-token.gist(:$treemark) 
        ~ "<" ~ $.the-type-id.gist(:$treemark) ~ ">" 
        ~ "(" ~ $.expression.gist(:$treemark) ~ ")"
    }
}

package PostfixExpressionTypeId is export {

    # rule postfix-expression-typeid { 
    # <type-id-of-the-type-id> 
    # <.left-paren> 
    # [ <expression> || <the-type-id>] 
    # <.right-paren> 
    # } 
    our class Expr { 
        has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
        has IExpression       $.expression             is required;

        has $.text;

        method name {
            'PostfixExpressionTypeId::Expr'
        }

        method gist(:$treemark=False) {

            my $builder = $.type-id-of-the-type-id.gist(:$treemark);

            $builder ~= "(";
            $builder ~= $.expression.gist(:$treemark);
            $builder ~= ")";

            $builder
        }
    }

    our class TypeId { 
        has TypeIdOfTheTypeId $.type-id-of-the-type-id is required;
        has ITheTypeId        $.the-type-id            is required;

        has $.text;

        method name {
            'PostfixExpressionTypeId::TypeId'
        }

        method gist(:$treemark=False) {
            my $builder = $.type-id-of-the-type-id.gist(:$treemark);

            $builder ~= "(";
            $builder ~= $.the-type-id.gist(:$treemark);
            $builder ~= ")";

            $builder
        }
    }
}

package PostListHead is export {

    # token post-list-head:sym<simple> { <simple-type-specifier> }
    our class Simple does IPostListHead {
        has ISimpleTypeSpecifier $.simple-type-specifier is required;

        has $.text;

        method name {
            'PostListHead::Simple'
        }

        method gist(:$treemark=False) {
            $.simple-type-specifier.gist(:$treemark)
        }
    }

    # token post-list-head:sym<type-name> { <type-name-specifier> } 
    our class TypeName does IPostListHead {
        has ITypeNameSpecifier $.type-name-specifier is required;

        has $.text;

        method name {
            'PostListHead::TypeName'
        }

        method gist(:$treemark=False) {
            $.type-name-specifier.gist(:$treemark)
        }
    }
}

package PostListTail is export {

    our class Parens does IPostListTail {
        has $.value is required;
        has $.text;

        method name {
            'PostListTail::Parens'
        }

        method gist(:$treemark=False) {
            if $.value {
                "(" ~ $.value.gist(:$treemark) ~ ")"
            } else {
                "()"
            }
        }
    }

    our class Braces does IPostListTail {
        has $.value is required;
        has $.text;

        method name {
            'PostListTail::Braces'
        }

        method gist(:$treemark=False) {
            "\{" ~ $.value.gist(:$treemark) ~ "}"
        }
    }
}

# token postfix-expression-list { 
#   <post-list-head> 
#   <post-list-tail> 
# }
class PostfixExpressionList 
does IInitializer 
does IUnaryExpression 
does IPostfixExpressionBody is export { 

    has IPostListHead $.post-list-head is required;
    has IPostListTail $.post-list-tail is required;
    has $.text;

    method name {
        'PostfixExpressionList'
    }

    method token-types {
        [
            $.post-list-head.WHAT.^name.split("::")[*-1], 
            $.post-list-tail.WHAT.^name.split("::")[*-1]
        ]
    }

    method gist(:$treemark=False) {
        $.post-list-head.gist(:$treemark) ~ $.post-list-tail.gist(:$treemark)
    }
}

# rule postfix-expression { 
#   <postfix-expression-body> 
#   <postfix-expression-tail>* 
# }
class PostfixExpression 
does IStatement 
does IReturnStatementBody 
does IUnaryExpression is export {

    has IPostfixExpressionBody $.postfix-expression-body is required;
    has @.postfix-expression-tail;

    has $.text;

    method name {
        'PostfixExpression'
    }

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_Expression>);
        }

        $.postfix-expression-body.gist(:$treemark) 
        ~ @.postfix-expression-tail>>.gist(:$treemark).join("")
    }
}

#------------------------------

package BracketTail is export {

    # rule bracket-tail { 
    #   <.left-bracket>
    #   [ <expression> || <braced-init-list> ]
    #   <.right-bracket>
    # }
    our class Expression 
    does IBracketTail
    does IPostfixExpressionTail { 

        has IExpression $.expression is required;

        has $.text;

        method name {
            'BracketTail::Expression'
        }

        method gist(:$treemark=False) {
            "[" ~ $.expression.gist(:$treemark) ~ "]"
        }
    }

    our class BracedInitList 
    does IBracketTail
    does IPostfixExpressionTail {

        has IBracketTail $.bracket-tail is required;

        has $.text;

        method name {
            'BracketTail::BracedInitList'
        }

        method gist(:$treemark=False) {
            $.bracket-tail.gist(:$treemark)
        }
    }
}

package PostfixExpressionTail is export {

    # rule postfix-expression-tail:sym<bracket> { 
    #   <bracket-tail> 
    # }
    our class Bracket does IPostfixExpressionTail {

        has IBracketTail $.bracket-tail is required;

        has $.text;

        method name {
            'PostfixExpressionTail::Bracket'
        }

        method gist(:$treemark=False) {
            $.bracket-tail.gist(:$treemark)
        }
    }

    # rule postfix-expression-tail:sym<parens> { 
    #   <.left-paren> 
    #   <expression-list>? 
    #   <.right-paren> 
    # }
    our class Parens does IPostfixExpressionTail {

        has ExpressionList $.expression-list;

        has $.text;

        method name {
            'PostfixExpressionTail::Parens'
        }

        method gist(:$treemark=False) {
            my $builder = "(";
            $builder = $builder.&maybe-extend(:$treemark,$.expression-list);
            $builder ~ ")"
        }
    }

    # rule postfix-expression-tail:sym<indirection-id> { 
    #   [ <dot> || <arrow> ] 
    #   <template>? 
    #   <id-expression> 
    # }
    our class IndirectionId does IPostfixExpressionTail {

        has Bool          $.indirect is required;
        has Bool          $.template is required;
        has IIdExpression $.id-expression is required;

        has $.text;

        method name {
            'PostfixExpressionTail::IndirectionId'
        }

        method gist(:$treemark=False) {

            my $builder = "";

            if $.indirect {
                $builder ~= "->";
            } else {
                $builder ~= ".";
            }

            if $.template {
                $builder ~= "template ";
            }

            $builder ~ $.id-expression.gist(:$treemark)
        }
    }

    # rule postfix-expression-tail:sym<indirection-pseudo-dtor> { 
    #   [ <dot> || <arrow> ] 
    #   <pseudo-destructor-name> 
    # }
    our class IndirectionPseudoDtor does IPostfixExpressionTail {

        has Bool                  $.indirect is required;
        has IPseudoDestructorName $.pseudo-destructor-name is required;

        has $.text;

        method name {
            'PostfixExpressionTail::IndirectionPseudoDtor'
        }

        method gist(:$treemark=False) {

            my $builder = "";

            if $.indirect {
                $builder ~= "->";
            } else {
                $builder ~= ".";
            }

            $builder ~ $.pseudo-destructor-name.gist(:$treemark)
        }
    }

    # rule postfix-expression-tail:sym<pp-mm> { 
    #   [ <plus-plus> || <minus-minus> ] 
    # } 
    our class PlusPlus does IPostfixExpressionTail { 

        has $.text;

        method name {
            'PostfixExpressionTail::PlusPlus'
        }

        method gist(:$treemark=False) {
            "++"
        }
    }

    our class MinusMinus does IPostfixExpressionTail { 

        has $.text;

        method name {
            'PostfixExpressionTail::MinusMinus'
        }

        method gist(:$treemark=False) {
            "--"
        }
    }
}

package PostfixExpressionGrammar is export {

    our role Actions {

        # rule postfix-expression { <postfix-expression-body> <postfix-expression-tail>* }
        method postfix-expression($/) {

            my $body = $<postfix-expression-body>.made;
            my @tail = $<postfix-expression-tail>>>.made;

            if @tail and @tail.elems gt 0 {
                make PostfixExpression.new(
                    postfix-expression-body => $body,
                    postfix-expression-tail => @tail,
                    text                    => ~$/,
                )
            } else {
                make $body
            }
        }

        # rule bracket-tail { <.left-bracket> [ <expression> || <braced-init-list> ] <.right-bracket> }
        method bracket-tail:sym<expr>($/) {
            make BracketTail::Expression.new(
                expression => $<expression>.made
            )
        }

        method bracket-tail:sym<braced-init-list>($/) {
            make BracketTail::BracedInitList.new(
                braced-init-list => $<braced-init-list>.made
            )
        }

        # rule postfix-expression-tail:sym<bracket> { <bracket-tail> }
        method postfix-expression-tail:sym<bracket>($/) {
            make PostfixExpressionTail::Bracket.new(
                bracket-tail => $<bracket-tail>.made
            )
        }

        # rule postfix-expression-tail:sym<parens> { <.left-paren> <expression-list>? <.right-paren> }
        method postfix-expression-tail:sym<parens>($/) {
            make PostfixExpressionTail::Parens.new(
                expression-list => $<expression-list>.made,
                text            => ~$/,
            )
        }

        # rule postfix-expression-tail:sym<indirection-id> { [ <dot> || <arrow> ] <template>? <id-expression> }
        method postfix-expression-tail:sym<indirection-id>($/) {
            make PostfixExpressionTail::IndirectionId.new(
                indirect      => so $/<arrow>:exists,
                template      => $<template>.made,
                id-expression => $<id-expression>.made,
                text          => ~$/,
            )
        }

        # rule postfix-expression-tail:sym<indirection-pseudo-dtor> { [ <dot> || <arrow> ] <pseudo-destructor-name> }
        method postfix-expression-tail:sym<indirection-pseudo-dtor>($/) {
            make PostfixExpressionTail::IndirectionPseudoDtor.new(
                pseudo-destructor-name => $<pseudo-destructor-name>.made,
                text                   => ~$/,
            )
        }

        # rule postfix-expression-tail:sym<pp-mm> { [ <plus-plus> || <minus-minus> ] } 
        method postfix-expression-tail:sym<pp>($/) {
            make PostfixExpressionTail::PlusPlus.new
        }

        method postfix-expression-tail:sym<mm>($/) {
            make PostfixExpressionTail::MinusMinus.new
        }

        # token postfix-expression-body { 
        #   || <postfix-expression-list> 
        #   || <postfix-expression-cast> 
        #   || <postfix-expression-typeid> 
        #   || <primary-expression> 
        # } 
        method postfix-expression-body($/) {

            given $/.keys[0] {
                when "postfix-expression-list" {
                    make $<postfix-expression-list>.made
                }
                when "postfix-expression-cast" {
                    make $<postfix-expression-cast>.made
                }
                when "postfix-expression-typeid" {
                    make $<postfix-expression-type-id>.made
                }
                when "primary-expression" {
                    make $<primary-expression>.made
                }
                default {
                    die "bad switch";
                }
            }
        }

        # rule postfix-expression-cast { 
        #   <cast-token> 
        #   <less> 
        #   <the-type-id> 
        #   <greater> 
        #   <.left-paren> 
        #   <expression> 
        #   <.right-paren> 
        # }
        method postfix-expression-cast($/) {
            make PostfixExpressionCast.new(
                cast-token  => $<cast-token>.made,
                the-type-id => $<the-type-id>.made,
                expression  => $<expression>.made,
                text        => ~$/,
            )
        }

        # rule postfix-expression-typeid { 
        #   <type-id-of-the-type-id> 
        #   <.left-paren> 
        #   [ <expression> || <the-type-id>] 
        #   <.right-paren> 
        # } 
        method postfix-expression-typeid:sym<expr>($/) {
            make PostfixExpressionTypeid::Expr.new(
                type-id-of-the-type-id => $<type-id-of-the-type-id>.made,
                expression             => $<expression>.made,
                text                   => ~$/,
            )
        }

        method postfix-expression-typeid:sym<type-id>($/) {
            make PostfixExpressionTypeid::TypeId.new(
                type-id-of-the-type-id => $<type-id-of-the-type-id>.made,
                the-type-id            => $<the-type-id>.made,
                text                   => ~$/,
            )
        }

        # token post-list-head:sym<simple> { <simple-type-specifier> }
        method post-list-head:sym<simple>($/) {
            make $<simple-type-specifier>.made
        }

        # token post-list-head:sym<type-name> { <type-name-specifier> } 
        method post-list-head:sym<type-name>($/) {
            make $<type-name-specifier>.made
        }

        # token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>? <.right-paren> }
        method post-list-tail:sym<parenthesized>($/) {
            make PostListTail::Parens.new(
                value => $<expression-list>.made
            )
        }

        # token post-list-tail:sym<braced> { <braced-init-list> }
        method post-list-tail:sym<braced>($/) {
            make PostListTail::Braces.new(
                value => $<braced-init-list>.made
            )
        }

        # token postfix-expression-list { <post-list-head> <post-list-tail> } 
        method postfix-expression-list($/) {
            make PostfixExpressionList.new(
                post-list-head => $<post-list-head>.made,
                post-list-tail => $<post-list-tail>.made,
                text           => ~$/,
            )
        }
    }

    our role Rules {

        rule postfix-expression {  
            <postfix-expression-body> <postfix-expression-tail>*
        }

        proto rule postfix-expression-tail { * }

        proto rule bracket-tail { * }

        rule bracket-tail:sym<expr> {
            <left-bracket> 
            <expression>
            <right-bracket>
        }

        rule bracket-tail:sym<braced-init-list> {
            <left-bracket> 
            <braced-init-list>
            <right-bracket>
        }

        rule postfix-expression-tail:sym<bracket> {
            <bracket-tail>
        }

        rule postfix-expression-tail:sym<parens> { 
            <left-paren> 
            <expression-list>?  
            <right-paren>
        }

        rule postfix-expression-tail:sym<indirection-id> { 
            [ <dot> ||  <arrow> ]
            <template>?  <id-expression> 
        }

        rule postfix-expression-tail:sym<indirection-pseudo-dtor> { 
            [ <dot> ||  <arrow> ]
            <pseudo-destructor-name> 
        }

        rule postfix-expression-tail:sym<pp> { 
            <plus-plus>
        }

        rule postfix-expression-tail:sym<mm> { 
            <minus-minus>
        }

        #-------------------------------------
        #needs to stay like this for some reason..
        #ie, cant be made proto without breaking some
        #parses, for example:
        #
        # uint8_t{format}
        token postfix-expression-body { 
            || <postfix-expression-cast>
            || <postfix-expression-list>
            || <postfix-expression-typeid>
            || <primary-expression>
        }

        rule postfix-expression-cast {
            <cast-token>
            <less> 
            <the-type-id> 
            <greater> 
            <left-paren> 
            <expression> 
            <right-paren>
        }

        rule postfix-expression-typeid {
            <type-id-of-the-type-id> 
            <left-paren> 
            [ <expression> ||  <the-type-id>] 
            <right-paren>
        }

        #---------------------
        proto token post-list-head { * }
        token post-list-head:sym<simple>    { <simple-type-specifier> }
        token post-list-head:sym<type-name> { <type-name-specifier> }

        #---------------------
        proto token post-list-tail { * }
        token post-list-tail:sym<parenthesized> { <left-paren> <expression-list>?  <right-paren> }
        token post-list-tail:sym<braced>        { <braced-init-list> }

        token postfix-expression-list {
            <post-list-head>
            <post-list-tail>
        }
    }

    =begin comment
    # token post-list-tail:sym<parenthesized> { <.left-paren> <expression-list>? <.right-paren> }
    class PostListTail::Parenthesized does IPostListTail is export {
        has ExpressionList $.expression-list;
    }

    # token post-list-tail:sym<braced> { <braced-init-list> }
    class PostListTail::Braced does IPostListTail is export {
        has BracedInitList $.braced-init-list is required;
    }
    =end comment
}
