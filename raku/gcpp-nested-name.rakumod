use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-template;
use gcpp-decltype;

# regex nested-name-specifier-prefix:sym<null> { 
#   <doublecolon> 
# }
our class NestedNameSpecifierPrefix::Null does INestedNameSpecifierPrefix { 

    has $.text;

    method gist{
        "::"
    }
}

# regex nested-name-specifier-prefix:sym<type> { 
#   <the-type-name> 
#   <doublecolon> 
# }
our class NestedNameSpecifierPrefix::Type does INestedNameSpecifierPrefix {
    has ITheTypeName $.the-type-name is required;

    has $.text;

    method gist{
        $.the-type-name.gist ~ "::"
    }
}

# regex nested-name-specifier-prefix:sym<ns> { 
#   <namespace-name> 
#   <doublecolon> 
# }
our class NestedNameSpecifierPrefix::Ns does INestedNameSpecifierPrefix {
    has INamespaceName $.namespace-name is required;

    has $.text;

    method gist{
        $.namespace-name.gist ~ "::"
    }
}

# regex nested-name-specifier-prefix:sym<decl> { 
#   <decltype-specifier> 
#   <doublecolon> 
# }
our class NestedNameSpecifierPrefix::Decl does INestedNameSpecifierPrefix {
    has DecltypeSpecifier $.decltype-specifier is required;

    has $.text;

    method gist{
        $.decltype-specifier.gist ~ "::"
    }
}

# regex nested-name-specifier-suffix:sym<id> { 
#   <identifier> 
#   <doublecolon> 
# }
our class NestedNameSpecifierSuffix::Id does INestedNameSpecifierSuffix {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist ~ "::"
    }
}

# regex nested-name-specifier-suffix:sym<template> { 
#   <template>? 
#   <simple-template-id> 
#   <doublecolon> 
# }
our class NestedNameSpecifierSuffix::Template does INestedNameSpecifierSuffix {
    has Bool             $.template is required;
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist{

        my $builder = "";

        if $.template {
            $builder ~= "template ";
        }

        $builder ~= $.simple-template-id.gist;

        $builder ~ "::"
    }
}

# regex nested-name-specifier { 
#   <nested-name-specifier-prefix> 
#   <nested-name-specifier-suffix>* 
# }
our class NestedNameSpecifier does INestedNameSpecifier { 
    has INestedNameSpecifierPrefix $.nested-name-specifier-prefix   is required;
    has INestedNameSpecifierSuffix @.nested-name-specifier-suffixes;

    has $.text;

    method gist{

        my $builder = $.nested-name-specifier-prefix.gist;

        for @.nested-nme-specifier-suffixes {
            $builder ~= $_.gist;
        }

        $builder
    }
}

our role NestedNameSpecifier::Actions {

    # regex nested-name-specifier-prefix:sym<null> { <doublecolon> }
    method nested-name-specifier-prefix:sym<null>($/) {
        make NestedNameSpecifierPrefix::Null.new
    }

    # regex nested-name-specifier-prefix:sym<type> { <the-type-name> <doublecolon> }
    method nested-name-specifier-prefix:sym<type>($/) {
        make NestedNameSpecifierPrefix::Type.new(
            the-type-name => $<the-type-name>.made,
            text          => ~$/,
        )
    }

    # regex nested-name-specifier-prefix:sym<ns> { <namespace-name> <doublecolon> }
    method nested-name-specifier-prefix:sym<ns>($/) {
        make NestedNameSpecifierPrefix::Ns.new(
            namespace-name => $<namespace-name>.made,
            text           => ~$/,
        )
    }

    # regex nested-name-specifier-prefix:sym<decl> { <decltype-specifier> <doublecolon> } 
    method nested-name-specifier-prefix:sym<decl>($/) {
        make NestedNameSpecifierPrefix::Decl.new(
            decltype-specifier => $<decltype-specifier>.made,
            text               => ~$/,
        )
    }

    # regex nested-name-specifier-suffix:sym<id> { <identifier> <doublecolon> }
    method nested-name-specifier-suffix:sym<id>($/) {
        make NestedNameSpecifierSuffix::Id.new(
            identifier => $<identifier>.made,
            text       => ~$/,
        )
    }

    # regex nested-name-specifier-suffix:sym<template> { 
    #   <template>? 
    #   <simple-template-id> 
    #   <doublecolon> 
    # } 
    method nested-name-specifier-suffix:sym<template>($/) {
        make NestedNameSpecifierSuffix::Template.new(
            template           => $<template>.made,
            simple-template-id => $<simple-template-id>.made,
            text               => ~$/,
        )
    }

    # regex nested-name-specifier { 
    #   <nested-name-specifier-prefix> 
    #   <nested-name-specifier-suffix>* 
    # }
    method nested-name-specifier($/) {

        my $base     = $<nested-name-specifier-prefix>.made;
        my @suffixes = $<nested-name-specifier-suffix>>>.made;

        if @suffixes.elems gt 0 {
            make NestedNameSpecifier.new(
                nested-name-specifier-prefix   => $base,
                nested-name-specifier-suffixes => @suffixes,
                text                           => ~$/,
            )
        } else {
            make $base
        }
    }
}

our role NestedNameSpecifier::Rules {

    proto regex nested-name-specifier-prefix { * }

    regex nested-name-specifier-prefix:sym<null> {
        <doublecolon>
    }

    regex nested-name-specifier-prefix:sym<type> {
        <the-type-name>
        <doublecolon>
    }

    regex nested-name-specifier-prefix:sym<ns> {
        <namespace-name>
        <doublecolon>
    }

    regex nested-name-specifier-prefix:sym<decl> {
        <decltype-specifier>
        <doublecolon>
    }

    proto regex nested-name-specifier-suffix { * }

    regex nested-name-specifier-suffix:sym<id> {
        <identifier>
        <doublecolon>
    }

    regex nested-name-specifier-suffix:sym<template> {
        <template>? 
        <simple-template-id>
        <doublecolon>
    }

    #-------------------------------
    regex nested-name-specifier {
        <nested-name-specifier-prefix> 
        <nested-name-specifier-suffix>*
    }
}
