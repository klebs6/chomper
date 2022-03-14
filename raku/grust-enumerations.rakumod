
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

our role Enumeration::Actions {}
