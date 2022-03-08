our role Attributes::Rules {

    token tok-shebang {
        <tok-pound>
        <tok-bang>
    }

    rule inner-attribute {
        <tok-shebang>
        <tok-lbrack>
        <attr>
        <tok-rbrack>
    }

    rule outer-attribute {
        <tok-pound>
        <tok-lbrack>
        <attr>
        <tok-rbrack>
    }

    rule attr {
        <simple-path>
        <attr-input>?
    }

    #-------------------
    proto rule attr-input { * }

    rule attr-input:sym<token-tree> {
        <delim-token-tree>
    }

    rule attr-input:sym<eq-expr> {
        <tok-eq>
        <expression>
    }
}
