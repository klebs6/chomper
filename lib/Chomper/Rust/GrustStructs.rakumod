use Data::Dump::Tree;
use grust-comment;

our class Struct {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has @.maybe-struct-fields;
    has @.maybe-inner-trailing-comments;

    has $.text;

    method has-name {
        True
    }

    method name {
        $.identifier.gist
    }

    method gist {

        my $builder = "struct " ~ $.identifier.gist;

        if $.maybe-generic-params {
            $builder ~= $.maybe-generic-params.gist;
        }

        if $.maybe-where-clause {
            $builder ~= $.maybe-where-clause.gist;
        }

        if @.maybe-struct-fields.elems gt 0 {

            $builder ~= '{';
            $builder ~= @.maybe-struct-fields>>.gist.join(",\n").indent(4);

            if @.maybe-inner-trailing-comments {
                $builder ~= @.maybe-inner-trailing-comments.gist.indent(4);
            }

            $builder ~= '}';

        } else {
            $builder ~= ";";
        }

        $builder
    }
}

our class TupleStruct {
    has $.identifier;
    has $.maybe-generic-params;
    has @.maybe-tuple-fields;
    has $.maybe-where-clause;

    has $.text;

    method has-name {
        True
    }

    method name {
        $.identifier.gist
    }

    method gist {

        my $builder = "struct " ~ $.identifier.gist;

        if $.maybe-generic-params {
            $builder ~= $.maybe-generic-params.gist;
        }

        $builder ~= "(";

        for @.maybe-tuple-fields {
            $builder ~= $_.gist ~ ", ";
        }

        $builder ~= ")";

        if $.maybe-where-clause {
            $builder ~= $.maybe-where-clause.gist;
        }

        $builder ~ ";"
    }
}

our class StructField {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.maybe-visibility;
    has $.identifier;
    has $.type;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist;
        }

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        if $.maybe-visibility {
            $builder ~= $.maybe-visibility.gist ~ " ";
        }

        $builder ~= $.identifier.gist;
        $builder ~= ":";
        $builder ~= $.type.gist;

        $builder
    }
}

our class StructFieldItem {
    has StructField $.struct-field       is required;
    has Bool        $.has-trailing-comma is required;
    has             $.maybe-trailing-comment;

    has $.text;

    method gist {

        my $builder = $.struct-field.gist;

        if $.has-trailing-comma {
            $builder ~= ",";
        }

        if $.maybe-trailing-comment {
            $builder ~= " " ~ $.maybe-trailing-comment.gist;
        }

        $builder
    }
}

our class TupleField {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.maybe-visibility;
    has $.type;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist;
        }

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        if $.maybe-visibility {
            $builder ~= $.maybe-visibility.gist ~ " ";
        }

        $builder ~ $.type.gist
    }
}

our role Struct::Rules {

    proto rule struct { * }
    rule struct:sym<struct> { <struct-struct> }
    rule struct:sym<tuple>  { <tuple-struct> }

    rule struct-struct {
        <kw-struct> 
        <identifier> 
        <generic-params>?
        <where-clause>?
        [
            | <tok-semi>
            | <tok-lbrace> <struct-fields>? <comment>* <tok-rbrace>
        ]
    }

    rule tuple-struct {
        <kw-struct>
        <identifier>
        <generic-params>?
        <tok-lparen>
        <tuple-fields>?
        <tok-rparen>
        <where-clause>?
        <tok-semi>
    }

    regex struct-fields {
        [<inner-struct-field-item>* % <.ws>]
        <.ws>
        <outer-struct-field-item>
    }

    regex inner-struct-field-item {
        <struct-field> \h* <tok-comma>  \h* <line-comment>?
    }

    regex outer-struct-field-item {
        <struct-field> \h* <tok-comma>? \h* <line-comment>?
    }

    rule struct-field {
        <comment>?
        <outer-attribute>*
        <visibility>?
        <identifier>
        <tok-colon>
        <type>
    }

    rule tuple-fields {
        <tuple-field>+ %% <tok-comma>
    }

    rule tuple-field {
        <comment>?
        <outer-attribute>*
        <visibility>?
        <type>
    }
}

our role Struct::Actions {

    method struct:sym<struct>($/) { make $<struct-struct>.made }
    method struct:sym<tuple>($/)  { make $<tuple-struct>.made }

    method struct-struct($/) {
        make Struct.new(
            identifier                   => $<identifier>.made,
            maybe-generic-params         => $<generic-params>.made,
            maybe-where-clause           => $<where-clause>.made,
            maybe-struct-fields          => $<struct-fields>.made,
            maybe-inner-trailing-comments => $<comment>>>.made,
            text                         => $/.Str,
        )
    }

    method tuple-struct($/) {
        make TupleStruct.new(
            identifier           => $<identifier>.made,
            maybe-generic-params => $<generic-params>.made,
            maybe-tuple-fields   => $<tuple-fields>.made,
            maybe-where-clause   => $<where-clause>.made,
            text                 => $/.Str,
        )
    }

    method inner-struct-field-item($/) {
        make StructFieldItem.new(
            struct-field           => $<struct-field>.made,
            has-trailing-comma     => $/<comma>:exists,
            maybe-trailing-comment => Comment.new(
                text => $<line-comment>.made,
                line => True,
            ),
        )
    }

    method outer-struct-field-item($/) {
        make StructFieldItem.new(
            struct-field           => $<struct-field>.made,
            has-trailing-comma     => $/<comma>:exists,
            maybe-trailing-comment => Comment.new(
                text => $<line-comment>.made,
                line => True,
            ),
        )
    }

    method struct-fields($/) {
        my @inner = $<inner-struct-field-item>>>.made;
        my $outer = $<outer-struct-field-item>.made;
        make [|@inner, $outer]
    }

    method struct-field($/) {
        make StructField.new(
            maybe-comment    => $<comment>.made,
            outer-attributes => $<outer-attribute>>>.made,
            maybe-visibility => $<visibility>.made,
            identifier       => $<identifier>.made,
            type             => $<type>.made,
            text             => $/.Str,
        )
    }

    method tuple-fields($/) {
        make $<tuple-field>>>.made
    }

    method tuple-field($/) {
        make TupleField.new(
            maybe-comment    => $<comment>.made,
            outer-attributes => $<outer-attribute>>>.made,
            maybe-visibility => $<visibility>.made,
            type             => $<type>.made,
            text             => $/.Str,
        )
    }
}
