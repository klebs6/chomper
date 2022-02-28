use grust-model;

our role Label::Rules {
    rule maybe-label {  
        [<lifetime> ':']?
    }
}

our role Label::Actions {
    method maybe-label($/) {  
        make Label.new(
            value => $<lifetime>.made
        )
    }
}
