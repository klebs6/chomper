use Data::Dump::Tree;

our class Enumeration {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has @.maybe-enum-items;

    has $.text;

    method gist {

        my $builder = "enum " ~ $.identifier.gist;

        if $.maybe-generic-params {
            $builder ~= $.maybe-generic-params.gist;
        }

        if $.maybe-where-clause {
            $builder ~= $.maybe-where-clause.gist;
        }

        $builder ~= "\{\n";

        for @.maybe-enum-items {
            my $item = $_.gist ~ ",\n";
            $builder ~= $item.indent(4);
        }

        $builder ~= "\n\}";
    }
}

our class EnumItem {
    has @.outer-attributes;
    has $.maybe-visibility;
    has $.identifier;
    has $.maybe-enum-variant;

    has $.text;

    method gist {

        my $builder = "";

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        if $.maybe-visibility {
            $builder ~= $.maybe-visibility.gist;
        }

        $builder ~= $.identifier.gist;

        if $.maybe-enum-variant {
            $builder ~= $.maybe-enum-variant.gist;
        }
    }
}

our class EnumVariantTuple {
    has $.maybe-tuple-fields;

    has $.text;

    method gist {

        if $.maybe-tuple-fields {

            "(" 
            ~ $.maybe-tuple-fields.List>>.gist.join(",") 
            ~ ")"

        } else {

            "(" ~ ")"
        }
    }
}

our class EnumVariantStruct {
    has $.maybe-struct-fields;

    has $.text;

    method gist {
        if $.maybe-struct-fields {

            "{" 
            ~ $.maybe-tuple-fields.List>>.gist.join(",") 
            ~ "}"

        } else {

            "{" ~ "}"
        }
    }
}

our class EnumVariantDiscriminant {
    has $.eq-expression;

    has $.text;

    method gist {
        "= " ~ $.eq-expression.gist
    }
}

our role Enumeration::Rules {

    rule enumeration {
        <kw-enum> 
        <identifier> 
        <generic-params>? 
        <where-clause>? 
        <tok-lbrace> 
        <enum-items>? 
        <tok-rbrace>
    }

    rule enum-items {
        <enum-item>+ %% <tok-comma>
    }

    rule enum-item {
        <outer-attribute>*
        <visibility>?
        <identifier>
        <enum-item-variant>?
    }

    #----------------
    proto rule enum-item-variant { * }

    rule enum-item-variant:sym<tuple> {
        <tok-lparen>
        <tuple-fields>?
        <tok-rparen>
    }

    rule enum-item-variant:sym<struct> {
        <tok-lbrace>
        <struct-fields>?
        <tok-rbrace>
    }

    rule enum-item-variant:sym<discriminant> {
        <tok-eq> <expression>
    }
}

our role Enumeration::Actions {

    method enumeration($/) {
        make Enumeration.new(
            identifier           => $<identifier>.made,
            maybe-generic-params => $<generic-params>.made,
            maybe-where-clause   => $<where-clause>.made,
            maybe-enum-items     => $<enum-items>.made,
            text                 => $/.Str,
        )
    }

    method enum-items($/) {
        make $<enum-item>>>.made
    }

    method enum-item($/) {
        make EnumItem.new(
            outer-attributes        => $<outer-attribute>>>.made,
            maybe-visibility        => $<visibility>.made,
            identifier              => $<identifier>.made,
            maybe-enum-item-variant => $<enum-item-variant>.made,
            text                    => $/.Str,
        )
    }

    #----------------
    method enum-item-variant:sym<tuple>($/) {
        make EnumVariantTuple.new(
            maybe-tuple-fields => $<tuple-fields>.made,
            text               => $/.Str,
        )
    }

    method enum-item-variant:sym<struct>($/) {
        make EnumVariantStruct.new(
            struct-fields => $<struct-fields>.made,
            text          => $/.Str,
        )
    }

    method enum-item-variant:sym<discriminant>($/) {
        make EnumVariantDiscriminant.new(
            eq-expression => $<expression>.made,
            text          => $/.Str,
        )
    }
}
