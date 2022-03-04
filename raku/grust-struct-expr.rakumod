use grust-model;

our role StructExpr::Rules {

    #----------------
    rule struct-expr-fields {  
        <struct-expr-fields-base>?
    }

    proto rule struct-expr-fields-base { * }

    rule struct-expr-fields-base:sym<c> { <maybe-field-inits> <default-field-init> }
    rule struct-expr-fields-base:sym<b> { <field-inits> ','? }

    #----------------
    rule maybe-field-inits { [<field-inits> ','?]? }

    #----------------
    proto rule field-inits { * }
    rule field-inits:sym<a> { <field-init>+ %% "," }

    #----------------
    rule field-init { 
        <comment>? 
        <field-init-item> 
    }

    proto rule field-init-item { * }

    rule field-init-item:sym<b>  { <ident> ':' <expr> }
    rule field-init-item:sym<a>  { <ident> }
    rule field-init-item:sym<c>  { <lit-int> ':' <expr> }

    rule default-field-init { <tok-dotdot> <expr> }
}

our role StructExpr::Actions {

    method struct-expr-fields-base:sym<b>($/) {
        make $<field-inits>.made
    }

    method struct-expr-fields-base:sym<c>($/) {
        make StructExprFields.new(
            maybe-field-inits  => $<maybe-field-inits>.made,
            default-field-init => $<default-field-init>.made,
        )
    }

    method maybe-field-inits($/) {
        make $<field-inits>.made
    }

    method field-inits:sym<a>($/) {
        make $<field-init>>>.made
    }

    method field-init-item:sym<a>($/) {
        make FieldInit.new(
            ident =>  $<ident>.made,
        )
    }

    method field-init-item:sym<b>($/) {
        make FieldInit.new(
            ident =>  $<ident>.made,
            expr  =>  $<expr>.made,
        )
    }

    method field-init-item:sym<c>($/) {
        make FieldInit.new(
            expr =>  $<expr>.made,
        )
    }

    method default-field-init($/) {
        make DefaultFieldInit.new(
            expr =>  $<expr>.made,
        )
    }
}
