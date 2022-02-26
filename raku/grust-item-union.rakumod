
our class ItemUnion::Rules {

    rule item-union {
        <UNION> 
        <ident> 
        <generic-params> 
        <maybe-where-clause> 
        '{' <struct-decl-fields> ','? '}'
    }
}

our class ItemUnion::Actions {

    method item-union($/) {
        make ItemUnion.new(
            ident              => $<ident>.made,
            generic-params     => $<generic-params>.made,
            maybe-where-clause => $<maybe-where-clause>.made,
            struct-decl-fields => $<struct-decl-fields>.made,
        )
    }
}

