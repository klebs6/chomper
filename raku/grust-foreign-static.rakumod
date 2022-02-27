use grust-model;


our role ForeignStatic::Rules {

    rule item-foreign_static {
        <maybe-mut> <ident> ':' <ty> ';'
    }
}

our role ForeignStatic::Actions {

    method item-foreign_static($/) {
        make StaticItem.new(
            maybe-mut =>  $<maybe-mut>.made,
            ident     =>  $<ident>.made,
            ty        =>  $<ty>.made,
        )
    }
}

