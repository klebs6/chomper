use grust-model;

our role MutOrConst::Rules {

    rule maybe-mut          { <mut>? }
    rule maybe-mut-or-const { [<mut> | <const>]? }
}

our role MutOrConst::Actions {

    method maybe-mut($/) { 
        if $/<mut>:exists {
            make MutMutable.new 
        } else {
            make MutImmutable.new 
        }
    }

    method maybe-mut-or-const($/) { 
        if $/<mut>:exists {
            make MutMutable.new 
        } else {
            make MutImmutable.new 
        }
    }
}
