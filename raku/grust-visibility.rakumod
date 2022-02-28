use grust-model;

our role Visibility::Rules {
    rule visibility { <PUB>? }
}

our role Visibility::Actions {

    method visibility($/) { 
        if $/<PUB>:exists {
            make Public.new 
        } else {
            make Inherited.new 
        }
    }
}

