our role AssociatedItem::Rules {

    rule associated-item {
        <outer-attribute>*
        <associated-item-variant>
    }

    #---------------------
    proto rule associated-item-variant { * }

    rule associated-item-variant:sym<macro> {
        <macro-invocation-semi>
    }

    rule associated-item-variant:sym<maybe-visible> {
        <visibility>?
        <maybe-visible-associated-item-variant>
    }

    #---------------------
    proto rule maybe-visible-associated-item-variant { * }

    rule maybe-visible-associated-item-variant:sym<type-alias> {
        <type-alias>
    }

    rule maybe-visible-associated-item-variant:sym<constant-item> {
        <constant-item>
    }

    rule maybe-visible-associated-item-variant:sym<fn> {
        <function>
    }
}

our role AssociatedItem::Actions {

}
