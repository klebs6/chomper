use grust-model;

our role MetaSeq::Rules {

    rule meta-seq {
        <meta-item>* %% ","
    }
}

our role MetaSeq::Actions {

    method meta-seq($/) {
        make $<meta-item>.made
    }
}
