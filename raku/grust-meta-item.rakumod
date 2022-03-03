use grust-model;

our role MetaItem::Rules {

    token maybe-scoped-ident {
        <ident>+ %% <tok-mod-sep>
    }

    proto rule meta-item { * }

    rule meta-item:sym<c> { <maybe-scoped-ident> '(' <meta-seq> ','? ')' }
    rule meta-item:sym<b> { <maybe-scoped-ident> '=' <lit> }
    rule meta-item:sym<a> { <maybe-scoped-ident> }
    rule meta-item:sym<d> { <lit-int> }
}

our role MetaItem::Actions {

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
