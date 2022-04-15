unit module Chomper::Rust::GrustIfExpressions;

use Data::Dump::Tree;

class IfExpression is export {
    has $.expression-nostruct;
    has $.block-expression;
    has $.maybe-else-clause;

    has $.text;

    method gist {

        my $builder = 
        "if " 
        ~ $.expression-nostruct.gist
        ~ " "
        ~ $.block-expression.gist;

        if $.maybe-else-clause {
            $builder ~= $.maybe-else-clause.gist;
        }

        $builder
    }
}

class IfLetExpression is export {
    has $.pattern;
    has $.scrutinee;
    has $.block-expression;
    has $.maybe-else-clause;

    has $.text;

    method gist {

        my $builder = "if let " ~ $.pattern.gist;

        $builder ~= " = " ~ $.scrutinee.gist;
        $builder ~= $.block-expression.gist;

        if $.maybe-else-clause {
            $builder ~= $.maybe-else-clause.gist;
        }

        $builder
    }
}

class ElseClause is export {
    has $.else-clause-variant;

    has $.text;

    method gist {
        "else " ~ $.else-clause-variant.gist
    }
}

package IfExpressionsGrammar is export {

    our role Rules {

        rule if-expression {
            <kw-if>
            <expression-nostruct>
            <block-expression>
            <else-clause>?
        }

        rule if-let-expression {
            <kw-if>
            <kw-let>
            <pattern>
            <tok-eq>
            <scrutinee-except-lazy-boolean-operator-expression>
            <block-expression>
            <else-clause>?
        }

        rule else-clause {
            <kw-else>
            <else-clause-variant>
        }

        proto rule else-clause-variant { * }

        rule else-clause-variant:sym<block> {  
            <block-expression>
        }

        rule else-clause-variant:sym<if> {  
            <if-expression>
        }

        rule else-clause-variant:sym<if-let> {  
            <if-let-expression>
        }
    }

    our role Actions {

        method if-expression($/) {
            make IfExpression.new(
                expression-nostruct => $<expression-nostruct>.made,
                block-expression    => $<block-expression>.made,
                maybe-else-clause   => $<else-clause>.made,
                text                => $/.Str,
            )
        }

        method if-let-expression($/) {
            make IfLetExpression.new(
                pattern           => $<pattern>.made,
                scrutinee         => $<scrutinee-except-lazy-boolean-operator-expression>.made,
                block-expression  => $<block-expression>.made,
                maybe-else-clause => $<else-clause>.made,
                text              => $/.Str,
            )
        }

        method else-clause($/) {
            make ElseClause.new(
                else-clause-variant => $<else-clause-variant>.made,
                text                => $/.Str,
            )
        }

        method else-clause-variant:sym<block>($/) {  
            make $<block-expression>.made
        }

        method else-clause-variant:sym<if>($/) {  
            make $<if-expression>.made
        }

        method else-clause-variant:sym<if-let>($/) {  
            make $<if-let-expression>.made
        }
    }
}
