use Data::Dump::Tree;

use gcpp-roles;

# rule explicit-specialization { 
#   <template> 
#   <less> 
#   <greater> 
#   <declaration> 
# }
our class ExplicitSpecialization { 
    has IDeclaration $.declaration is required;

    has $.text;

    method gist(:$treemark=False) {
        "template<>" ~ $.declaration.gist(:$treemark)
    }
}

our role Specialize::Actions {

    # rule explicit-specialization { <template> <less> <greater> <declaration> }
    method explicit-specialization($/) {
        make ExplicitSpecialization.new(
            declaration => $<declaration>.made,
            text        => ~$/,
        )
    }
}

our role Specialize::Rules {

    rule explicit-specialization {
        <template>
        <less>
        <greater>
        <declaration>
    }
}
