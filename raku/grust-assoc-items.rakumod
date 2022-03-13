our role AssociatedItem::Rules {

    rule associated-item {
        <comment>?
        <outer-attribute>*
        <associated-item-variant>
    }

    #---------------------
    proto rule associated-item-variant { * }

    rule associated-item-variant:sym<macro> {
        <macro-invocation>
    }

    rule associated-item-variant:sym<type-alias>    { <visibility>? <type-alias> }
    rule associated-item-variant:sym<constant-item> { <visibility>? <constant-item> }
    rule associated-item-variant:sym<fn>            { <visibility>? <function> }
}

our role AssociatedItem::Actions {

}
