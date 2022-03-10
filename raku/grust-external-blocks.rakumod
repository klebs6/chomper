our role ExternBlock::Rules {

    rule extern-block {
        <kw-unsafe>?
        <kw-extern>
        <abi>?
        <tok-lbrace>
        <inner-attribute>*
        <external-item>*
        <tok-rbrace>
    }

    rule external-item {
        <outer-attribute>*
        <external-item-variant>
    }

    proto rule external-item-variant { * }

    rule external-item-variant:sym<macro> {
        <macro-invocation-semi>
    }

    rule external-item-variant:sym<maybe-visible> {
        <visibility>?
        <maybe-visible-external-item-variant>
    }

    #-------------------
    proto rule maybe-visible-external-item-variant { * }

    rule maybe-visible-external-item-variant:sym<static> {
        <function>
    }

    rule maybe-visible-external-item-variant:sym<fn> {
        <static-item>
    }
}

our role ExternBlock::Actions {}
