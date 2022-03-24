use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-conversion;
use gcpp-decltype;
use gcpp-operator-id;

# regex qualified-id { 
#   <nested-name-specifier> 
#   <template>? 
#   <unqualified-id> 
# }
our class QualifiedId 
does INoPointerDeclaratorBase
does IIdExpression { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.template              is required;
    has IUnqualifiedId      $.unqualified-id        is required;

    has $.text;

    method gist{
        my $builder = $.nested-name-specifier.gist;

        if $.template {
            $builder ~= " template ";
        }

        $builder ~ $.unqualified-id.gist
    }
}

# regex id-expression:sym<qualified> { 
#   <qualified-id> 
# }
our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;

    has $.text;

    method gist{
        $.qualified-id.gist
    }
}

# regex id-expression:sym<unqualified> { <unqualified-id> }     
our class IdExpression::Unqualified does IIdExpression {
    has IUnqualifiedId $.unqualified-id is required;

    has $.text;

    method gist{
        $.unqualified-id.gist
    }
}

#------------------------------

# regex unqualified-id:sym<ident> { 
#   <identifier> 
# }
our class UnqualifiedId::Ident does IUnqualifiedId {
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist
    }
}

# regex unqualified-id:sym<op-func-id> { 
#   <operator-function-id> 
# }
our class UnqualifiedId::OpFuncId does IUnqualifiedId {
    has OperatorFunctionId $.operator-function-id is required;

    has $.text;

    method gist{
        $.operator-function-id.gist
    }
}

# regex unqualified-id:sym<conversion-func-id>  { 
#   <conversion-function-id> 
# }
our class UnqualifiedId::ConversionFuncId does IUnqualifiedId {
    has ConversionFunctionId $.conversion-function-id is required;

    has $.text;

    method gist{
        $.conversion-function-id.gist
    }
}

# regex unqualified-id:sym<literal-operator-id> { 
#   <literal-operator-id> 
# }
our class UnqualifiedId::LiteralOperatorId does IUnqualifiedId {
    has ILiteralOperatorId $.literal-operator-id is required;

    has $.text;

    method gist{
        $.literal-operator-id.gist
    }
}

# regex unqualified-id:sym<tilde-classname> { 
#   <tilde> 
#   <class-name> 
# }
our class UnqualifiedId::TildeClassname does IUnqualifiedId {
    has IClassName $.class-name is required;

    has $.text;

    method gist{
        "~" ~ $.class-name.gist
    }
}

# regex unqualified-id:sym<tilde-decltype> { 
#   <tilde> 
#   <decltype-specifier> 
# }
our class UnqualifiedId::TildeDecltype does IUnqualifiedId {
    has DecltypeSpecifier $.decltype-specifier is required;

    has $.text;

    method gist{
        "~" ~ $.decltype-specifier.gist
    }
}

# regex unqualified-id:sym<template-id>  { 
#   <template-id> 
# }
our class UnqualifiedId::TemplateId does IUnqualifiedId {
    has ITemplateId $.template-id is required;

    has $.text;

    method gist{
        $.template-id.gist
    }
}

our role IdExpression::Actions {

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

our role IdExpression::Rules {

    proto regex id-expression { * }
    regex id-expression:sym<qualified>   { <qualified-id> }
    regex id-expression:sym<unqualified> { <unqualified-id> }

    proto regex unqualified-id { * }
    regex unqualified-id:sym<ident>               { <identifier> }
    regex unqualified-id:sym<op-func-id>          { <operator-function-id> }
    regex unqualified-id:sym<conversion-func-id>  { <conversion-function-id> }
    regex unqualified-id:sym<literal-operator-id> { <literal-operator-id> }
    regex unqualified-id:sym<tilde-classname>     { <tilde> <class-name> }
    regex unqualified-id:sym<tilde-decltype>      { <tilde> <decltype-specifier> }
    regex unqualified-id:sym<template-id>         { <template-id> }

    regex qualified-id {
        <nested-name-specifier> 
        <template>?  
        <unqualified-id>
    }
}
