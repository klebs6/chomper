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
