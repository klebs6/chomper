our role Crate::Rules {

    rule crate {
        <utf8-bom>?
        <shebang>?
        <inner-attribute>*
        <item>*
    }

    token utf8-bom {
        \uFEFF
    }

    token shebang {
        <tok-shebang> \N+
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
    rule crate-ref:sym<self> { <kw-self> }
}
