# regex id-expression:sym<qualified> { 
#   <qualified-id> 
# }
our class IdExpression::Qualified does IIdExpression {
    has QualifiedId $.qualified-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex id-expression:sym<unqualified> { <unqualified-id> }     
our class IdExpression::Unqualified does IIdExpression {
    has IUnqualifiedId $.unqualified-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<op-func-id> { 
#   <operator-function-id> 
# }
our class UnqualifiedId::OpFuncId does IUnqualifiedId {
    has OperatorFunctionId $.operator-function-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<conversion-func-id>  { 
#   <conversion-function-id> 
# }
our class UnqualifiedId::ConversionFuncId does IUnqualifiedId {
    has ConversionFunctionId $.conversion-function-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<literal-operator-id> { 
#   <literal-operator-id> 
# }
our class UnqualifiedId::LiteralOperatorId does IUnqualifiedId {
    has ILiteralOperatorId $.literal-operator-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex unqualified-id:sym<template-id>  { 
#   <template-id> 
# }
our class UnqualifiedId::TemplateId does IUnqualifiedId {
    has ITemplateId $.template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# regex qualified-id { 
#   <nested-name-specifier> 
#   <template>? 
#   <unqualified-id> 
# }
our class QualifiedId does IIdExpression { 
    has INestedNameSpecifier $.nested-name-specifier is required;
    has Bool                $.template              is required;
    has IUnqualifiedId      $.unqualified-id        is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
