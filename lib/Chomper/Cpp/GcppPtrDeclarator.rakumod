unit module Chomper::Cpp::GcppPtrDeclarator;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule pointer-declarator { 
#   <augmented-pointer-operator>* 
#   <no-pointer-declarator> 
# }
class PointerDeclarator 
does ISomeDeclarator
does IPointerDeclarator
does IInitDeclarator
does IParameterDeclarationBody
does IDeclarator is export { 
    has IAugmentedPointerOperator @.augmented-pointer-operators;
    has INoPointerDeclarator      $.no-pointer-declarator is required;

    has $.text;

    method name {
        'PointerDeclarator'
    }

    method gist(:$treemark=False) {
        @.augmented-pointer-operators>>.gist(:$treemark).join(" ") 
        ~ $.no-pointer-declarator.gist(:$treemark)
    }
}

package PointerDeclaratorGrammar is export {

    our role Actions {

        # rule pointer-declarator { <augmented-pointer-operator>* <no-pointer-declarator> }
        method pointer-declarator($/) {

            my $base      = $<no-pointer-declarator>.made;
            my @augmented = $<augmented-pointer-operator>>>.made.List;

            if @augmented.elems gt 0 {

                make PointerDeclarator.new(
                    augmented-pointer-operators => @augmented,
                    no-pointer-declarator       => $base,
                    text                        => ~$/,
                )

            } else {

                make $base
            }
        }
    }

    our role Rules {

        rule init-declarator-list {
            <init-declarator> [ <comma> <init-declarator> ]*
        }

        rule init-declarator {
            <declarator> <initializer>?
        }

        #--------------------------
        proto rule declarator { * }
        rule declarator:sym<ptr>    { <pointer-declarator> }
        rule declarator:sym<no-ptr> { <no-pointer-declarator> <parameters-and-qualifiers> <trailing-return-type> }

        rule pointer-declarator {
            <augmented-pointer-operator>* <no-pointer-declarator>
        }
    }
}
