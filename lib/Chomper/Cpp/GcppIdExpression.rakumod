unit module Chomper::Cpp::GcppIdExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppConversion;
use Chomper::Cpp::GcppDecltype;
use Chomper::Cpp::GcppOperatorId;

use Chomper::TreeMark;

# regex qualified-id { 
#   <nested-name-specifier> 
#   <template>? 
#   <unqualified-id> 
# }
class QualifiedId 
does INoPointerDeclaratorBase
does IIdExpression is export { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.template              is required;
    has IUnqualifiedId      $.unqualified-id        is required;

    has $.text;

    method name {
        'QualifiedId'
    }

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_Identifier>);
        }

        my $builder = $.nested-name-specifier.gist(:$treemark);

        if $.template {
            $builder ~= " template ";
        }

        $builder ~ $.unqualified-id.gist(:$treemark)
    }
}

package IdExpression is export {

    # regex id-expression:sym<qualified> { 
    #   <qualified-id> 
    # }
    our class Qualified does IIdExpression {
        has QualifiedId $.qualified-id is required;

        has $.text;

        method name {
            'IdExpression::Qualified'
        }

        method gist(:$treemark=False) {
            $.qualified-id.gist(:$treemark)
        }
    }

    # regex id-expression:sym<unqualified> { <unqualified-id> }     
    our class Unqualified does IIdExpression {
        has IUnqualifiedId $.unqualified-id is required;

        has $.text;

        method name {
            'IdExpression::Unqualified'
        }

        method gist(:$treemark=False) {
            $.unqualified-id.gist(:$treemark)
        }
    }
}

#------------------------------

package UnqualifiedId is export {

    # regex unqualified-id:sym<ident> { 
    #   <identifier> 
    # }
    our class Ident does IUnqualifiedId {
        has Identifier $.identifier is required;

        has $.text;

        method name {
            'UnqualifiedId::Ident'
        }

        method gist(:$treemark=False) {
            $.identifier.gist(:$treemark)
        }
    }

    # regex unqualified-id:sym<op-func-id> { 
    #   <operator-function-id> 
    # }
    our class OpFuncId does IUnqualifiedId {
        has OperatorFunctionId $.operator-function-id is required;

        has $.text;

        method name {
            'UnqualifiedId::OpFuncId'
        }

        method gist(:$treemark=False) {
            $.operator-function-id.gist(:$treemark)
        }
    }

    # regex unqualified-id:sym<conversion-func-id>  { 
    #   <conversion-function-id> 
    # }
    our class ConversionFuncId does IUnqualifiedId {
        has ConversionFunctionId $.conversion-function-id is required;

        has $.text;

        method name {
            'UnqualifiedId::ConversionFuncId'
        }

        method gist(:$treemark=False) {
            $.conversion-function-id.gist(:$treemark)
        }
    }

    # regex unqualified-id:sym<literal-operator-id> { 
    #   <literal-operator-id> 
    # }
    our class LiteralOperatorId does IUnqualifiedId {
        has ILiteralOperatorId $.literal-operator-id is required;

        has $.text;

        method name {
            'UnqualifiedId::LiteralOperatorId'
        }

        method gist(:$treemark=False) {
            $.literal-operator-id.gist(:$treemark)
        }
    }

    # regex unqualified-id:sym<tilde-classname> { 
    #   <tilde> 
    #   <class-name> 
    # }
    our class TildeClassname does IUnqualifiedId {
        has IClassName $.class-name is required;

        has $.text;

        method name {
            'UnqualifiedId::TildeClassname'
        }

        method gist(:$treemark=False) {
            "~" ~ $.class-name.gist(:$treemark)
        }
    }

    # regex unqualified-id:sym<tilde-decltype> { 
    #   <tilde> 
    #   <decltype-specifier> 
    # }
    our class TildeDecltype does IUnqualifiedId {
        has DecltypeSpecifier $.decltype-specifier is required;

        has $.text;

        method name {
            'UnqualifiedId::TildeDecltype'
        }

        method gist(:$treemark=False) {
            "~" ~ $.decltype-specifier.gist(:$treemark)
        }
    }

    # regex unqualified-id:sym<template-id>  { 
    #   <template-id> 
    # }
    our class TemplateId does IUnqualifiedId {
        has ITemplateId $.template-id is required;

        has $.text;

        method name {
            'UnqualifiedId::TemplateId'
        }

        method gist(:$treemark=False) {
            $.template-id.gist(:$treemark)
        }
    }
}

package IdExpressionGrammar is export {

    our role Actions {

        # regex id-expression:sym<qualified> { <qualified-id> }
        method id-expression:sym<qualified>($/) {
            make $<qualified-id>.made
        }

        # regex id-expression:sym<unqualified> { <unqualified-id> } 
        method id-expression:sym<unqualified>($/) {
            make $<unqualified-id>.made
        }

        # regex unqualified-id:sym<ident> { <identifier> }
        method unqualified-id:sym<ident>($/) {
            make $<identifier>.made
        }

        # regex unqualified-id:sym<op-func-id> { <operator-function-id> }
        method unqualified-id:sym<op-func-id>($/) {
            make $<operator-function-id>.made
        }

        # regex unqualified-id:sym<conversion-func-id> { <conversion-function-id> }
        method unqualified-id:sym<conversion-func-id>($/) {
            make $<conversion-function-id>.made
        }

        # regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
        method unqualified-id:sym<literal-operator-id>($/) {
            make $<literal-operator-id>.made
        }

        # regex unqualified-id:sym<tilde-classname> { <tilde> <class-name> }
        method unqualified-id:sym<tilde-classname>($/) {
            make UnqualifiedId::TildeClassname.new(
                class-name => $<class-name>.made,
                text       => ~$/,
            )
        }

        # regex unqualified-id:sym<tilde-decltype> { <tilde> <decltype-specifier> }
        method unqualified-id:sym<tilde-decltype>($/) {
            make UnqualifiedId::TildeDecltype.new(
                decltype-specifier => $<decltype-specifier>.made,
                text               => ~$/,
            )
        }

        # regex unqualified-id:sym<template-id> { <template-id> } 
        method unqualified-id:sym<template-id>($/) {
            make $<template-id>.made
        }

        # regex qualified-id { <nested-name-specifier> <template>? <unqualified-id> } 
        method qualified-id($/) {
            make QualifiedId.new(
                nested-name-specifier => $<nested-name-specifier>.made,
                template              => $<template>.made,
                unqualified-id        => $<unqualified-id>.made,
                text                  => ~$/,
            )
        }
    }

    our role Rules {

        proto regex id-expression { * }
        regex id-expression:sym<qualified>   { <qualified-id> }
        regex id-expression:sym<unqualified> { <unqualified-id> }

        proto regex unqualified-id { * }
        regex unqualified-id:sym<op-func-id>          { <operator-function-id> }
        regex unqualified-id:sym<conversion-func-id>  { <conversion-function-id> }
        regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
        regex unqualified-id:sym<tilde-classname>     { <tilde> <class-name> }
        regex unqualified-id:sym<tilde-decltype>      { <tilde> <decltype-specifier> }
        regex unqualified-id:sym<template-id>         { <template-id> }
        regex unqualified-id:sym<ident>               { <identifier> }

        regex qualified-id {
            <nested-name-specifier> 
            <template>?  
            <unqualified-id>
        }
    }
}
