unit module Chomper::Cpp::GcppLambda;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppStatement;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppParam;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppFunction;

our class LambdaDeclarator { ... }
our class CaptureList { ... }
our class InitCapture { ... }

# rule lambda-introducer { 
#   <.left-bracket> 
#   <lambda-capture>? 
#   <.right-bracket> 
# }
class LambdaIntroducer is export { 
    has ILambdaCapture $.lambda-capture;

    has $.text;

    method name {
        'LambdaIntroducer'
    }

    method gist(:$treemark=False) {

        my $builder = "[";

        if $.lambda-capture {
            $builder ~= $.lambda-capture.gist(:$treemark);
        }

        $builder ~ "]"
    }
}

# rule lambda-expression { 
#   <lambda-introducer> 
#   <lambda-declarator>? 
#   <compound-statement> 
# }
class LambdaExpression is export { 
    has LambdaIntroducer  $.lambda-introducer is required;
    has LambdaDeclarator  $.lambda-declarator;
    has CompoundStatement $.compound-statement is required;

    has $.text;

    method name {
        'LambdaExpression'
    }

    method gist(:$treemark=False) {
        my $builder = $.lambda-introducer.gist(:$treemark);

        if $.lambda-declarator {
            $builder ~= " " ~ $.lambda-declarator.gist(:$treemark);
        }

        $builder ~ " " ~ $.compound-statement.gist(:$treemark)
    }
}

package LambdaCapture is export {

    # rule lambda-capture:sym<list> { <capture-list> }
    our class List does ILambdaCapture {
        has ICaptureList $.capture-list is required;

        has $.text;

        method name {
            'LambdaCapture::List'
        }

        method gist(:$treemark=False) {
            $.capture-list.gist(:$treemark)
        }
    }

    # rule lambda-capture:sym<def> { 
    #   <capture-default> 
    #   [ <comma> <capture-list> ]? 
    # }
    our class Def does ILambdaCapture {
        has ICaptureDefault $.capture-default is required;
        has ICaptureList    $.capture-list;

        has $.text;

        method name {
            'LambdaCapture::Def'
        }

        method gist(:$treemark=False) {

            my $builder = $.capture-default.gist(:$treemark);

            my $l = $.capture-list;

            if $l {
                $builder ~= ", " ~ $l;
            }

            $builder
        }
    }
}

package CaptureDefault is export {

    # rule capture-default:sym<and> { <and_> }
    our class And 
    does ILambdaCapture
    does ICaptureDefault { 

        has $.text;

        method name {
            'CaptureDefault::And'
        }

        method gist(:$treemark=False) {
            "&"
        }
    }

    # rule capture-default:sym<assign> { <assign> }
    our class Assign 
    does ILambdaCapture
    does ICaptureDefault { 

        has $.text;

        method name {
            'CaptureDefault::Assign'
        }

        method gist(:$treemark=False) {
            "="
        }
    }
}

# rule capture-list { <capture> [ <comma> <capture> ]* <ellipsis>? } 
class CaptureList does ICaptureList is export {
    has ICapture @.captures is required;
    has Bool     $.trailing-ellipsis is required;

    has $.text;

    method name {
        'CaptureList'
    }

    method gist(:$treemark=False) {
        my $builder = @.captures>>.gist(:$treemark).join(", ");

        if $.trailing-ellipsis {
            $builder ~ "..."
        } else {
            $builder
        }
    }
}

package Capture is export {

    # rule capture:sym<init> { <initcapture> } 
    our class Init does ICapture {
        has InitCapture $.init-capture is required;

        has $.text;

        method name {
            'Capture::Init'
        }

        method gist(:$treemark=False) {
            $.init-capture.gist(:$treemark)
        }
    }

    # rule capture:sym<simple> { <simple-capture> }
    our class Simple does ICapture {
        has ISimpleCapture $.simple-capture is required;

        has $.text;

        method name {
            'Capture::Simple'
        }

        method gist(:$treemark=False) {
            $.simple-capture.gist(:$treemark)
        }
    }

    # rule simple-capture:sym<id> { <and_>? <identifier> }
    our class Id does ISimpleCapture {
        has Bool       $.has-and;
        has Identifier $.identifier is required;

        has $.text;

        method name {
            'Capture::Id'
        }

        method gist(:$treemark=False) {
            if $.has-and {
                "&" ~ $.identifier.gist(:$treemark)
            } else {
                $.identifier.gist(:$treemark)
            }
        }
    }

    # rule simple-capture:sym<this> { <this> }
    our class This does ISimpleCapture { 

        has $.text;

        method name {
            'Capture::This'
        }

        method gist(:$treemark=False) {
            "this"
        }
    }
}

