our class Label {
    has $.value;

    has $.text;

    method gist {
        if so $.value {
            "{$.value.gist}:"
        } else {
            ""
        }
    }
}

our role Label::Rules {
    rule maybe-label {  
        [<lifetime> ':']?
    }
}

our role Label::Actions {
    method maybe-label($/) {  
        make Label.new(
            value => $<lifetime>.made,
            text  => ~$/,
        )
    }
}
