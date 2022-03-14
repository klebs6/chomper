our class StructPattern {
    has $.path-in-expression;
    has $.maybe-struct-pattern-elements;

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

our class StructPatternElementsBasic {
    has @.struct-pattern-fields;
    has $.maybe-struct-pattern-etc;

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

our class StructPatternElementsEtc {

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

our cass StructPatternField {
    has @.outer-attributes;
    has $.struct-pattern-field-variant;

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

our class StructPatternFieldVariantTuple {
    has $.tuple-index;
    has $.pattern;

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

our class StructPatternFieldVariantId {
    has $.identifier;
    has $.pattern;

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

our class StructPatternFieldVariantRefMutId {
    has Bool $.ref;
    has Bool $.mutable;
    has $.identifier;

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

our class StructPatternEtCetera {
    has @.outer-attributes;

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

our role StructPattern::Rules {

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

our role StructPattern::Actions {}
