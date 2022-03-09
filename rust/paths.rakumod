our role SimplePath::Rules {

    token simple-path {
        <tok-mod-sep>?
        [
            <simple-path-segment>+ %% <tok-mod-sep>
        ]
    }

    proto token simple-path-segment { * }
    token simple-path-segment:sym<ident>   { <identifier> }
    token simple-path-segment:sym<super>   { <super> }
    token simple-path-segment:sym<self>    { <self> }
    token simple-path-segment:sym<crate>   { <crate> }
    token simple-path-segment:sym<$-crate> { <tok-dollar> <crate> }

    token path-in-expression {
        <tok-mod-sep>?
        [
            <path-expr-segment>+ %% <tok-mod-sep>
        ]
    }

    token path-expr-segment {
        <path-ident-segment> 
        [ <tok-mod-sep> <generic-args> ]?
    }

    proto token path-ident-segment { * }

    token path-ident-segment:sym<ident>   { <identifier> }
    token path-ident-segment:sym<super>   { <super> }
    token path-ident-segment:sym<self>    { <self> }
    token path-ident-segment:sym<Self>    { <Self> }
    token path-ident-segment:sym<crate>   { <crate> }
    token path-ident-segment:sym<$-crate> { <tok-dollar> <crate> }

    token qualified-path-in-expression {
        <qualified-path-type> [<tok-mod-sep> <path-expr-segment>]+
    }

    rule qualified-path-type {
        <tok-lt>
        <type>
        [
            <kw-as>
            <type-path>
        ]?
        <tok-gt>
    }

    token qualified-path-in-type {
        <qualified-path-type>
        [
            <tok-mod-sep>
            <type-path-segment>
        ]+
    }
}
