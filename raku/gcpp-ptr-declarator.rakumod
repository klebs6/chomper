use Data::Dump::Tree;

use gcpp-roles;

# rule pointer-declarator { 
#   <augmented-pointer-operator>* 
#   <no-pointer-declarator> 
# }
our class PointerDeclarator 
does ISomeDeclarator
does IInitDeclarator
does IParameterDeclarationBody
does IDeclarator { 
    has IAugmentedPointerOperator @.augmented-pointer-operators;
    has INoPointerDeclarator      $.no-pointer-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role PointerDeclarator::Actions {

    # rule pointer-declarator { <augmented-pointer-operator>* <no-pointer-declarator> }
    method pointer-declarator($/) {

        my $base      = $<no-pointer-declarator>.made;
        my @augmented = $<augmented-pointer-operator>>>.made.List;

        if @augmented.elems gt 0 {

            make PointerDeclarator.new(
                augmented-pointer-operators => @augmented,
                no-pointer-declarator       => $base,
            )

        } else {

            make $base
        }
    }
}

our role PointerDeclarator::Rules {

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