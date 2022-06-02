unit module Chomper::Cpp::GcppCondition;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppExpression;

use Chomper::TreeMark;

package Condition is export {

    # rule condition:sym<expr> { 
    #   <expression> 
    # }
    class Expr does ICondition is export {
        has IExpression $.expression is required;

        has $.text;

        method name {
            'Condition::Expr'
        }

        method gist(:$treemark=False) {
            $.expression.gist(:$treemark)
        }
    }

    # rule condition:sym<decl> { 
    #   <attribute-specifier-seq>? 
    #   <decl-specifier-seq> 
    #   <declarator> 
    #   <condition-decl-tail> 
    # }
    class Decl does ICondition is export {
        has IAttributeSpecifierSeq $.attribute-specifier-seq;
        has IDeclSpecifierSeq      $.decl-specifier-seq  is required;
        has IDeclarator            $.declarator          is required;
        has IConditionDeclTail    $.condition-decl-tail is required;

        has $.text;

        method name {
            'Condition::Decl'
        }

        method gist(:$treemark=False) {

            if $treemark {
                return sigil(TreeMark::<_Condition>);
            }

            my $builder = "";

            if $.attribute-specifier-seq {
                $builder ~= $.attribute-specifier-seq.gist(:$treemark) ~ " ";
            }

            $builder ~= $.decl-specifier-seq.gist(:$treemark) ~ " ";
            $builder ~= $.declarator.gist(:$treemark) ~ " ";
            $builder ~ $.condition-decl-tail.gist(:$treemark)
        }
    }
}

package ConditionDeclTail is export {

    # rule condition-decl-tail:sym<assign-init> { 
    #   <assign> 
    #   <initializer-clause> 
    # }
    our class AssignInit 
    does IInitializer
    does IConditionDeclTail {
        has IInitializerClause $.initializer-clause is required;

        has $.text;

        method name {
            'ConditionDeclTail::AssignInit'
        }

        method gist(:$treemark=False) {
            " = " ~ $.initializer-clause.gist(:$treemark)
        }
    }

    # rule condition-decl-tail:sym<braced-init> { 
    #   <braced-init-list> 
    # }
    our class BracedInit 
    does IInitializer
    does IConditionDeclTail {
        has BracedInitList $.braced-init-list is required;

        has $.text;

        method name {
            'ConditionDeclTail::BracedInit'
        }

        method gist(:$treemark=False) {
            $.braced-init-list.gist(:$treemark)
        }
    }
}

package ConditionGrammar is export {

    our role Actions {

        # rule condition:sym<expr> { <expression> } 
        method condition:sym<expr>($/) {
            make $<expression>.made
        }

        # rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
        method condition-decl-tail:sym<assign-init>($/) {
            make ConditionDeclTail::AssignInit.new(
                initializer-clause => $<initializer-clause>.made,
                text               => ~$/,
            )
        }

        # rule condition-decl-tail:sym<braced-init> { <braced-init-list> } 
        method condition-decl-tail:sym<braced-init>($/) {
            make $<braced-init-list>.made
        }

        # rule condition:sym<decl> { 
        #   <attribute-specifier-seq>? 
        #   <decl-specifier-seq> 
        #   <declarator> 
        #   <condition-decl-tail> 
        # }
        method condition:sym<decl>($/) {
            make Condition::Decl.new(
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                decl-specifier-seq      => $<decl-specifier-seq>.made,
                declarator              => $<declarator>.made,
                condition-decl-tail     => $<condition-decl-tail>.made,
                text                    => ~$/,
            )
        }
    }

    our role Rules {

        proto rule condition { * }

        rule condition:sym<expr> {
            <expression>
        }

        #-----------------------------
        proto rule condition-decl-tail { * }
        rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
        rule condition-decl-tail:sym<braced-init> { <braced-init-list> }

        #-----------------------------
        rule condition:sym<decl> {
            <attribute-specifier-seq>?
            <decl-specifier-seq> 
            <declarator>
            <condition-decl-tail>
        }
    }
}
