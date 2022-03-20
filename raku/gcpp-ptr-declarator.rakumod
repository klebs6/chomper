
# rule pointer-declarator { 
#   <augmented-pointer-operator>* 
#   <no-pointer-declarator> 
# }
our class PointerDeclarator does IDeclarator { 
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
