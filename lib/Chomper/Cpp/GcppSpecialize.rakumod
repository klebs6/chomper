unit module Chomper::Cpp::GcppSpecialize;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule explicit-specialization { 
#   <template> 
#   <less> 
#   <greater> 
#   <declaration> 
# }
class ExplicitSpecialization is export { 
    has IDeclaration $.declaration is required;

    has $.text;

    method gist(:$treemark=False) {
        "template<>" ~ $.declaration.gist(:$treemark)
    }
}

package SpecializeGrammar is export {

    our role Actions {

        # rule explicit-specialization { <template> <less> <greater> <declaration> }
        method explicit-specialization($/) {
            make ExplicitSpecialization.new(
                declaration => $<declaration>.made,
                text        => ~$/,
            )
        }
    }

    our role Rules {

        rule explicit-specialization {
            <template>
            <less>
            <greater>
            <declaration>
        }
    }
}
