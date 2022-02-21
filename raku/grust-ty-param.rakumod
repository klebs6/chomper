our class TyParam {
    has $.maybe_ty_param_bounds;
    has $.maybe_ty_default;
    has $.ident;
}

our class TyParam::Rules {

    proto rule ty-param { * }

    rule ty-param:sym<a> {
        <ident> <maybe-ty_param_bounds> <maybe-ty_default>
    }

    rule ty-param:sym<b> {
        <ident> '?' <ident> <maybe-ty_param_bounds> <maybe-ty_default>
    }
}

our class TyParam::Actions {

    method ty-param:sym<a>($/) {
        make TyParam.new(
            ident                 =>  $<ident>.made,
            maybe-ty_param_bounds =>  $<maybe-ty_param_bounds>.made,
            maybe-ty_default      =>  $<maybe-ty_default>.made,
        )
    }

    method ty-param:sym<b>($/) {
        make TyParam.new(
            ident                 =>  $<ident>.made,
            ident                 =>  $<ident>.made,
            maybe-ty_param_bounds =>  $<maybe-ty_param_bounds>.made,
            maybe-ty_default      =>  $<maybe-ty_default>.made,
        )
    }
}
