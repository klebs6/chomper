use Data::Dump::Tree;

our class Struct {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has @.maybe-struct-fields;

    has $.text;

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
            $builder ~= @.maybe-struct-fields>>.gist.join("\n").indent(4);
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
            $builder ~= $maybe-visibility.gist ~ " ";
        }

        $builder ~= $.identifier.gist;
        $builder ~= ":";
        $builder ~= $.type.gist;

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
            $builder ~= $maybe-comment.gist;
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
            | <tok-lbrace> <struct-fields>? <tok-rbrace>
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

    rule struct-fields {
        <struct-field>+ %% <tok-comma>
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
            identifier           => $<identifier>.made,
            maybe-generic-params => $<generic-params>.made,
            maybe-where-clause   => $<where-clause>.made,
            maybe-struct-fields  => $<struct-fields>.made,
            text                 => $/.Str,
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

    method struct-fields($/) {
        make $<struct-field>>>.made
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
