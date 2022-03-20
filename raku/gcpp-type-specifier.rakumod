# rule trailing-type-specifier:sym<cv-qualifier> { 
#   <cv-qualifier> 
#   <simple-type-specifier> 
# }
our class TrailingTypeSpecifier::CvQualifier does ITrailingTypeSpecifier {
    has ICvQualifier         $.cv-qualifier          is required;
    has ISimpleTypeSpecifier $.simple-type-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-specifier-seq { 
#   <type-specifier>+ 
#   <attribute-specifier-seq>? 
# }
our class TypeSpecifierSeq does ITypeSpecifierSeq { 
    has ITypeNameSpecifier     @.type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule trailing-type-specifier-seq { 
#   <trailing-type-specifier>+ 
#   <attribute-specifier-seq>? 
# }
our class TrailingTypeSpecifierSeq { 
    has ITrailingTypeSpecifier @.trailing-type-specifiers is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
