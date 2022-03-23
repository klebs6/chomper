use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-template;

# rule the-type-id { 
#   <type-specifier-seq> 
#   <abstract-declarator>? 
# }
our class TheTypeId 
does ITheTypeId 
does ITemplateArgument { 

    has $.type-specifier-seq is required;
    has IAbstractDeclarator $.abstract-declarator;
    
    has $.text;

    method gist {

        my $builder = $.type-specifier-seq.gist;

        if $.abstract-declarator {
            $builder ~= " " ~ $.abstract-declarator.gist;
        }

        $builder
    }
}

# rule type-id-list { 
#   <the-type-id> 
#   <ellipsis>? 
#   [ <.comma> <the-type-id> <ellipsis>? ]* 
# }
our class TypeIdList { 
    has ITheTypeId @.the-type-ids is required;

    has $.text;

    method gist{
        @.the-type-ids>>.gist.join(", ")
    }
}

# rule type-name-specifier:sym<ident> { 
#   <typename_> 
#   <nested-name-specifier> 
#   <identifier> 
# }
our class TypeNameSpecifier::Ident does ITypeNameSpecifier {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Identifier $.identifier is required;
    has $.text;

    method gist{
        "typename " 
        ~ $.nested-name-specifier.gist 
        ~ " " 
        ~ $.identifier.gist
    }
}

# rule type-name-specifier:sym<template> { 
#   <typename_> 
#   <nested-name-specifier> 
#   <template>? 
#   <simple-template-id> 
# }
our class TypeNameSpecifier::Template does ITypeNameSpecifier {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.has-template          is required;
    has SimpleTemplateId    $.simple-template-id    is required;

    has $.text;

    method gist{

        my $builder = "typename "
        ~ $.nested-name-specifier.gist
        ~ " ";

        if $.has-template {
            $builder ~= "template ";
        }

        $builder ~ $.simple-template-id.gist
    }
}

# rule type-id-of-the-type-id { <typeid_> }
our class TypeIdOfTheTypeId {
    has $.typeid is required;
    has $.text;

    method gist{
        $.typeid.gist
    }
}

our role TypeId::Actions {

    # rule type-id-of-the-type-id { <typeid_> }
    method type-id-of-the-type-id($/) {
        make $<typeid>.made
    }

    # rule the-type-id { <type-specifier-seq> <abstract-declarator>? } 
    method the-type-id($/) {

        my $tail = $<abstract-declarator>.made;
        my $body = $<type-specifier-seq>.made;

        if $tail {
            make TheTypeId.new(
                type-specifier-seq  => $body,
                abstract-declarator => $tail,
            )
        } else {
            make $body
        }
    }

    # rule type-id-list { <the-type-id> <ellipsis>? [ <.comma> <the-type-id> <ellipsis>? ]* } 
    method type-id-list($/) {
        make $<the-type-id>>>.made
    }
}

our role TypeId::Rules {

    rule type-id-of-the-type-id {
        <typeid_>
    }

    rule type-id-list {
         <the-type-id> <ellipsis>? [ <comma> <the-type-id> <ellipsis>? ]*
    }

    rule the-type-id {
        <type-specifier-seq> <abstract-declarator>?
    }
}
