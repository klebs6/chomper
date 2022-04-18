unit module Chomper::Cpp::GcppConversion;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule conversion-declarator { 
#   <pointer-operator> 
#   <conversion-declarator>? 
# }
class ConversionDeclarator is export { 
    has IPointerOperator      $.pointer-operator is required;
    has ConversionDeclarator $.conversion-declarator;

    has $.text;

    method name {
        'ConversionDeclarator'
    }

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
class ConversionTypeId is export { 
    has ITypeSpecifierSeq    $.type-specifier-seq is required;
    has ConversionDeclarator $.conversion-declarator;

    has $.text;

    method name {
        'ConversionTypeId'
    }

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
class ConversionFunctionId is export { 
    has ConversionTypeId $.conversion-type-id is required;

    has $.text;

    method name {
        'ConversionFunctionId'
    }

    method gist(:$treemark=False) {
        "operator " ~ $.conversion-type-id.gist(:$treemark)
    }
}

package ConversionGrammar is export {

    our role Actions {

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

    our role Rules {

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
}
