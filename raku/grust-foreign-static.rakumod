our class StaticItem {
    has $.maybe_mut;
    has $.ident;
    has $.ty;
}

our class ForeignStatic::Rules {

    rule item-foreign_static {
        <maybe-mut> <ident> ':' <ty> ';'
    }
}

our class ForeignStatic::Actions {

    method item-foreign_static($/) {
        make StaticItem.new(
            maybe-mut =>  $<maybe-mut>.made,
            ident     =>  $<ident>.made,
            ty        =>  $<ty>.made,
        )
    }
}

