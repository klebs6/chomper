use grust-model;

# anon means it's allowed to be anonymous
# (type-only), but it can still have a name
our role AnonParams::Rules {

    rule maybe-comma-anon-params {
        ','? <anon-params>?
    }

    rule maybe-anon-params {
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

    rule anon-params-allow-variadic-tail {
        [
            [',' <anon-param>]*
            [',' <dotdotdot>]?
        ]?
    }
}

our role AnonParams::Actions {

    method maybe-comma-anon-params($/) {
        make $<anon-params>.made
    }

    method maybe-anon-params($/) {
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

    method anon-params-allow-variadic-tail($/) {
        make AnonArgs.new(
            anon-params   => $<anon-param>>>.made,
            variadic-tail => so $<dotdotdot>.made,
        )
    }
}
