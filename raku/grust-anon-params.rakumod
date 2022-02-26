our class AnonArg {
    has $.named_arg;
    has $.ty;
}

our class AnonArgs {
    has Bool $.variadic-tail;
    has @.anon_params;
}

# anon means it's allowed to be anonymous
# (type-only), but it can still have a name
our role AnonParams::Rules {

    rule maybe-comma_anon_params {
        ','? <anon-params>?
    }

    rule maybe-anon_params {
        <anon-params>? ','?
    }

    rule anon-params {
        <anon-param>+ %% <comma>
    }

    #-----------------------
    proto rule anon-param { * }

    rule anon-param:sym<named-arg-ty> {
        <named-arg> ':' <ty>
    }

    rule anon-param:sym<just-ty> {
        <ty>
    }

    rule anon-params_allow_variadic_tail {
        [
            [',' <anon-param>]*
            [',' <DOTDOTDOT>]?
        ]?
    }
}

our role AnonParams::Actions {

    method maybe-comma_anon_params($/) {
        make $<anon_params>.made
    }

    method maybe-anon_params($/) {
        make $<anon-params>.made
    }

    method anon-params($/) {
        make $<anon-param>>>.made,
    }

    method anon-param:sym<named-arg-ty>($/) {
        make AnonArg.new(
            named-arg =>  $<named-arg>.made,
            ty        =>  $<ty>.made,
        )
    }

    method anon-param:sym<just-ty>($/) {
        make $<ty>.made
    }

    method anon-params_allow_variadic_tail($/) {
        make AnonArgs.new(
            anon-params   => $<anon-param>>>.made,
            variadic-tail => so $<DOTDOTDOT>.made,
        )
    }
}