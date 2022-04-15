unit module Chomper::Cpp::GcppElaboratedTypeSpecifier;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppTemplate;

our role IElaboratedTypeSpecifier                       
does IDeclSpecifierSeq
{ }

# rule elaborated-type-specifier:sym<class-ident> { 
#   <.class-key> 
#   <attribute-specifier-seq>? 
#   <nested-name-specifier>? 
#   <identifier> 
# }
our class ElaboratedTypeSpecifier::ClassIdent 
does IElaboratedTypeSpecifier {
    has IClassKey              $.class-key is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has INestedNameSpecifier   $.nested-name-specifier;
    has Identifier             $.identifier is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.class-key.gist(:$treemark) ~ " ";

        #--------------
        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist(:$treemark) ~ " ";
        }

        #--------------
        my $n = $.nested-name-specifier;

        if $n {
            $builder ~= $n.gist(:$treemark) ~ " ";
        }

        $builder ~ $.identifier.gist(:$treemark)
    }
}

# rule elaborated-type-specifier:sym<class-template-id> { 
#   <.class-key> 
#   <simple-template-id> 
# }
our class ElaboratedTypeSpecifier::ClassTemplateId 
does IElaboratedTypeSpecifier {
    has IClassKey        $.class-key is required;
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist(:$treemark=False) {
        $.class-key.gist(:$treemark) ~ " " ~ $.simple-template-id.gist(:$treemark)
    }
}

# rule elaborated-type-specifier:sym<class-nested-template-id> { 
#   <.class-key> 
#   <nested-name-specifier> 
#   <template>? 
#   <simple-template-id> 
# }
our class ElaboratedTypeSpecifier::ClassNestedTemplateId 
does IElaboratedTypeSpecifier {
    has IClassKey            $.class-key is required;
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                 $.has-template-kw is required;
    has SimpleTemplateId     $.simple-template-id is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.class-key.gist(:$treemark) ~ " " ~ $.nested-name-specifier.gist(:$treemark) ~ " ";

        if $.has-template-kw {
            $builder ~= "template ";
        }

        $builder ~ $.simple-template-id.gist(:$treemark)
    }
}

# rule elaborated-type-specifier:sym<enum> { 
#   <.enum_> 
#   <nested-name-specifier>? 
#   <identifier> 
# }
our class ElaboratedTypeSpecifier::Enum 
does IElaboratedTypeSpecifier {
    has INestedNameSpecifier $.nested-name-specifier;
    has Identifier           $.identifier is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "enum ";

        my $n = $.nested-name-specifier;

        if $n {
            $builder ~= $.n.gist(:$treemark) ~ " ";
        }

        $builder ~ $.identifier
    }
}

our role ElaboratedTypeSpecifier::Actions {

    # rule elaborated-type-specifier:sym<class-ident> { 
    #   <.class-key> 
    #   <attribute-specifier-seq>? 
    #   <nested-name-specifier>? 
    #   <identifier> 
    # }
    method elaborated-type-specifier:sym<class-ident>($/) {
        make ElaboratedTypeSpecifier::ClassIdent.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            nested-name-specifier   => $<nested-name-specifier>.made,
            identifier              => $<identifier>.made,
            class-key               => $<class-key>.made,
            text                    => ~$/,
        )
    }

    # rule elaborated-type-specifier:sym<class-template-id> { <.class-key> <simple-template-id> }
    method elaborated-type-specifier:sym<class-template-id>($/) {
        make ElaboratedTypeSpecifier::ClassTemplateId.new(
            simple-template-id => $<simple-template-id>.made,
            class-key          => $<class-key>.made,
            text               => ~$/,
        )
    }

    # rule elaborated-type-specifier:sym<class-nested-template-id> { 
    #   <.class-key> 
    #   <nested-name-specifier> 
    #   <template>? 
    #   <simple-template-id> 
    # }
    method elaborated-type-specifier:sym<class-nested-template-id>($/) {
        make ElaboratedTypeSpecifier::ClassNestedTemplateId.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            simple-template-id    => $<simple-template-id>.made,
            class-key             => $<class-key>.made,
            text                  => ~$/,
        )
    }

    # rule elaborated-type-specifier:sym<enum> { <.enum_> <nested-name-specifier>? <identifier> } 
    method elaborated-type-specifier:sym<enum>($/) {
        make ElaboratedTypeSpecifier::Enum.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            identifier            => $<identifier>.made,
            text                  => ~$/,
        )
    }
}

our role ElaboratedTypeSpecifier::Rules {

    proto rule elaborated-type-specifier { * }

    rule elaborated-type-specifier:sym<class-ident> {
        <class-key>
        <attribute-specifier-seq>? 
        <nested-name-specifier>? 
        <identifier>
    }

    rule elaborated-type-specifier:sym<class-template-id> {
        <class-key>
        <simple-template-id>
    }

    rule elaborated-type-specifier:sym<class-nested-template-id> {
        <class-key>
        <nested-name-specifier> 
        <template>? 
        <simple-template-id>
    }
}