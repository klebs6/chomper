our role Lifetimes::Rules {

    proto token lifetime-token { * }

    token lifetime-token:sym<a> {
        <tok-single-quote>
        <identifier-or-keyword>
    }

    token lifetime-token:sym<b> {
        <tok-single-quote>
        <tok-underscore>
    }

    token lifetime-or-label {
        <tok-single-quote>
        <non-keyword-identifier>
    }

    rule lifetime-bounds {
        <lifetime>* %% <tok-plus>
    }

    proto token lifetime { * }
    token lifetime:sym<lt>      { <lifetime-or-label> }
    token lifetime:sym<static>  { \' <static> }
    token lifetime:sym<unnamed> { \' _ }

    rule for-lifetimes {
        <kw-for> <generic-params>
    }
}

our role Lifetimes::Actions {}
