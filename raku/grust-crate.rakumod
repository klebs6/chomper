our role Crate::Rules {

    rule crate {
        <utf8-bom>?
        <shebang>?
        <inner-attribute>*
        <crate-item>*
    }

    token utf8-bom {
        \x[FEFF]
    }

    token shebang {
        <tok-shebang> \N+
    }

    rule as-clause {
        <kw-as>
        <identifier-or-underscore>
    }

    rule extern-crate {
        <kw-extern>
        <kw-crate>
        <crate-ref>
        <as-clause>?
        <tok-semi>
    }

    proto rule crate-ref { * }

    rule crate-ref:sym<id>   { <identifier> }
    rule crate-ref:sym<self> { <kw-selfvalue> }

    #-------------------------
    proto rule module { * }

    rule module:sym<semi> {
        <kw-unsafe>? 
        <kw-mod> 
        <identifier> 
        <tok-semi>
    }

    rule module:sym<block> {
        <kw-unsafe>?
        <kw-mod>
        <identifier>
        <tok-lbrace>
        <inner-attribute>*
        <crate-item>*
        <tok-rbrace>
    }
}

our role Crate::Actions {}
