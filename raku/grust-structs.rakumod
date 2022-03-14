our class Struct {
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-where-clause;
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

our class TupleStruct {
    has $.identifier;
    has $.maybe-generic-params;
    has @.maybe-tuple-fields;
    has $.maybe-where-clause;

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

our class StructField {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.maybe-visibility;
    has $.identifier;
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

our class TupleField {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.maybe-visibility;
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

our role Struct::Actions {}
