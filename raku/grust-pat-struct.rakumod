use grust-model;

our role PatStruct::Rules {

    rule pat-struct { [[<pat-fields> ','?]? <dotdot>?]? }
}

our role PatStruct::Actions {

    method pat-struct($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }
}
