use grust-model;


our role Label::Rules {
    rule maybe-label {  
        [<lifetime> ':']?
    }
}
