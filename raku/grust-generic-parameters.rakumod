our class GenericParams {
    has @.generic-params;

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

our class GenericParam {
    has @.outer-attributes;
    has $.generic-param-variant;

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

our class LifetimeParam {
    has $.lifetime-or-label;
    has $.maybe-lifetime-bounds;

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

our class TypeParam {
    has $.identifier;
    has $.maybe-type-param-bounds;
    has $.maybe-type;

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

our class ConstParam {
    has $.identifier;
    has $.type;

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

our role GenericParams::Rules {

    rule generic-params {
        <tok-lt>
        [
            <generic-param>* %% <tok-comma>
        ]
        <tok-gt>
    }

    rule generic-param {
        <outer-attribute>*
        <generic-param-variant>
    }

    #-----------------
    proto rule generic-param-variant { * }

    rule generic-param-variant:sym<lt>    { <lifetime-param> }

    rule generic-param-variant:sym<type>  { <type-param> }

    rule generic-param-variant:sym<const> { <const-param> }

    #-----------------
    rule lifetime-param {
        <lifetime-or-label> [ <tok-colon> <lifetime-bounds> ]?
    }

    rule type-param {
        <identifier>
        [ <tok-colon> <type-param-bounds>? ]?
        [ <tok-eq> <type> ]?
    }

    rule const-param {
        <kw-const> 
        <identifier> 
        <tok-colon> 
        <type>
    }
}

our role GenericParams::Actions {}
