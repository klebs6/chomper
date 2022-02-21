our class PatField {
    has $.ident;
    has $.pat;
    has $.binding_mode;
}

our class PatFields {
    has $.pat_field;
}

our class PatField::Rules {

    proto rule pat-field { * }

    rule pat-field:sym<a> {
        <ident>
    }

    rule pat-field:sym<b> {
        <binding-mode> <ident>
    }

    rule pat-field:sym<c> {
        <BOX> <ident>
    }

    rule pat-field:sym<d> {
        <BOX> <binding-mode> <ident>
    }

    rule pat-field:sym<e> {
        <ident> ':' <pat>
    }

    rule pat-field:sym<f> {
        <binding-mode> <ident> ':' <pat>
    }

    rule pat-field:sym<g> {
        <LIT-INTEGER> ':' <pat>
    }

    proto rule pat-fields { * }

    rule pat-fields:sym<a> {
        <pat-field>
    }

    rule pat-fields:sym<b> {
        <pat-fields> ',' <pat-field>
    }
}

our class PatField::Actions {

    method pat-field:sym<a>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
        )
    }

    method pat-field:sym<b>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat-field:sym<c>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
        )
    }

    method pat-field:sym<d>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
        )
    }

    method pat-field:sym<e>($/) {
        make PatField.new(
            ident =>  $<ident>.made,
            pat   =>  $<pat>.made,
        )
    }

    method pat-field:sym<f>($/) {
        make PatField.new(
            binding-mode =>  $<binding-mode>.made,
            ident        =>  $<ident>.made,
            pat          =>  $<pat>.made,
        )
    }

    method pat-field:sym<g>($/) {
        make PatField.new(
            pat =>  $<pat>.made,
        )
    }

    method pat-fields:sym<a>($/) {
        make PatFields.new(
            pat-field =>  $<pat-field>.made,
        )
    }

    method pat-fields:sym<b>($/) {
        ExtNode<140414857521552>
    }
}
