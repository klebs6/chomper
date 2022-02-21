our class PatField {
    has $.ident;
    has $.pat;
    has $.binding_mode;
}

our class PatFields {
    has $.items;
}

our class PatField::Rules {

    proto rule pat-field { * }

    rule pat-field:sym<ident>           { <ident> }
    rule pat-field:sym<bound-ident>     { <binding-mode> <ident> }
    rule pat-field:sym<box-ident>       { <BOX> <ident> }
    rule pat-field:sym<box-bound-ident> { <BOX> <binding-mode> <ident> }
    rule pat-field:sym<ident-pat>       { <ident> ':' <pat> }
    rule pat-field:sym<bound-ident-pat> { <binding-mode> <ident> ':' <pat> }
    rule pat-field:sym<lit-pat>         { <LIT-INTEGER> ':' <pat> }

    rule pat-fields { <pat-field>+ %% <comma> }
}

our class PatField::Actions {

    method pat-field:sym<ident>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
        )
    }

    method pat-field:sym<bound-ident>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat-field:sym<box-ident>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
        )
    }

    method pat-field:sym<box-bound-ident>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat-field:sym<ident-pat>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
            pat   =>  $<pat>.made,
        )
    }

    method pat-field:sym<bound-ident-pat>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
        )
    }

    method pat-field:sym<lit-pat>($/) {
        make PatField.new(
            pat =>  $<pat>.made,
        )
    }

    #-----------------------------------
    method pat-fields($/) {
        make PatFields.new(
            items => $<pat-field>>>.made
        )
    }
}
