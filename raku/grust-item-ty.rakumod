our class ItemTy {
    has $.generic_params;
    has $.maybe_where_clause;
    has $.ty_sum;
    has $.ident;
}

our class ItemType::Rules {

    rule item-type {
        <TYPE> <ident> <generic-params> <maybe-where_clause> '=' <ty-sum> ';'
    }
}

our class ItemType::Actions {

    method item-type($/) {
        make ItemTy.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where_clause =>  $<maybe-where_clause>.made,
            ty-sum             =>  $<ty-sum>.made,
        )
    }
}

