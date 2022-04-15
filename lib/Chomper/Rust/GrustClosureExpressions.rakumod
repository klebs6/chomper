unit module Chomper::Rust::GrustClosureExpressions;

use Data::Dump::Tree;

class ClosureExpression is export {
    has Bool $.move;
    has $.maybe-parameters;
    has $.body;

    has $.text;

    method gist {

        my $builder = "";

        if $.move {
            $builder ~= "move ";
        }

        if $.maybe-parameters {

            my $params = $.maybe-parameters.List>>.gist.join(", ");

            $builder ~= "|" ~ $params ~ "| ";

        } else {

            $builder ~= "|| ";
        }

        $builder ~= $.body.gist;

        $builder
    }
}

class ClosureBodyWithReturnTypeAndBlock is export {
    has $.return-type;
    has $.block-expression;

    has $.text;

    method gist {
        "-> " 
        ~ $.return-type.gist 
        ~ " " 
        ~ $.block-expression.gist
    }
}

class ClosureParam is export {
    has @.outer-attributes;
    has $.pattern;
    has $.maybe-type;

    has $.text;

    method gist {

        my $builder = qq:to/END/.chomp.trim;
        {@.outer-attributes>>.gist.join("\n")}
        {$.pattern.gist}
        END

        if $.maybe-type {
            $builder ~= ": " ~ $.maybe-type.gist;
        }

        $builder
    }
}

package ClosureExpressionGrammar is export {

    our role Rules {

        rule closure-expression {
            <kw-move>?
            <closure-expression-opener>
            <closure-body>
        }

        proto rule closure-expression-opener { * }

        rule closure-expression-opener:sym<a> {
            <tok-oror>
        }

        rule closure-expression-opener:sym<b> {
            <tok-or>
            <closure-parameters>
            <tok-or>
        }

        proto rule closure-body { * }

        rule closure-body:sym<expr> {
            <expression>
        }

        rule closure-body:sym<with-return-type-and-block> {
            <tok-rarrow>
            <type-no-bounds>
            <block-expression>
        }

        #---------------

        rule closure-parameters {
            <closure-param>+ %% <tok-comma>
        }

        rule closure-param {
            <outer-attribute>*
            <pattern-no-top-alt>
            [
                <tok-colon>
                <type>
            ]?
        }
    }

    our role Actions {

        method closure-expression($/) {
            make ClosureExpression.new(
                move             => so $/<kw-move>:exists,
                maybe-parameters => $<closure-expression-opener>.made,
                body             => $<closure-body>.made,
                text             => $/.Str,
            )
        }

        method closure-expression-opener:sym<b>($/) {
            make $<closure-parameters>.made
        }

        method closure-body:sym<expr>($/) {
            make $<expression>.made
        }

        method closure-body:sym<with-return-type-and-block>($/) {
            make ClosureBodyWithReturnTypeAndBlock.new(
                return-type      => $<type-no-bounds>.made,
                block-expression => $<block-expression>.made,
                text             => $/.Str,
            )
        }

        #---------------

        method closure-parameters($/) {
            make $<closure-param>>>.made
        }

        method closure-param($/) {
            make ClosureParam.new(
                outer-attributes => $<outer-attribute>>>.made,
                pattern          => $<pattern-no-top-alt>.made,
                maybe-type       => $<type>.made,
                text             => $/.Str,
            )
        }
    }
}
