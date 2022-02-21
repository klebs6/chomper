our class DefaultFieldInit {
    has $.expr;
}

our class FieldInit {
    has $.ident;
    has $.expr;
}

our class FieldInits {
    has $.field_init;
}

our class StructExpr::Rules {

    proto rule struct-expr_fields { * }

    rule struct-expr_fields:sym<a> {
        <field-inits>
    }

    rule struct-expr_fields:sym<b> {
        <field-inits> ','
    }

    rule struct-expr_fields:sym<c> {
        <maybe-field_inits> <default-field_init>
    }

    rule struct-expr_fields:sym<d> {

    }

    proto rule maybe-field_inits { * }

    rule maybe-field_inits:sym<a> {
        <field-inits>
    }

    rule maybe-field_inits:sym<b> {
        <field-inits> ','
    }

    rule maybe-field_inits:sym<c> {

    }

    proto rule field-inits { * }

    rule field-inits:sym<a> {
        <field-init>
    }

    rule field-inits:sym<b> {
        <field-inits> ',' <field-init>
    }

    proto rule field-init { * }

    rule field-init:sym<a> {
        <ident>
    }

    rule field-init:sym<b> {
        <ident> ':' <expr>
    }

    rule field-init:sym<c> {
        <LIT-INTEGER> ':' <expr>
    }

    rule default-field_init {
        <DOTDOT> <expr>
    }
}

our class StructExpr::Actions {

    method struct-expr_fields:sym<a>($/) {
        make $<field-inits>.made
    }

    method struct-expr_fields:sym<b>($/) {

    }

    method struct-expr_fields:sym<c>($/) {
        ExtNode<140520912503920>
    }

    method struct-expr_fields:sym<d>($/) {
        MkNone<140520354460832>
    }

    method maybe-field_inits:sym<a>($/) {
        make $<field-inits>.made
    }

    method maybe-field_inits:sym<b>($/) {

    }

    method maybe-field_inits:sym<c>($/) {
        MkNone<140520354460864>
    }

    method field-inits:sym<a>($/) {
        make FieldInits.new(
            field-init =>  $<field-init>.made,
        )
    }

    method field-inits:sym<b>($/) {
        ExtNode<140520912504200>
    }

    method field-init:sym<a>($/) {
        make FieldInit.new(
            ident =>  $<ident>.made,
        )
    }

    method field-init:sym<b>($/) {
        make FieldInit.new(
            ident =>  $<ident>.made,
            expr  =>  $<expr>.made,
        )
    }

    method field-init:sym<c>($/) {
        make FieldInit.new(
            expr =>  $<expr>.made,
        )
    }

    method default-field_init($/) {
        make DefaultFieldInit.new(
            expr =>  $<expr>.made,
        )
    }
}

