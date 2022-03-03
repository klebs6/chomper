use grust-model;

our role ItemTraitAlias::Rules {

    rule item-trait-alias {
        <maybe-unsafe> 
        <kw-trait> 
        <ident> 
        '='
        <ty-sum>
        ';'
    }
}

our role ItemTraitAlias::Actions {

    method item-trait-alias($/) {
        make ItemTraitAlias.new(
            unsafe => $<maybe-unsafe><kw-unsafe>:exists,
            name   => $<ident>.made,
            types  => $<ty>>>.made,
        )
    }
}
