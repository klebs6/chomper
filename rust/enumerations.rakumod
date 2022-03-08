our role Enumeration {

    rule enumertion {
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
        <enum-item-tuple>
    }

    rule enum-item-variant:sym<struct> {
        <enum-item-struct>
    }

    rule enum-item-variant:sym<discriminant> {
        <enum-item-discriminant>
    }

    #----------------
    rule enum-item-tuple {
        <tok-lparen>
        <tuple-fields>?
        <tok-rparen>
    }

    rule enum-item-struct {
        <tok-lbrace>
        <struct-fields>?
        <tok-rbrace>
    }

    rule enum-item-discriminant {
        <tok-eq> <expression>
    }
}
