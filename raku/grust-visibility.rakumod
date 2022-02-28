use grust-model;

our role Visibility::Rules {
    rule visibility { <kw-pub>? }
}

our role Visibility::Actions {

    method visibility($/) { 
        if $/<kw-pub>:exists {
            make Public.new 
        } else {
            make Inherited.new 
        }
    }
}
