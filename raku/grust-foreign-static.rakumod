use grust-model;


our role ForeignStatic::Rules {

    rule item-foreign-static {
        <maybe-mut> <ident> ':' <ty> ';'
    }
}

our role ForeignStatic::Actions {

    method item-foreign-static($/) {
        make StaticItem.new(
            maybe-mut =>  $<maybe-mut>.made,
            ident     =>  $<ident>.made,
            ty        =>  $<ty>.made,
        )
    }
}


