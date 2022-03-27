use Data::Dump::Tree;

use gcpp-roles;

# rule explicit-instantiation { 
#   <extern>? 
#   <template> 
#   <declaration> 
# }
our class ExplicitInstantiation { 
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

our role Instantiation::Actions {

    # rule explicit-instantiation { <extern>? <template> <declaration> }
    method explicit-instantiation($/) {
        make ExplicitInstantiation.new(
            declaration => $<declaration>.made,
            text        => ~$/,
        )
    }
}

our role Instantiation::Rules {

    rule explicit-instantiation {
        <extern>?
        <template>
        <declaration>
    }
}
