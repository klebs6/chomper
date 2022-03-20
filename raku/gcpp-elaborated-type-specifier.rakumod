
# rule elaborated-type-specifier:sym<class-ident> { 
#   <.class-key> 
#   <attribute-specifier-seq>? 
#   <nested-name-specifier>? 
#   <identifier> 
# }
our class ElaboratedTypeSpecifier::ClassIdent 
does IElaboratedTypeSpecifier {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has INestedNameSpecifier   $.nested-name-specifier;
    has Identifier            $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule elaborated-type-specifier:sym<class-template-id> { 
#   <.class-key> 
#   <simple-template-id> 
# }
our class ElaboratedTypeSpecifier::ClassTemplateId 
does IElaboratedTypeSpecifier {
    has SimpleTemplateId $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
    has INestedNameSpecifier $.nested-name-specifier is required;
    has SimpleTemplateId    $.simple-template-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
    has Identifier          $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
