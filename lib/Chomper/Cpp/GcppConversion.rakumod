unit module Chomper::Cpp::GcppConversion;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule conversion-declarator { 
#   <pointer-operator> 
#   <conversion-declarator>? 
# }
our class ConversionDeclarator { 
    has IPointerOperator      $.pointer-operator is required;
    has ConversionDeclarator $.conversion-declarator;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.pointer-operator.gist(:$treemark);

        my $x = $.conversion-declarator;

        if $x {
            $builder ~= " " ~ $x.gist(:$treemark);
        }

        $builder
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

    method gist(:$treemark=False) {

        my $builder = "";

        $builder ~= $.type-specifier-seq.gist(:$treemark) ~ " ";

        if $.conversion-declarator {
            $builder ~= $.conversion-declarator.gist(:$treemark)
        }

        $builder
    }
}

# rule conversion-function-id { 
#   <operator> 
#   <conversion-type-id> 
# }
our class ConversionFunctionId { 
    has ConversionTypeId $.conversion-type-id is required;

    has $.text;

    method gist(:$treemark=False) {
        "operator " ~ $.conversion-type-id.gist(:$treemark)
    }
}

our role Conversion::Actions {

    # rule conversion-function-id { <operator> <conversion-type-id> }
    method conversion-function-id($/) {
        make ConversionFunctionId.new(
            conversion-type-id => $<conversion-type-id>.made,
            text               => ~$/,
        )
    }

    # rule conversion-type-id { <type-specifier-seq> <conversion-declarator>? }
    method conversion-type-id($/) {
        my $base = $<type-specifier-seq>.made;
        my $tail = $<conversion-declarator>.made;

        if $tail {
            make ConversionTypeId.new(
                type-specifier-seq    => $base,
                conversion-declarator => $tail,
                text                  => ~$/,
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
                text                  => ~$/,
            )
        } else {
            make $base
        }
    }
}

our role Conversion::Rules {

    rule conversion-function-id {
        <operator> <conversion-type-id>
    }

    rule conversion-type-id {
        <type-specifier-seq> <conversion-declarator>?
    }

    rule conversion-declarator {
        <pointer-operator> <conversion-declarator>?
    }
}