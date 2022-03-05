use grust-model;

our role PatField::Rules {

    proto rule pat-field { * }

    rule pat-field:sym<ident-pat>       {                                        <ident>  ':' <pat> }
    rule pat-field:sym<bound-ident-pat> {                        <binding-mode>  <ident>  ':' <pat> }
    rule pat-field:sym<ident>           {                                        <ident>  }
    rule pat-field:sym<bound-ident>     {                        <binding-mode>  <ident>  }
    rule pat-field:sym<box-ident>       {                 <kw-box>                  <ident>  }
    rule pat-field:sym<box-bound-ident> {                 <kw-box>  <binding-mode>  <ident>  }
    rule pat-field:sym<lit-pat>         { <lit-int>                                   ':' <pat> }

    rule pat-fields { <pat-field>+ %% <tok-comma> }
}

our role PatField::Actions {

    method pat-field:sym<ident-pat>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
            pat   =>  $<pat>.made,
            text  => ~$/,
        )
    }

    method pat-field:sym<bound-ident-pat>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
            text         => ~$/,
        )
    }

    method pat-field:sym<ident>($/) {
        make PatField.new(
            ident => $<ident>.made,
            text  => ~$/,
        )
    }

    method pat-field:sym<bound-ident>($/) {
        make PatField.new(
            binding-mode => $<binding-mode>.made,
            ident        => $<ident>.made,
            text         => ~$/,
        )
    }

    method pat-field:sym<box-ident>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
            text  => ~$/,
        )
    }

    method pat-field:sym<box-bound-ident>($/) {
        make PatField.new(
            binding-mode => $<binding-mode>.made,
            ident        => $<ident>.made,
            text         => ~$/,
        )
    }

    method pat-field:sym<lit-pat>($/) {
        make PatField.new(
            pat  => $<pat>.made,
            text => ~$/,
        )
    }

    #-----------------------------------
    method pat-fields($/) {
        make $<pat-field>>>.made
    }
}
