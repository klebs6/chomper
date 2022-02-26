our class MetaList {
    has $.ident;
    has $.meta_seq;
}

our class MetaNameValue {
    has $.lit;
    has $.ident;
}

our class MetaWord {
    has $.ident;
}

our class MetaItem::Rules {

    proto rule meta-item { * }

    rule meta-item:sym<a> { <ident> }
    rule meta-item:sym<b> { <ident> '=' <lit> }
    rule meta-item:sym<c> { <ident> '(' <meta-seq> ','? ')' }
}

our class MetaItem::Actions {

    method meta-item:sym<a>($/) {
        make MetaWord.new(
            ident =>  $<ident>.made,
        )
    }

    method meta-item:sym<b>($/) {
        make MetaNameValue.new(
            ident =>  $<ident>.made,
            lit   =>  $<lit>.made,
        )
    }

    method meta-item:sym<c>($/) {
        make MetaList.new(
            ident    =>  $<ident>.made,
            meta-seq =>  $<meta-seq>.made,
        )
    }
}
