our class DefaultFieldInit {
    has $.expr;
}

our class FieldInit {
    has $.ident;
    has $.expr;
}

our class FieldInits {
    has $.field-init;
}

our class StructExpr::Rules {

    #----------------
    proto rule struct-expr-fields { * }

    rule struct-expr-fields:sym<b> { <field-inits> ','? }
    rule struct-expr-fields:sym<c> { <maybe-field-inits> <default-field-init> }
    rule struct-expr-fields:sym<d> { }

    #----------------
    rule maybe-field-inits { [<field-inits> ','?]? }

    #----------------
    proto rule field-inits { * }
    rule field-inits:sym<a> { <field-init>+ %% "," }

    #----------------
    proto rule field-init { * }

    rule field-init:sym<a>  { <ident> }
    rule field-init:sym<b>  { <ident> ':' <expr> }
    rule field-init:sym<c>  { <LIT-INTEGER> ':' <expr> }
    rule default-field-init { <DOTDOT> <expr> }
}

our class StructExpr::Actions {

    method struct-expr-fields:sym<b>($/) {
        make $<field-inits>.made
    }

    method struct-expr-fields:sym<c>($/) {
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

    method default-field-init($/) {
        make DefaultFieldInit.new(
            expr =>  $<expr>.made,
        )
    }
}
