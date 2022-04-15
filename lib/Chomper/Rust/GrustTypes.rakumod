unit module Chomper::Rust::GrustTypes;

use Data::Dump::Tree;

class ParenthesizedType is export {
    has $.type;

    has $.text;

    method gist {
        "(" ~ $.type.gist ~ ")"
    }
}

class InferredType is export { 
    method gist { "_" }
}

class NeverType is export {
    method gist { "!" }
}

class TupleType is export {
    has @.types;

    has $.text;

    method gist {
        "(" ~ @.types>>.gist.join(",") ~ ")"
    }
}

class ArrayType is export {
    has $.type;
    has $.expression;

    has $.text;

    method gist {
        "[" ~ $.type.gist ~ "; " ~ $.expression.gist ~ "]"
    }
}

class SliceType is export {
    has $.type;

    has $.text;

    method gist {
        "[" ~ $.type.gist ~ "]"
    }
}

class ReferenceType is export {
    has $.maybe-lifetime;
    has Bool $.mutable;
    has $.type-no-bounds;

    has $.text;

    method gist {

        my $builder = "&";

        if $.maybe-lifetime {
            $builder ~= $.maybe-lifetime.gist ~ " ";
        }

        if $.mutable {
            $builder ~= "mut ";
        }

        $builder ~= $.type-no-bounds.gist;

        $builder
    }
}

class RawPtrType is export {
    has Bool $.mutable;
    has $.type-no-bounds;

    has $.text;

    method gist {

        my $builder = "*";

        if $.mutable {
            $builder ~= "mut ";
        } else {
            $builder ~= "const ";
        }

        $builder ~ $.type-no-bounds.gist
    }
}

package TypeGrammar is export {

    our role Rules {

        rule inferred-type { <tok-underscore> }

        proto rule type { * }

        rule type:sym<no-bounds>    { <type-no-bounds> }
        rule type:sym<impl-trait>   { <impl-trait-type> }
        rule type:sym<trait-object> { <trait-object-type> }

        proto rule type-no-bounds { * }

        rule type-no-bounds:sym<bare-fn>        { <bare-function-type> }
        rule type-no-bounds:sym<raw-ptr>        { <raw-pointer-type> }
        rule type-no-bounds:sym<parens>         { <parenthesized-type> }
        rule type-no-bounds:sym<tuple>          { <tuple-type> }
        rule type-no-bounds:sym<impl-trait>     { <impl-trait-type-one-bound> }
        rule type-no-bounds:sym<trait-obj>      { <trait-object-type-one-bound> }
        rule type-no-bounds:sym<type-path>      { <type-path> }
        rule type-no-bounds:sym<never>          { <never-type> }
        rule type-no-bounds:sym<ref>            { <reference-type> }
        rule type-no-bounds:sym<arr>            { <array-type> }
        rule type-no-bounds:sym<slice>          { <slice-type> }
        rule type-no-bounds:sym<inferred>       { <inferred-type> }
        rule type-no-bounds:sym<qualified-path> { <qualified-path-in-type> }
        rule type-no-bounds:sym<macro>          { <macro-invocation> }

        rule parenthesized-type {
            <tok-lparen> <type> <tok-rparen>
        }

        rule never-type { 
            <tok-bang> 
        }

        rule tuple-type {
            <tok-lparen>
            [[<.ws> <type>]* %% <tok-comma>]
            <tok-rparen>
        }

        rule array-type {
            <tok-lbrack>
            <type>
            <tok-semi>
            <expression>
            <tok-rbrack>
        }

        rule slice-type {
            <tok-lbrack>
            <type>
            <tok-rbrack>
        }

        rule reference-type {
            <tok-and>
            <lifetime>?
            <kw-mut>?
            <type-no-bounds>
        }

        rule raw-pointer-type {
            <tok-star>
            [ <kw-mut> | <kw-const> ]
            <type-no-bounds>
        }

    }

    our role Actions {

        method inferred-type($/) { make InferredType.new }

        method type:sym<no-bounds>($/)                { make $<type-no-bounds>.made }
        method type:sym<impl-trait>($/)               { make $<impl-trait-type>.made }
        method type:sym<trait-object>($/)             { make $<trait-object-type>.made }
        method type-no-bounds:sym<bare-fn>($/)        { make $<bare-function-type>.made }
        method type-no-bounds:sym<raw-ptr>($/)        { make $<raw-pointer-type>.made }
        method type-no-bounds:sym<parens>($/)         { make $<parenthesized-type>.made }
        method type-no-bounds:sym<tuple>($/)          { make $<tuple-type>.made }
        method type-no-bounds:sym<impl-trait>($/)     { make $<impl-trait-type-one-bound>.made }
        method type-no-bounds:sym<trait-obj>($/)      { make $<trait-object-type-one-bound>.made }
        method type-no-bounds:sym<type-path>($/)      { make $<type-path>.made }
        method type-no-bounds:sym<never>($/)          { make $<never-type>.made }
        method type-no-bounds:sym<ref>($/)            { make $<reference-type>.made }
        method type-no-bounds:sym<arr>($/)            { make $<array-type>.made }
        method type-no-bounds:sym<slice>($/)          { make $<slice-type>.made }
        method type-no-bounds:sym<inferred>($/)       { make $<inferred-type>.made }
        method type-no-bounds:sym<qualified-path>($/) { make $<qualified-path-in-type>.made }
        method type-no-bounds:sym<macro>($/)          { make $<macro-invocation>.made }

        method parenthesized-type($/) {
            make ParenthesizedType.new(
                type => $<type>.made,
                text => $/.Str,
            )
        }

        method never-type($/) { 
            make NeverType.new
        }

        method tuple-type($/) {
            make TupleType.new(
                types => $<type>>>.made,
                text  => $/.Str,
            )
        }

        method array-type($/) {
            make ArrayType.new(
                type       => $<type>.made,
                expression => $<expression>.made,
                text       => $/.Str,
            )
        }

        method slice-type($/) {
            make SliceType.new(
                type => $<type>.made,
                text => $/.Str,
            )
        }

        method reference-type($/) {
            make ReferenceType.new(
                maybe-lifetime => $<lifetime>.made,
                mutable        => so $/<kw-mut>:exists,
                type-no-bounds => $<type-no-bounds>.made,
                text           => $/.Str,
            )
        }

        method raw-pointer-type($/) {
            make RawPtrType.new(
                mutable        => so $/<kw-mut>:exists,
                type-no-bounds => $<type-no-bounds>.made,
                text           => $/.Str,
            )
        }
    }
}
