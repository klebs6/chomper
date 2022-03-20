
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

our role PseudoDestructorName::Actions {

    # rule pseudo-destructor-name:sym<basic> { 
    #   <nested-name-specifier>? 
    #   [ <the-type-name> <doublecolon> ]? 
    #   <tilde> 
    #   <the-type-name> 
    # }
    method pseudo-destructor-name:sym<basic>($/) {
        make PseudoDestructorName::Basic.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            the-scoped-type-name  => $<the-scoped-type-name>.made,
            the-type-anme         => $<the-type-anme>.made,
        )
    }

    # rule pseudo-destructor-name:sym<template> { 
    #   <nested-name-specifier> 
    #   <template> 
    #   <simple-template-id> 
    #   <doublecolon> 
    #   <tilde> 
    #   <the-type-name> 
    # }
    method pseudo-destructor-name:sym<template>($/) {
        make PseudoDestructorName::Template.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            simple-template-id    => $<simple-template-id>.made,
            the-type-name         => $<the-type-name>.made,
        )
    }

    # rule pseudo-destructor-name:sym<decltype> { 
    #   <tilde> 
    #   <decltype-specifier> 
    # } 
    method pseudo-destructor-name:sym<decltype>($/) {
        make PseudoDestructorName::Decltype.new(
            decltype-specifier => $<decltype-specifier>.made,
        )
    }
}
