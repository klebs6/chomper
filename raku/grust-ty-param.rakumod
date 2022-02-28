use grust-model;


our role TyParam::Rules {

    proto rule ty-param { * }

    rule ty-param:sym<a> {
        <ident> 
        <maybe-ty-param-bounds> 
        <maybe-ty-default>
    }

    rule ty-param:sym<b> {
        <ident> '?' 
        <ident> 
        <maybe-ty-param-bounds> 
        <maybe-ty-default>
    }
}

our role TyParam::Actions {

    method ty-param:sym<a>($/) {
        make TyParam.new(
            ident                 =>  $<ident>.made,
            maybe-ty-param-bounds =>  $<maybe-ty-param-bounds>.made,
            maybe-ty-default      =>  $<maybe-ty-default>.made,
        )
    }

    method ty-param:sym<b>($/) {
        make TyParam.new(
            ident                 =>  $<ident>.made,
            ident                 =>  $<ident>.made,
            maybe-ty-param-bounds =>  $<maybe-ty-param-bounds>.made,
            maybe-ty-default      =>  $<maybe-ty-default>.made,
        )
    }
}

