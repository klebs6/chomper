our role CfgAttr::Rules {

    proto rule cfg-attr-attribute { * }

    rule cfg-attr-attribute:sym<cfg> {
        <kw-cfg> 
        <tok-lparen> 
        <configuration-predicate>
        <tok-rparen> 
    }

    rule cfg-attr-attribute:sym<cfg-attr> {
        <kw-cfg-attr> 
        <tok-lparen> 
        <configuration-predicate>
        <tok-comma>
        <cfg-attrs>?
        <tok-rparen> 
    }

    rule cfg-attrs {
        <attr>+ %% <tok-comma>
    }

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
