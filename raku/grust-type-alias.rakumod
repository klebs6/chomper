our class TypeAlias {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-type-param-bounds;
    has $.maybe-where-clause;
    has $.maybe-eq-type;

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

our role TypeAlias::Rules {

    rule type-alias {
        <kw-type>
        <identifier>
        <generic-params>?
        [ <tok-colon> <type-param-bounds> ]?
        <where-clause>?
        [ <tok-eq> <type>]?
        <tok-semi>
    }
}

our role TypeAlias::Actions {

    method type-alias($/) {
        <kw-type>
        <identifier>
        <generic-params>?
        [ <tok-colon> <type-param-bounds> ]?
        <where-clause>?
        [ <tok-eq> <type>]?
        <tok-semi>
    }
}
