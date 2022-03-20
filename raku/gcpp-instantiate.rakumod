# rule explicit-instantiation { 
#   <extern>? 
#   <template> 
#   <declaration> 
# }
our class ExplicitInstantiation { 
    has Bool        $.extern      is required;
    has IDeclaration $.declaration is required; 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
