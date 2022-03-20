
# rule the-type-id { 
#   <type-specifier-seq> 
#   <abstract-declarator>? 
# }
our class TheTypeId 
does ITheTypeId 
does ITemplateArgument { 

    has ITypeSpecifierSeq   $.type-specifier-seq is required;
    has IAbstractDeclarator $.abstract-declarator;
    
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-id-of-the-type-id { <typeid_> }
our class TypeIdOfTheTypeId {
    has ITypeid $.typeid is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
