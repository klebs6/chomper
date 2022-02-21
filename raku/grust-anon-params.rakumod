our class AnonArg {
    has $.named_arg;
    has $.ty;
}

our class AnonArgs {
    has $.anon_params_allow_variadic_tail;
    has $.anon_param;
}

# anon means it's allowed to be anonymous
# (type-only), but it can still have a name
our class AnonParams::G {

    proto rule maybe-comma_anon_params { * }

    rule maybe-comma_anon_params:sym<a> {
        ','
    }

    rule maybe-comma_anon_params:sym<b> {
        ',' <anon-params>
    }

    rule maybe-comma_anon_params:sym<c> {
        ',' <anon-params> ','
    }

    rule maybe-comma_anon_params:sym<d> {

    }

    proto rule maybe-anon_params { * }

    rule maybe-anon_params:sym<a> {
        <anon-params>
    }

    rule maybe-anon_params:sym<b> {
        <anon-params> ','
    }

    rule maybe-anon_params:sym<c> {

    }

    proto rule anon-params { * }

    rule anon-params:sym<a> {
        <anon-param>
    }

    rule anon-params:sym<b> {
        <anon-params> ',' <anon-param>
    }

    proto rule anon-param { * }

    rule anon-param:sym<a> {
        <named-arg> ':' <ty>
    }

    rule anon-param:sym<b> {
        <ty>
    }

    proto rule anon-params_allow_variadic_tail { * }

    rule anon-params_allow_variadic_tail:sym<a> {
        ',' <DOTDOTDOT>
    }

    rule anon-params_allow_variadic_tail:sym<b> {
        ',' <anon-param> <anon-params_allow_variadic_tail>
    }

    rule anon-params_allow_variadic_tail:sym<c> {

    }
}

our class AnonParams::A {

    method maybe-comma_anon_params:sym<a>($/) {
        MkNone<140355664378144>
    }

    method maybe-comma_anon_params:sym<b>($/) {
        make $<anon_params>.made
    }

    method maybe-comma_anon_params:sym<c>($/) {
        make $<anon_params>.made
    }

    method maybe-comma_anon_params:sym<d>($/) {
        MkNone<140355664378176>
    }

    method maybe-anon_params:sym<a>($/) {
        make $<anon-params>.made
    }

    method maybe-anon_params:sym<b>($/) {

    }

    method maybe-anon_params:sym<c>($/) {
        MkNone<140355664378208>
    }

    method anon-params:sym<a>($/) {
        make AnonArgs.new(
            anon-param =>  $<anon-param>.made,
        )
    }

    method anon-params:sym<b>($/) {
        ExtNode<140357023572960>
    }

    method anon-param:sym<a>($/) {
        make AnonArg.new(
            named-arg =>  $<named-arg>.made,
            ty        =>  $<ty>.made,
        )
    }

    method anon-param:sym<b>($/) {
        make $<ty>.made
    }

    method anon-params_allow_variadic_tail:sym<a>($/) {
        MkNone<140356205527168>
    }

    method anon-params_allow_variadic_tail:sym<b>($/) {
        make AnonArgs.new(
            anon-param                      =>  $<anon-param>.made,
            anon-params_allow_variadic_tail =>  $<anon-params_allow_variadic_tail>.made,
        )
    }

    method anon-params_allow_variadic_tail:sym<c>($/) {
        MkNone<140356205527200>
    }
}
