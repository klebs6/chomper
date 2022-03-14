our class ReferencePatternRef {
    has Bool $.mutable;
    has $.pattern-without-range;

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

our class ReferencePatternRefRef {
    has Bool $.mutable;
    has $.pattern-without-range;

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

our role ReferencePattern::Rules {

    proto rule reference-pattern { * }

    rule reference-pattern:sym<ref>    { <tok-and> <kw-mut>? <pattern-without-range> }
    rule reference-pattern:sym<refref> { <tok-andand> <kw-mut>? <pattern-without-range> }
}

our role ReferencePattern::Actions {}
