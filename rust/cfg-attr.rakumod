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
}
