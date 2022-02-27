use grust-model;


our role ItemType::Rules {

    rule item-type {
        <TYPE> 
        <ident> 
        <generic-params> 
        <maybe-where_clause> 
        '=' <ty-sum> ';'
    }
}

our role ItemType::Actions {

    method item-type($/) {
        make ItemTy.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            ty-sum             =>  $<ty-sum>.made,
        )
    }
}
