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
}

our role Lifetimes::Actions {}
