our class AnonParam {
    has $.named-arg;
    has $.ty;

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

our class AnonParams {
    has Bool $.variadic-tail;
    has @.anon-params;

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
        <anon-param>+ %% <tok-comma>
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
            [',' <tok-dotdotdot>]?
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
        make AnonParam.new(
            named-arg =>  $<named-arg>.made,
            ty        =>  $<ty>.made,
            text      => ~$/,
        )
    }

    method anon-param:sym<just-ty>($/) {
        make AnonParam.new(
            ty        =>  $<ty>.made,
            text      => ~$/,
        )
    }

    method anon-params-allow-variadic-tail($/) {
        make AnonParams.new(
            anon-params   => $<anon-param>>>.made,
            variadic-tail => so $<tok-dotdotdot>.made,
            text      => ~$/,
        )
    }
}
