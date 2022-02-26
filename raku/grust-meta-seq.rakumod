our class MetaItems {
    has $.meta_item;
}

our class MetaSeq::Rules {

    rule meta-seq {
        <meta-item>* %% ","
    }
}

our class MetaSeq::Actions {

    method meta-seq($/) {
        make $<meta-item>.made
    }
}