# rule initcapture { 
#   <and_>? 
#   <identifier> 
#   <initializer> 
# }
class InitCapture is export { 

    has Bool         $.has-and;
    has Identifier   $.identifier  is required;
    has IInitializer $.initializer is required;

    has $.text;

    method name {
        'InitCapture'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        if $.has-and {
            $builder ~= "&";
        }

        $builder ~= $.identifier.gist(:$treemark);

        $builder ~ " " ~ $.initializer.gist(:$treemark)
    }
}

# rule lambda-declarator { 
#   <.left-paren> 
#   <parameter-declaration-clause>? 
#   <.right-paren> 
#   <mutable>? 
#   <exception-specification>? 
#   <attribute-specifier-seq>? 
#   <trailing-return-type>? 
# }
class LambdaDeclarator is export { 
    has ParameterDeclarationClause $.parameter-declaration-clause is required;
    has Bool                       $.mutable                      is required;
    has IExceptionSpecification    $.exception-specification;
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has TrailingReturnType         $.trailing-return-type;

    has $.text;

    method name {
        'LambdaDeclarator'
    }

    method gist(:$treemark=False) {
        my $builder = "";

        $builder ~= "(";

        my $d = $.parameter-declaration-clause;

        if $d {
            $builder ~= $d.gist(:$treemark);
        }

        $builder ~= ")";

        if $.mutable {
            $builder ~= " mutable";
        }

        my $x = $.exception-specification;
        my $y = $.attribute-specifier-seq;
        my $z = $.trailing-return-type;

        if $x {
            $builder ~= " " ~ $x.gist(:$treemark);
        }

        if $y {
            $builder ~= " " ~ $y.gist(:$treemark);
        }

        if $z {
            $builder ~= " " ~ $z.gist(:$treemark);
        }

        $builder
    }
}

