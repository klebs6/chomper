unit module Chomper::Cpp::GcppInstantiate;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule explicit-instantiation { 
#   <extern>? 
#   <template> 
#   <declaration> 
# }
class ExplicitInstantiation is export { 
    has Bool        $.extern      is required;
    has IDeclaration $.declaration is required; 

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.extern {
            $builder ~= "extern ";
        }

        $builder ~ "template " ~ $.declaration.gist(:$treemark)
    }
}

package InstantiationGrammar is export {

    our role Actions {

        # rule explicit-instantiation { <extern>? <template> <declaration> }
        method explicit-instantiation($/) {
            make ExplicitInstantiation.new(
                declaration => $<declaration>.made,
                text        => ~$/,
            )
        }
    }

    our role Rules {

        rule explicit-instantiation {
            <extern>?
            <template>
            <declaration>
        }
    }
}
