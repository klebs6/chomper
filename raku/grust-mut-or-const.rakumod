use grust-model;

our role MutOrConst::Rules {

    rule maybe-mut          { <MUT>? }
    rule maybe-mut-or-const { [<MUT> | <CONST>]? }
}

our role MutOrConst::Actions {

    method maybe-mut($/) { 
        if $/<MUT>:exists {
            make MutMutable.new 
        } else {
            make MutImmutable.new 
        }
    }

    method maybe-mut-or-const($/) { 
        if $/<MUT>:exists {
            make MutMutable.new 
        } else {
            make MutImmutable.new 
        }
    }
}
