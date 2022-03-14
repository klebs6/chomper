our class Pattern {
    has @.pattern-no-top-alts;

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

our class IdentifierPattern {
    has Bool $.ref;
    has Bool $.mutable;
    has $.identifier;
    has $.maybe-at-pattern;

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

our class WildcardPattern {

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

our class RestPattern {

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

our role Pattern::Rules {

    rule pattern {
        <tok-or>? 
        <pattern-no-top-alt> 
        [ <tok-or> <pattern-no-top-alt> ]*
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
    rule pattern-without-range:sym<path>             { <path-pattern>         } 
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
    rule pattern-without-range:sym<macro-invocation> { <macro-invocation>     } 

}

our role Pattern::Actions {

    method pattern($/) {
        <tok-or>? 
        <pattern-no-top-alt> 
        [ <tok-or> <pattern-no-top-alt> ]*
    }

    method pattern-no-top-alt:sym<no-range>($/) { <pattern-without-range> }

    method pattern-no-top-alt:sym<range>($/)    { <range-pattern> }

    method identifier-pattern($/) {
        <kw-ref>?
        <kw-mut>?
        <identifier>
        [ <tok-at> <pattern> ]?
    }

    method wildcard-pattern($/) {
        <tok-underscore>
    }

    method rest-pattern($/) {
        <tok-dotdot>
    }

    #---------------------
    method pattern-without-range:sym<path>($/)             { <path-pattern>         } 
    method pattern-without-range:sym<literal>($/)          { <literal-pattern>      } 
    method pattern-without-range:sym<identifier>($/)       { <identifier-pattern>   } 
    method pattern-without-range:sym<wildcard>($/)         { <wildcard-pattern>     } 
    method pattern-without-range:sym<rest>($/)             { <rest-pattern>         } 
    method pattern-without-range:sym<ref>($/)              { <reference-pattern>    } 
    method pattern-without-range:sym<struct>($/)           { <struct-pattern>       } 
    method pattern-without-range:sym<tuple-struct>($/)     { <tuple-struct-pattern> } 
    method pattern-without-range:sym<tuple>($/)            { <tuple-pattern>        } 
    method pattern-without-range:sym<grouped>($/)          { <grouped-pattern>      } 
    method pattern-without-range:sym<slice>($/)            { <slice-pattern>        } 
    method pattern-without-range:sym<macro-invocation>($/) { <macro-invocation>     } 
}
