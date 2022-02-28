use grust-model;

our role ImplType::Rules {

    rule impl-type {
        <attrs-and-vis> 
        <maybe-default> 
        <kw-type> 
        <ident> 
        <generic-params> 
        '=' 
        <ty-sum> 
        ';'
    }
}

our role ImplType::Actions {

    method impl-type($/) {
        make ImplType.new(
            attrs-and-vis  =>  $<attrs-and-vis>.made,
            maybe-default  =>  $<maybe-default>.made,
            ident          =>  $<ident>.made,
            generic-params =>  $<generic-params>.made,
            ty-sum         =>  $<ty-sum>.made,
        )
    }
}
