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
