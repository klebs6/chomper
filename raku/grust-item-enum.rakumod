our class EnumArgs {
    has $.struct_decl-fields;
    has $.maybe_ty-sums;
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

our class ItemEnum::Rules {

    rule item-enum { 
        <ENUM> 
        <ident> 
        <generic-params> 
        <maybe-where-clause> 
        '{' <enum-defs> ','? '}' 
    }

    rule enum-defs { <enum-def>* %% "," }

    rule enum-def {
        <attrs-and_vis> <ident> <enum-args>
    }

    #----------------------------
    proto rule enum-args { * }

    rule enum-args:sym<a> { '{' <struct-decl-fields> '}' }
    rule enum-args:sym<b> { '{' <struct-decl-fields> ',' '}' }
    rule enum-args:sym<c> { '(' <maybe-ty-sums> ')' }
    rule enum-args:sym<d> { '=' <expr> }
    rule enum-args:sym<e> { }
}

our class ItemEnum::Actions {

    method item-enum($/) {
        make ItemEnum.new(
            ident              => $<ident>.made,
            generic-params     => $<generic-params>.made,
            maybe-where-clause => $<maybe-where-clause>.made,
            enum-defs          => $<enum-defs>.made,
        )
    }

    method enum-defs($/) {
        make $<enum-def>>>.made
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
            struct-decl-fields =>  $<struct-decl-fields>.made,
        )
    }

    method enum-args:sym<b>($/) {
        make EnumArgs.new(
            struct-decl-fields =>  $<struct-decl-fields>.made,
        )
    }

    method enum-args:sym<c>($/) {
        make EnumArgs.new(
            maybe-ty-sums =>  $<maybe-ty-sums>.made,
        )
    }

    method enum-args:sym<d>($/) {
        make EnumArgs.new(
            expr =>  $<expr>.made,
        )
    }
}
