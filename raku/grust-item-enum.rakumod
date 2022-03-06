our class EnumDef {
    has $.attrs-and-vis;
    has $.enum-args;
    has $.ident;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class EnumArgs {
    has $.struct-decl-fields;
    has $.maybe-ty-sums;
    has $.expr;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ItemEnum {
    has $.ident;
    has $.generic-params;
    has $.maybe-where-clause;
    has $.enum-defs;
    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role ItemEnum::Rules {

    rule item-enum { 
        <kw-enum> 
        <ident> 
        <generic-params> 
        <maybe-where-clause> 
        '{' <enum-defs> ','? '}' 
    }

    rule enum-defs { <enum-def>* %% "," }

    rule enum-def {
        <attrs-and-vis> 
        <ident> 
        <enum-args>
    }

    #----------------------------
    rule enum-args { <enum-args-body>? }

    proto rule enum-args-body { * }

    rule enum-args-body:sym<a> { '{' <struct-decl-fields> '}' }
    rule enum-args-body:sym<b> { '{' <struct-decl-fields> ',' '}' }
    rule enum-args-body:sym<c> { '(' <maybe-ty-sums> ')' }
    rule enum-args-body:sym<d> { '=' <expr> }
}

our role ItemEnum::Actions {

    method item-enum($/) {
        make ItemEnum.new(
            ident              => $<ident>.made,
            generic-params     => $<generic-params>.made,
            maybe-where-clause => $<maybe-where-clause>.made,
            enum-defs          => $<enum-defs>.made,
            text               => ~$/,
        )
    }

    method enum-defs($/) {
        make $<enum-def>>>.made
    }

    method enum-def($/) {
        make EnumDef.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            ident         =>  $<ident>.made,
            enum-args     =>  $<enum-args>.made,
            text          => ~$/,
        )
    }

    method enum-args:sym<a>($/) {
        make EnumArgs.new(
            struct-decl-fields =>  $<struct-decl-fields>.made,
            text               => ~$/,
        )
    }

    method enum-args:sym<b>($/) {
        make EnumArgs.new(
            struct-decl-fields =>  $<struct-decl-fields>.made,
            text               => ~$/,
        )
    }

    method enum-args:sym<c>($/) {
        make EnumArgs.new(
            maybe-ty-sums =>  $<maybe-ty-sums>.made,
            text          => ~$/,
        )
    }

    method enum-args:sym<d>($/) {
        make EnumArgs.new(
            expr => $<expr>.made,
            text => ~$/,
        )
    }
}
