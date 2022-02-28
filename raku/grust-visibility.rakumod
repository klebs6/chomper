use grust-model;

our role Visibility::Rules {
    rule visibility { <pub>? }
}

our role Visibility::Actions {

    method visibility($/) { 
        if $/<pub>:exists {
            make Public.new 
        } else {
            make Inherited.new 
        }
    }
}
