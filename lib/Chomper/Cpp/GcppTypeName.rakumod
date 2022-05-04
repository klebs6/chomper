unit module Chomper::Cpp::GcppTypeName;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppTemplate;
use Chomper::Cpp::GcppTypeId;
use Chomper::Cpp::GcppEnum;
use Chomper::Cpp::GcppTypedef;

use Chomper::TreeMark;

package TheTypeName is export {

    # rule the-type-name:sym<simple-template-id> { <simple-template-id> }
    our class SimpleTemplateId does ITheTypeName does IUnqualifiedId {
        has SimpleTemplateId $.simple-template-id is required;
        has $.text;

        method name {
            'TheTypeName::SimpleTemplateId'
        }

        method gist(:$treemark=False) {
            $.simple-template-id.gist(:$treemark)
        }
    }

    # rule the-type-name:sym<class> { <class-name> }
    our class Class does ITheTypeName {
        has IClassName $.class-name is required;

        has $.text;

        method name {
            'TheTypeName::Class'
        }

        method gist(:$treemark=False) {
            $.class-name.gist(:$treemark)
        }
    }

    # rule the-type-name:sym<enum> { <enum-name> }
    our class Enum does ITheTypeName {
        has EnumName $.enum-name is required;

        has $.text;

        method name {
            'TheTypeName::Enum'
        }

        method gist(:$treemark=False) {
            $.enum-name.gist(:$treemark)
        }
    }

    # rule the-type-name:sym<typedef> { 
    #   <typedef-name> 
    # }
    our class Typedef does ITheTypeName {
        has TypedefName $.typedef-name is required;

        has $.text;

        method name {
            'TheTypeName::Typedef'
        }

        method gist(:$treemark=False) {
            $.typedef-name.gist(:$treemark)
        }
    }
}

# rule full-type-name { 
#   <nested-name-specifier>? 
#   <the-type-name> 
# }
class FullTypeName 
does IPostListHead 
does IDeclSpecifier 
does ISimpleTypeSpecifier
is export {
    has INestedNameSpecifier $.nested-name-specifier;
    has ITheTypeName         $.the-type-name is required;

    has $.text;

    method name {
        'FullTypeName'
    }

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_Type>);
        }

        my $builder = "";

        $builder = $builder.&maybe-extend(:$treemark,$.nested-name-specifier);

        $builder ~ $.the-type-name.gist(:$treemark)
    }
}

package TypeNameGrammar is export {

    our role Actions {

        # rule full-type-name { <nested-name-specifier>? <the-type-name> }
        method full-type-name($/) {

            my $prefix = $<nested-name-specifier>.made;
            my $body   = $<the-type-name>.made;

            if $prefix {

                make FullTypeName.new(
                    nested-name-specifier => $prefix,
                    the-type-name         => $body,
                    text                  => ~$/,
                )

            } else {

                make $body
            }
        }

        # rule the-type-name:sym<simple-template-id> { <simple-template-id> }
        method the-type-name:sym<simple-template-id>($/) {
            make $<simple-template-id>.made
        }

        # rule the-type-name:sym<class> { <class-name> }
        method the-type-name:sym<class>($/) {
            make $<class-name>.made
        }

        # rule the-type-name:sym<enum> { <enum-name> }
        method the-type-name:sym<enum>($/) {
            make $<enum-name>.made
        }

        # rule the-type-name:sym<typedef> { <typedef-name> } 
        method the-type-name:sym<typedef>($/) {
            make $<typedef-name>.made
        }

        # rule type-name-specifier:sym<ident> { <typename_> <nested-name-specifier> <identifier> }
        method type-name-specifier:sym<ident>($/) {
            make TypeNameSpecifier::Ident.new(
                nested-name-specifier => $<nested-name-specifier>.made,
                identifier            => $<identifier>.made,
                text                  => ~$/,
            )
        }

        # rule type-name-specifier:sym<template> { <typename_> <nested-name-specifier> <template>? <simple-template-id> } 
        method type-name-specifier:sym<template>($/) {
            make TypeNameSpecifier::Template.new(
                nested-name-specifier => $<nested-name-specifier>.made,
                has-template          => $<has-template>.made,
                simple-template-id    => $<simple-template-id>.made,
                text                  => ~$/,
            )
        }
    }

    our role Rules {

        proto rule type-name-specifier { * }

        #TODO: should this be first or second?
        rule type-name-specifier:sym<template> {
            <typename_>
            <nested-name-specifier>
            <template>?  
            <simple-template-id>
        }

        rule type-name-specifier:sym<ident> {
            <typename_>
            <nested-name-specifier>
            <identifier>
        }

        proto rule the-type-name                   { * }
        rule the-type-name:sym<simple-template-id> { <simple-template-id> }
        rule the-type-name:sym<class>              { <class-name> }
        rule the-type-name:sym<enum>               { <enum-name> }
        rule the-type-name:sym<typedef>            { <typedef-name> }

        rule full-type-name {
            <nested-name-specifier>? 
            <the-type-name>
        }
    }
}
