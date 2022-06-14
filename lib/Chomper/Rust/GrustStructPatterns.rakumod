unit module Chomper::Rust::GrustStructPatterns;

use Data::Dump::Tree;

class StructPattern is export {
    has $.path-in-expression;
    has $.maybe-struct-pattern-elements;

    has $.text;

    method gist {

        my $builder = "";

        $builder ~= $.path-in-expression.gist;
        $builder ~= ' {';

        if $.maybe-struct-pattern-elements {

            $builder ~= " " ~ $.maybe-struct-pattern-elements.gist ~ " ";
        }

        $builder ~= '}';
        $builder
    }
}

class StructPatternElementsBasic is export {
    has @.struct-pattern-fields;
    has $.maybe-struct-pattern-etc;

    has $.text;

    method gist {

        my $builder = "";

        $builder ~= @.struct-pattern-fields>>.gist.join(", ");

        if $.maybe-struct-pattern-etc {
            $builder ~= ", " ~ $_.gist;
        }

        $builder
    }
}

class StructPatternField is export {
    has @.outer-attributes;
    has $.struct-pattern-field-variant;

    has $.text;

    method gist {

        my $builder = "";

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= $.struct-pattern-field-variant.gist;

        $builder
    }
}

class StructPatternFieldVariantTuple is export {
    has $.tuple-index;
    has $.pattern;

    has $.text;

    method gist {
        $.tuple-index.gist ~ ":" ~ $.pattern.gist
    }
}

class StructPatternFieldVariantId is export {
    has $.identifier;
    has $.pattern;

    has $.text;

    method gist {
        $.identifier.gist ~ ":" ~ $.pattern.gist
    }
}

class StructPatternFieldVariantRefMutId is export {
    has Bool $.ref;
    has Bool $.mutable;
    has $.identifier;

    has $.text;

    method gist {

        my $builder = "";

        if $.ref {
            $builder ~= "ref ";
        }

        if $.mutable {
            $builder ~= "mut ";
        }

        $builder ~= $.identifier.gist;

        $builder
    }
}

class StructPatternEtCetera is export {
    has @.outer-attributes;

    has $.text;

    method gist {
        my $builder = "";

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= "..";

        $builder
    }
}

package StructPatternGrammar is export {

    our role Rules {

        rule struct-pattern {
            <path-in-expression> 
            <tok-lbrace> 
            <struct-pattern-elements>? 
            <tok-rbrace>
        }

        proto rule struct-pattern-elements { * }

        rule struct-pattern-elements:sym<basic> {
            <struct-pattern-fields>
            [
                <tok-comma> <struct-pattern-et-cetera>?
            ]?
        }

        rule struct-pattern-elements:sym<etc> {
            <struct-pattern-et-cetera>
        }

        rule struct-pattern-fields {
            <struct-pattern-field>+ %% <tok-comma>
        }

        rule struct-pattern-field {
            <outer-attribute>*
            <struct-pattern-field-variant>
        }

        proto rule struct-pattern-field-variant { * }

        rule struct-pattern-field-variant:sym<tup> {
            <tuple-index> <tok-colon> <pattern>
        }

        rule struct-pattern-field-variant:sym<id> {
            <identifier> <tok-colon> <pattern>
        }

        rule struct-pattern-field-variant:sym<ref-mut-id> {
            <kw-ref>? <kw-mut>? <identifier>
        }

        rule struct-pattern-et-cetera {
            <outer-attribute>*
            <tok-dotdot>
        }
    }

    our role Actions {

        method struct-pattern($/) {
            make StructPattern.new(
                path-in-expression            => $<path-in-expression>.made,
                maybe-struct-pattern-elements => $<struct-pattern-elements>.made,
                text                          => $/.Str,
            )
        }

        method struct-pattern-elements:sym<basic>($/) {
            make StructPatternElementsBasic.new(
                struct-pattern-fields    => $<struct-pattern-fields>.made,
                maybe-struct-pattern-etc => $<struct-pattern-et-cetera>.made,
                text                     => $/.Str,
            )
        }

        method struct-pattern-elements:sym<etc>($/) {
            make $<struct-pattern-et-cetera>.made
        }

        method struct-pattern-fields($/) {
            make $<struct-pattern-field>>>.made
        }

        method struct-pattern-field($/) {
            make StructPatternField.new(
                outer-attributes             => $<outer-attribute>>>.made,
                struct-pattern-field-variant => $<struct-pattern-field-variant>.made,
                text                         => $/.Str,
            )
        }

        method struct-pattern-field-variant:sym<tup>($/) {
            make StructPatternFieldVariantTuple.new(
                tuple-index => $<tuple-index>.made,
                pattern     => $<pattern>.made,
                text        => $/.Str,
            )
        }

        method struct-pattern-field-variant:sym<id>($/) {
            make StructPatternFieldVariantId.new(
                identifier => $<identifier>.made,
                pattern    => $<pattern>.made,
                text       => $/.Str,
            )
        }

        method struct-pattern-field-variant:sym<ref-mut-id>($/) {
            make StructPatternFieldVariantRefMutId.new(
                ref        => so $/<kw-ref>:exists,
                mutable    => so $/<kw-mut>:exists,
                identifier => $<identifier>.made,
                text       => $/.Str,
            )
        }

        method struct-pattern-et-cetera($/) {
            make StructPatternEtCetera.new(
                outer-attributes => $<outer-attribute>>>.made,
                text             => $/.Str,
            )
        }
    }
}
