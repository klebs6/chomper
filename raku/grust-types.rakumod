use Data::Dump::Tree;

our class ParenthesizedType {
    has $.type;

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

our class InferredType { }
our class NeverType    { }

our class TupleType {
    has @.types;

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

our class ArrayType {
    has $.type;
    has $.expression;

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

our class SliceType {
    has $.type;

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

our class ReferenceType {
    has $.maybe-lifetime;
    has Bool $.mutable;
    has $.type-no-bounds;

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

our class RawPtrType {
    has Bool $.mutable;
    has $.type-no-bounds;

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

our role Type::Rules {

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
        [[<.ws> <type>]+ %% <tok-comma>]
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

our role Type::Actions {

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
