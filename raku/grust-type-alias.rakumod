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

our role TypeAlias::Actions {}
