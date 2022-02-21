our class ImplType {
    has $.generic_params;
    has $.attrs_and_vis;
    has $.ty_sum;
    has $.ident;
    has $.maybe_default;
}

our class ImplType::Rules {

    rule impl-type {
        <attrs-and_vis> <maybe-default> <TYPE> <ident> <generic-params> '=' <ty-sum> ';'
    }
}

our class ImplType::Actions {

    method impl-type($/) {
        make ImplType.new(
            attrs-and_vis  =>  $<attrs-and_vis>.made,
            maybe-default  =>  $<maybe-default>.made,
            ident          =>  $<ident>.made,
            generic-params =>  $<generic-params>.made,
            ty-sum         =>  $<ty-sum>.made,
        )
    }
}
