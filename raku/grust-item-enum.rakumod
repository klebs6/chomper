our class EnumArgs {
    has $.struct_decl_fields;
    has $.maybe_ty_sums;
    has $.expr;
}

our class EnumDef {
    has $.attrs_and_vis;
    has $.enum_args;
    has $.ident;
}

our class EnumDefs {
    has $.enum_def;
}

our class ItemEnum::G {

    proto rule item-enum { * }

    rule item-enum:sym<a> {
        <ENUM> <ident> <generic-params> <maybe-where_clause> '{' <enum-defs> '}'
    }

    rule item-enum:sym<b> {
        <ENUM> <ident> <generic-params> <maybe-where_clause> '{' <enum-defs> ',' '}'
    }

    proto rule enum-defs { * }

    rule enum-defs:sym<a> {
        <enum-def>
    }

    rule enum-defs:sym<b> {
        <enum-defs> ',' <enum-def>
    }

    rule enum-defs:sym<c> {

    }

    rule enum-def {
        <attrs-and_vis> <ident> <enum-args>
    }

    proto rule enum-args { * }

    rule enum-args:sym<a> {
        '{' <struct-decl_fields> '}'
    }

    rule enum-args:sym<b> {
        '{' <struct-decl_fields> ',' '}'
    }

    rule enum-args:sym<c> {
        '(' <maybe-ty_sums> ')'
    }

    rule enum-args:sym<d> {
        '=' <expr>
    }

    rule enum-args:sym<e> {

    }
}

our class ItemEnum::A {

    method item-enum:sym<a>($/) {
        make ItemEnum.new(

        )
    }

    method item-enum:sym<b>($/) {
        make ItemEnum.new(

        )
    }

    method enum-defs:sym<a>($/) {
        make EnumDefs.new(
            enum-def =>  $<enum-def>.made,
        )
    }

    method enum-defs:sym<b>($/) {
        ExtNode<140467083015800>
    }

    method enum-defs:sym<c>($/) {
        MkNone<140468669847744>
    }

    method enum-def($/) {
        make EnumDef.new(
            attrs-and_vis =>  $<attrs-and_vis>.made,
            ident         =>  $<ident>.made,
            enum-args     =>  $<enum-args>.made,
        )
    }

    method enum-args:sym<a>($/) {
        make EnumArgs.new(
            struct-decl_fields =>  $<struct-decl_fields>.made,
        )
    }

    method enum-args:sym<b>($/) {
        make EnumArgs.new(
            struct-decl_fields =>  $<struct-decl_fields>.made,
        )
    }

    method enum-args:sym<c>($/) {
        make EnumArgs.new(
            maybe-ty_sums =>  $<maybe-ty_sums>.made,
        )
    }

    method enum-args:sym<d>($/) {
        make EnumArgs.new(
            expr =>  $<expr>.made,
        )
    }

    method enum-args:sym<e>($/) {
        MkNone<140468669847776>
    }
}

