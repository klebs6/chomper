our class MetaItems {
    has $.meta_item;
}

our class MetaSeq::G {

    proto rule meta-seq { * }

    rule meta-seq:sym<a> {

    }

    rule meta-seq:sym<b> {
        <meta-item>
    }

    rule meta-seq:sym<c> {
        <meta-seq> ',' <meta-item>
    }
}

our class MetaSeq::A {

    method meta-seq:sym<a>($/) {
        MkNone<140671732528704>
    }

    method meta-seq:sym<b>($/) {
        make MetaItems.new(
            meta-item =>  $<meta-item>.made,
        )
    }

    method meta-seq:sym<c>($/) {
        ExtNode<140671998965976>
    }
}