package LambdaExpressionGrammar is export {

    our role Actions {

        # rule lambda-expression { 
        #   <lambda-introducer> 
        #   <lambda-declarator>? 
        #   <compound-statement> 
        # }
        method lambda-expression($/) {
            make LambdaExpression.new(
                lambda-introducer  => $<lambda-introducer>.made,
                lambda-declarator  => $<lambda-declarator>.made,
                compound-statement => $<compound-statement>.made,
                text               => ~$/,
            )
        }

        # rule lambda-introducer { <.left-bracket> <lambda-capture>? <.right-bracket> } 
        method lambda-introducer($/) {
            make LambdaIntroducer.new(
                lambda-capture => $<lambda-capture>.made,
                text           => ~$/,
            )
        }

        # rule lambda-capture:sym<list> { <capture-list> }
        method lambda-capture:sym<list>($/) {
            make LambdaCapture::List.new(
                capture-list => $<capture-list>.made,
                text         => ~$/,
            )
        }

        # rule lambda-capture:sym<def> { <capture-default> [ <.comma> <capture-list> ]? } 
        method lambda-capture:sym<def>($/) {

            my $body = $<capture-default>.made;
            my $tail = $<capture-list>.made;

            if $tail {
                make LambdaCapture::Def.new(
                    capture-default => $body,
                    capture-list    => $tail,
                    text            => ~$/,
                )

            } else {
                make $body
            }
        }

        # rule capture-default:sym<and> { <and_> }
        method capture-default:sym<and>($/) {
            make CaptureDefault::And.new
        }

        # rule capture-default:sym<assign> { <assign> } 
        method capture-default:sym<assign>($/) {
            make CaptureDefault::Assign.new
        }

        # rule capture-list { <capture> [ <.comma> <capture> ]* <ellipsis>? } 
        method capture-list($/) {

            my @captures     = $<capture>>>.made;
            my $has-ellipsis = so $/<ellipsis>:exists;

            if @captures.elems gt 1 or $has-ellipsis {
                make CaptureList.new(
                    captures          => @captures,
                    trailing-ellipsis => $has-ellipsis,
                    text              => ~$/,
                )
            } else {
                make @captures[0]
            }
        }

        # rule capture:sym<simple> { <simple-capture> }
        method capture:sym<simple>($/) {
            make Capture::Simple.new(
                simple-capture => $<simple-capture>.made,
                text           => ~$/,
            )
        }

        # rule capture:sym<init> { <initcapture> } 
        method capture:sym<init>($/) {
            make Capture::Init.new(
                init-capture => $<init-capture>.made,
                text         => ~$/,
            )
        }

        # rule simple-capture:sym<id> { <and_>? <identifier> }
        method simple-capture:sym<id>($/) {

            my $id      = $<identifier>.made;
            my $has-and = so $/<and_>:exists;

            if $has-and {
                make SimpleCapture::Id.new(
                    has-and_   => True,
                    identifier => $id,
                    text       => ~$/,
                )
            } else {
                make SimpleCapture::Id.new(
                    has-and_   => False,
                    identifier => $id,
                    text       => ~$/,
                )
            }
        }

        # rule simple-capture:sym<this> { <this> } 
        method simple-capture:sym<this>($/) {
            make SimpleCapture::This.new
        }

        # rule initcapture { <and_>? <identifier> <initializer> } 
        method initcapture($/) {
            make InitCapture.new(
                has-and     => $<has-and>.made,
                identifier  => $<identifier>.made,
                initializer => $<initializer>.made,
                text        => ~$/,
            )
        }

        # rule lambda-declarator { 
        #   <.left-paren> 
        #   <parameter-declaration-clause>? 
        #   <.right-paren> 
        #   <mutable>? 
        #   <exception-specification>? 
        #   <attribute-specifier-seq>? 
        #   <trailing-return-type>? 
        # } 
        method lambda-declarator($/) {
            make LambdaDeclarator.new(
                parameter-declaration-clause => $<parameter-declaration-clause>.made,
                mutable                      => $<mutable>.made,
                exception-specification      => $<exception-specification>.made,
                attribute-specifier-seq      => $<attribute-specifier-seq>.made,
                trailing-return-type         => $<trailing-return-type>.made,
                text                         => ~$/,
            )
        }
    }

    our role Rules {

        rule lambda-expression {
            <lambda-introducer> <lambda-declarator>?  <compound-statement>
        }

        rule lambda-introducer {
            <left-bracket> <lambda-capture>?  <right-bracket>
        }

        #-------------------------------
        proto rule lambda-capture { * }
        rule lambda-capture:sym<list> { <capture-list> }
        rule lambda-capture:sym<def>  { <capture-default> [ <comma> <capture-list> ]? }

        #-------------------------------
        proto rule capture-default { * }
        rule capture-default:sym<and>    { <and_> }
        rule capture-default:sym<assign> { <assign> }

        #-------------------------------
        rule capture-list {
            <capture> [ <comma> <capture> ]* <ellipsis>?
        }

        #-------------------------------
        proto rule capture { * }
        rule capture:sym<simple> { <simple-capture> }
        rule capture:sym<init>   { <initcapture> }

        #-------------------------------
        proto rule simple-capture { * }
        rule simple-capture:sym<id>   { <and_>? <identifier> }
        rule simple-capture:sym<this> { <this> }

        #-------------------------------
        rule initcapture {
            <and_>?  <identifier> <initializer>
        }

        #-------------------------------
        rule lambda-declarator {
            <left-paren>
            <parameter-declaration-clause>?
            <right-paren>
            <mutable>?
            <exception-specification>?
            <attribute-specifier-seq>?
            <trailing-return-type>?
        }
    }
}
