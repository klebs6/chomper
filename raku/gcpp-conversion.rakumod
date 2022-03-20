
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

our role Conversion::Actions {

    # rule conversion-function-id { <operator> <conversion-type-id> }
    method conversion-function-id($/) {
        make ConversionFunctionId.new(
            conversion-type-id => $<conversion-type-id>.made,
        )
    }

    # rule conversion-type-id { <type-specifier-seq> <conversion-declarator>? }
    method conversion-type-id($/) {
        my $base = $<type-specifier-seq>.made;
        my $tail = $<conversion-declarator>.made;

        if $tail {
            make ConversionTypeId.new(
                type-specifier-seq => $base,
                conversion-declarator => $tail,
            )
        } else {
            make $base
        }
    }

    # rule conversion-declarator { <pointer-operator> <conversion-declarator>? }
    method conversion-declarator($/) {
        my $base = $<pointer-operator>.made;
        my $tail = $<conversion-declarator>.made;

        if $tail {
            make ConversionDeclarator.new(
                pointer-operator      => $base,
                conversion-declarator => $tail,
            )
        } else {
            make $base
        }
    }
}
