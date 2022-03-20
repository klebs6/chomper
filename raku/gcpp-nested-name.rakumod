
# regex nested-name-specifier-prefix:sym<null> { 
#   <doublecolon> 
# }
our class NestedNameSpecifierPrefix::Null does INestedNameSpecifierPrefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
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
        say "need write gist!";
        ddt self;
        exit;
    }
}

