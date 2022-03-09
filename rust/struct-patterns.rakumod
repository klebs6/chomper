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
