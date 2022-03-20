# rule explicit-specialization { 
#   <template> 
#   <less> 
#   <greater> 
#   <declaration> 
# }
our class ExplicitSpecialization { 
    has IDeclaration $.declaration is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Specialize::Actions {

    # rule explicit-specialization { <template> <less> <greater> <declaration> }
    method explicit-specialization($/) {
        make ExplicitSpecialization.new(
            declaration => $<declaration>.made,
        )
    }
}
