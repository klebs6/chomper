use Data::Dump::Tree;

use gcpp-roles;
use gcpp-template;
use gcpp-type-id;
use gcpp-enum;
use gcpp-typedef;

use tree-mark;

# rule the-type-name:sym<simple-template-id> { <simple-template-id> }
our class TheTypeName::SimpleTemplateId does ITheTypeName {
    has SimpleTemplateId $.simple-template-id is required;
    has $.text;

    method gist(:$treemark=False) {
        $.simple-template-id.gist(:$treemark)
    }
}

# rule the-type-name:sym<class> { <class-name> }
our class TheTypeName::Class does ITheTypeName {
    has IClassName $.class-name is required;

    has $.text;

    method gist(:$treemark=False) {
        $.class-name.gist(:$treemark)
    }
}

# rule the-type-name:sym<enum> { <enum-name> }
our class TheTypeName::Enum does ITheTypeName {
    has EnumName $.enum-name is required;

    has $.text;

    method gist(:$treemark=False) {
        $.enum-name.gist(:$treemark)
    }
}

# rule the-type-name:sym<typedef> { 
#   <typedef-name> 
# }
our class TheTypeName::Typedef does ITheTypeName {
    has TypedefName $.typedef-name is required;

    has $.text;

    method gist(:$treemark=False) {
        $.typedef-name.gist(:$treemark)
    }
}

# rule full-type-name { 
#   <nested-name-specifier>? 
#   <the-type-name> 
# }
our class FullTypeName 
does IPostListHead 
does IDeclSpecifier 
does ISimpleTypeSpecifier
{
    has INestedNameSpecifier $.nested-name-specifier;
    has ITheTypeName         $.the-type-name is required;

    has $.text;

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_Type>);
        }

        my $builder = "";

        $builder = $builder.&maybe-extend($.nested-name-specifier);

        $builder ~ $.the-type-name.gist(:$treemark)
    }
}

our role TypeName::Actions {

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

our role TypeName::Rules {

    proto rule type-name-specifier { * }

    rule type-name-specifier:sym<ident> {
        <typename_>
        <nested-name-specifier>
        <identifier>
    }

    rule type-name-specifier:sym<template> {
        <typename_>
        <nested-name-specifier>
        <template>?  
        <simple-template-id>
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
