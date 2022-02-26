our class PatStruct::Rules {

    rule pat-struct { [[<pat-fields> ','?]? <DOTDOT>?]? }
}

our class PatStruct::Actions {

    method pat-struct($/) {
        make PatStruct.new(
            pat-fields =>  $<pat-fields>.made,
        )
    }
}
