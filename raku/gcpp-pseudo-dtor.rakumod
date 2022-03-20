
# rule pseudo-destructor-name:sym<basic> { 
#   <nested-name-specifier>? 
#   [ <the-type-name> <doublecolon> ]? 
#   <tilde> 
#   <the-type-name> 
# }
our class PseudoDestructorName::Basic does IPseudoDestructorName {
    has Bool        $.nested-name-specifier;
    has ITheTypeName $.the-scoped-type-name;
    has ITheTypeName $.the-type-anme is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pseudo-destructor-name:sym<template> { 
#   <nested-name-specifier> 
#   <template> 
#   <simple-template-id> 
#   <doublecolon> 
#   <tilde> 
#   <the-type-name> 
# }
our class PseudoDestructorName::Template does IPseudoDestructorName {
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId     $.simple-template-id    is required;
    has ITheTypeName         $.the-type-name         is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule pseudo-destructor-name:sym<decltype> { <tilde> <decltype-specifier> } #-------------------------------------
our class PseudoDestructorName::Decltype does IPseudoDestructorName {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


