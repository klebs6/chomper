
our role Pattern::Rules {

    rule pattern {
        <tok-pipe>? 
        <pattern-no-top-alt> 
        [ <tok-pipe> <pattern-no-top-alt> ]*
    }

    proto rule pattern-no-top-alt { * }

    rule pattern-no-top-alt:sym<no-range> { <pattern-without-range> }

    rule pattern-no-top-alt:sym<range>    { <range-pattern> }

    rule identifier-pattern {
        <kw-ref>?
        <kw-mut>?
        <identifier>
        [ <tok-at> <pattern> ]?
    }

    token wildcard-pattern {
        <tok-underscore>
    }

    token rest-pattern {
        <tok-dotdot>
    }

    #---------------------
    proto rule pattern-without-range { * }
    rule pattern-without-range:sym<literal>          { <literal-pattern>      } 
    rule pattern-without-range:sym<identifier>       { <identifier-pattern>   } 
    rule pattern-without-range:sym<wildcard>         { <wildcard-pattern>     } 
    rule pattern-without-range:sym<rest>             { <rest-pattern>         } 
    rule pattern-without-range:sym<ref>              { <reference-pattern>    } 
    rule pattern-without-range:sym<struct>           { <struct-pattern>       } 
    rule pattern-without-range:sym<tuple-struct>     { <tuple-struct-pattern> } 
    rule pattern-without-range:sym<tuple>            { <tuple-pattern>        } 
    rule pattern-without-range:sym<grouped>          { <grouped-pattern>      } 
    rule pattern-without-range:sym<slice>            { <slice-pattern>        } 
    rule pattern-without-range:sym<path>             { <path-pattern>         } 
    rule pattern-without-range:sym<macro-invocation> { <macro-invocation>     } 
}
