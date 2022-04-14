use Data::Dump::Tree;

our class FloatLiteral {
    has $.value;

    method gist {
        ~$.value
    }
}

our role FloatLiteral::Rules {

    proto token float-suffix { * }
    token float-suffix:sym<f32> { f32 }
    token float-suffix:sym<f64> { f64 }

    proto token float-literal { * }

    token float-literal:sym<a> {
        <dec-literal> 
        <tok-dot> 
        <!before [ <tok-dot> | <tok-underscore> | <identifier> ]>
    }

    token float-literal:sym<b> {
        <dec-literal> 
        <tok-dot>
        <dec-literal> 
        <float-exponent>?
    }

    token float-literal:sym<c> {
        <dec-literal> 
        <float-exponent>
    }

    token float-literal:sym<d> {
        <dec-literal> 
        [
            <tok-dot>
            <dec-literal> 
        ]?
        <float-exponent>?
        <float-suffix>
    }

    proto token float-sign { * }
    token float-sign:sym<+> { <tok-plus> }
    token float-sign:sym<-> { <tok-minus> }

    proto token float-exponent-prefix { * }
    token float-exponent-prefix:sym<e> { e }
    token float-exponent-prefix:sym<E> { E }

    token dec-digit-or-underscore {
        <dec-digit> | <tok-underscore>
    }

    regex float-exponent {
        <float-exponent-prefix> 
        <float-sign>?
        <dec-digit-or-underscore>*
        <dec-digit>
        <dec-digit-or-underscore>*
    }
}
