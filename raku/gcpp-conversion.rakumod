
# rule conversion-function-id { 
#   <operator> 
#   <conversion-type-id> 
# }
our class ConversionFunctionId { 
    has ConversionTypeId $.conversion-type-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule conversion-type-id { 
#   <type-specifier-seq> 
#   <conversion-declarator>? 
# }
our class ConversionTypeId { 
    has ITypeSpecifierSeq    $.type-specifier-seq is required;
    has ConversionDeclarator $.conversion-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule conversion-declarator { 
#   <pointer-operator> 
#   <conversion-declarator>? 
# }
our class ConversionDeclarator { 
    has IPointerOperator      $.pointer-operator is required;
    has ConversionDeclarator $.conversion-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
