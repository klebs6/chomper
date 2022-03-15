our class Enumeration {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
    has @.maybe-enum-items;

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

our class EnumItem {
    has @.outer-attributes;
    has @.maybe-visibility;
    has $.identifier;
    has $.maybe-enum-variant;

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

our class EnumVariantTuple {
    has @.maybe-tuple-fields;

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

our class EnumVariantStruct {
    has @.maybe-struct-fields;

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

our class EnumVariantDiscriminant {
    has $.eq-expression;

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
            text => $/.Str,
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
            text => $/.Str,
        )
    }

    #----------------
    method enum-item-variant:sym<tuple>($/) {
        make EnumVariantTuple.new(
            maybe-tuple-fields => $<tuple-fields>.made,
            text => $/.Str,
        )
    }

    method enum-item-variant:sym<struct>($/) {
        make EnumVariantStruct.new(
            struct-fields => $<struct-fields>.made,
            text => $/.Str,
        )
    }

    method enum-item-variant:sym<discriminant>($/) {
        make EnumVariantDiscriminant.new(
            eq-expression => $<expression>.made,
            text => $/.Str,
        )
    }
}
