unit module Chomper::Rust::GrustPatternExpressions;

use Data::Dump::Tree;

class Pattern is export {

    has @.pattern-no-top-alts;

    has $.text;

    method gist {
        @.pattern-no-top-alts>>.gist.join("|")
    }
}

class IdentifierPattern is export {
    has Bool $.ref;
    has Bool $.mutable;
    has $.identifier;
    has $.maybe-at-pattern;

    has $.text;

    method gist {

        my $builder = "";

        if so $.ref {
            $builder ~= "ref ";
        }

        if so $.mutable {
            $builder ~= "mut ";
        }

        $builder ~= $.identifier.gist;

        if so $.maybe-at-pattern {
            $builder ~= " at {$.maybe-at-pattern.gist}";
        }

        $builder
    }
}

class WildcardPattern is export { method gist {  '*' } }

class RestPattern     is export { method gist { '..' } }

package PatternGrammar is export {

    our role Rules {

        rule pattern {
            <tok-or>? 
            [<pattern-no-top-alt>+ %% <tok-or>]
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
        rule pattern-without-range:sym<tuple-struct>     { <tuple-struct-pattern> } 
        rule pattern-without-range:sym<identifier>       { <identifier-pattern>   } 
        rule pattern-without-range:sym<path>             { <path-pattern>         } 
        rule pattern-without-range:sym<literal>          { <literal-pattern>      } 
        rule pattern-without-range:sym<wildcard>         { <wildcard-pattern>     } 
        rule pattern-without-range:sym<rest>             { <rest-pattern>         } 
        rule pattern-without-range:sym<ref>              { <reference-pattern>    } 
        rule pattern-without-range:sym<struct>           { <struct-pattern>       } 
        rule pattern-without-range:sym<tuple>            { <tuple-pattern>        } 
        rule pattern-without-range:sym<grouped>          { <grouped-pattern>      } 
        rule pattern-without-range:sym<slice>            { <slice-pattern>        } 
        rule pattern-without-range:sym<macro-invocation> { <macro-invocation>     } 
    }

    our role Actions {

        method pattern($/) {
            make Pattern.new(
                pattern-no-top-alts => $<pattern-no-top-alt>>>.made,
                text                => $/.Str,
            )
        }

        method pattern-no-top-alt:sym<no-range>($/) { 
            make $<pattern-without-range>.made 
        }

        method pattern-no-top-alt:sym<range>($/)    { 
            make $<range-pattern>.made 
        }

        method identifier-pattern($/) {
            make IdentifierPattern.new(
                ref              => so $/<kw-ref>:exists,
                mutable          => so $/<kw-mut>:exists,
                identifier       => $<identifier>.made,
                maybe-at-pattern => $<pattern>.made,
                text             => $/.Str,
            )
        }

        method wildcard-pattern($/) {
            make WildcardPattern.new
        }

        method rest-pattern($/) {
            make RestPattern.new
        }

        #---------------------
        method pattern-without-range:sym<path>($/)             { make $<path-pattern>.made         } 

        method pattern-without-range:sym<literal>($/) { 
            make $<literal-pattern>.made
        } 

        method pattern-without-range:sym<identifier>($/)       { make $<identifier-pattern>.made   } 
        method pattern-without-range:sym<wildcard>($/)         { make $<wildcard-pattern>.made     } 
        method pattern-without-range:sym<rest>($/)             { make $<rest-pattern>.made         } 
        method pattern-without-range:sym<ref>($/)              { make $<reference-pattern>.made    } 
        method pattern-without-range:sym<struct>($/)           { make $<struct-pattern>.made       } 
        method pattern-without-range:sym<tuple-struct>($/)     { make $<tuple-struct-pattern>.made } 
        method pattern-without-range:sym<tuple>($/)            { make $<tuple-pattern>.made        } 
        method pattern-without-range:sym<grouped>($/)          { make $<grouped-pattern>.made      } 
        method pattern-without-range:sym<slice>($/)            { make $<slice-pattern>.made        } 
        method pattern-without-range:sym<macro-invocation>($/) { make $<macro-invocation>.made     } 
    }
}
