unit module Chomper::Cpp::GcppStructuredBinding;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;

# this needs to be its own class because it is
# also used in ForRangeDeclaration
#
our class StructuredBindingBody 
does IForRangeDeclaration
is export
{
    has $.cv-auto;
    has $.refqualifier;
    has $.identifier-list;

    method name {
        'StructuredBindingBody'
    }

    method is-mutable {
        if $.cv-auto {
            $.cv-auto.is-mutable()
        } else {
            True
        }
    }

    method gist(:$treemark=False)  {

        my $builder;

        $builder ~= $.cv-auto.gist(:$treemark);

        my @list = $.identifier-list.List;

        if $.refqualifier {
            $builder ~= $.refqualifier.gist(:$treemark);
        }

        $builder ~= " [" ~ @list>>.gist(:$treemark).join(", ") ~ "]";

        $builder
    }
}

package StructuredBinding is export {

    our class Eq does IStructuredBinding {
        has $.attribute-specifier-seq;
        has $.structured-binding-body;
        has $.expression;

        has Str $.text;

        method name {
            'StructuredBinding::Eq'
        }

        method gist(:$treemark=False)  {
            my $builder;

            my $ass = $.attribute-specifier-seq;

            if $ass {
                $builder ~= $ass ~ " ";
            }

            $builder ~= $.structured-binding-body.gist(:$treemark);

            $builder ~= " = " ~ $.expression.gist(:$treemark);

            $builder ~ ";"
        }
    }

    our class Braces does IStructuredBinding {
        has $.attribute-specifier-seq;
        has $.structured-binding-body;
        has $.expression;

        has Str $.text;

        method name {
            'StructuredBinding::Braces'
        }

        method gist(:$treemark=False)  {
            my $builder;

            my $ass = $.attribute-specifier-seq;

            if $ass {
                $builder ~= $ass ~ " ";
            }

            $builder ~= $.structured-binding-body.gist(:$treemark);

            $builder ~= " \{" ~ $.expression.gist(:$treemark) ~ "}";

            $builder ~ ";"
        }
    }

    our class Parens does IStructuredBinding {
        has $.attribute-specifier-seq;
        has $.structured-binding-body;
        has $.expression;

        has Str $.text;

        method name {
            'StructuredBinding::Parens'
        }

        method gist(:$treemark=False)  {
            my $builder;

            my $ass = $.attribute-specifier-seq;

            if $ass {
                $builder ~= $ass ~ " ";
            }

            $builder ~= $.structured-binding-body.gist(:$treemark);

            $builder ~= " \(" ~ $.expression.gist(:$treemark) ~ ")";

            $builder ~ ";"
        }
    }
}

package StructuredBindingGrammar is export {

    our role Actions {

        #rule structured-binding:sym<eq> { 
        #    <attribute-specifier-seq> 
        #    <cv-auto>
        #    <refqualifier>?
        #    <left-bracket>
        #    <identifier-list>
        #    <right-bracket>
        #    <assign>
        #    <expression>
        #    <semi> 
        #}
        method structured-binding:sym<eq>($/) {
            my $seq = $<attribute-specifier-seq>.made;

            make StructuredBinding::Eq.new(
                attribute-specifier-seq => $seq // Nil,
                structured-binding-body => $<structured-binding-body>.made,
                expression              => $<expression>.made,
                text                    => $/.Str,
            )
        }

        #rule structured-binding:sym<braces> { 
        #    <attribute-specifier-seq> 
        #    <cv-auto>
        #    <refqualifier>?
        #    <left-bracket>
        #    <identifier-list>
        #    <right-bracket>
        #    <left-brace>
        #    <expression>
        #    <right-brace>
        #    <semi> 
        #}
        method structured-binding:sym<braces>($/) {

            my $seq = $<attribute-specifier-seq>.made;

            make StructuredBinding::Braces.new(
                attribute-specifier-seq => $seq // Nil,
                structured-binding-body => $<structured-binding-body>.made,
                expression              => $<expression>.made,
                text                    => $/.Str,
            )
        }

        #rule structured-binding:sym<parens> { 
        #    <attribute-specifier-seq> 
        #    <cv-auto>
        #    <refqualifier>?
        #    <left-bracket>
        #    <identifier-list>
        #    <right-bracket>
        #    <left-paren>
        #    <expression>
        #    <right-paren>
        #    <semi> 
        #}
        method structured-binding:sym<parens>($/) {
            my $seq        = $<attribute-specifier-seq>.made;

            make StructuredBinding::Parens.new(
                attribute-specifier-seq => $seq // Nil,
                structured-binding-body => $<structured-binding-body>.made,
                expression              => $<expression>.made,
                text                    => $/.Str,
            )
        }

        method structured-binding-body($/) {
            make StructuredBindingBody.new(
                cv-auto                 => $<cv-auto>.made,
                refqualifier            => $<refqualifier>.made,
                identifier-list         => $<identifier-list>.made,
            )
        }
    }

    our role Rules {

        rule structured-binding-body {
            <cv-auto>
            <refqualifier>?
            <left-bracket>
            <identifier-list>
            <right-bracket>
        }

        proto rule structured-binding { * }

        rule structured-binding:sym<eq> { 
            <attribute-specifier-seq>?
            <structured-binding-body>
            <assign>
            <expression>
            <semi> 
        }

        rule structured-binding:sym<braces> { 
            <attribute-specifier-seq>?
            <left-brace>
            <expression>
            <right-brace>
            <semi> 
        }

        rule structured-binding:sym<parens> { 
            <attribute-specifier-seq>?
            <left-paren>
            <expression>
            <right-paren>
            <semi> 
        }
    }
}
