our role PathExpression::Rules {

    proto rule path-expression { * }

    rule path-expression:sym<path-in> {
        <path-in-expression>
    }

    token path-in-expression {
        <tok-path-sep>?
        [
            <path-expr-segment>+ %% <tok-path-sep>
        ]
    }

    token path-expr-segment {
        <path-ident-segment> 
        [ <tok-path-sep> <generic-args> ]?
    }

    proto token path-ident-segment { * }

    token path-ident-segment:sym<ident>   { <identifier> }
    token path-ident-segment:sym<super>   { <kw-super> }
    token path-ident-segment:sym<selfv>   { <kw-selfvalue> }
    token path-ident-segment:sym<selft>   { <kw-selftype> }
    token path-ident-segment:sym<crate>   { <kw-crate> }
    token path-ident-segment:sym<$-crate> { <tok-dollar> <kw-crate> }

    rule path-expression:sym<qualified-path-in> {
        <qualified-path-in-expression>
    }

    token qualified-path-in-expression {
        <qualified-path-type> [<tok-path-sep> <path-expr-segment>]+
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
            <tok-path-sep>
            <type-path-segment>
        ]+
    }
}

our role PathExpression::Actions {}
