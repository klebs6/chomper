our role Item::Rules {

    rule item {
        <outer-attribute>*
        <item-variant>
    }

    proto rule item-variant { * }
    rule item-variant:sym<vis>   { <vis-item> }
    rule item-variant:sym<macro> { <macro-item> }

    rule vis-item {
        <visibility>?
        <vis-item-variant>
    }

    proto rule vis-item-variant { * }

    rule vis-item-variant:sym<module>          { <module> }
    rule vis-item-variant:sym<extern-crate>    { <extern-crate> }
    rule vis-item-variant:sym<use-declaration> { <use-declaration> }
    rule vis-item-variant:sym<function>        { <function> }
    rule vis-item-variant:sym<type-alias>      { <type-alias> }
    rule vis-item-variant:sym<struct>          { <struct> }
    rule vis-item-variant:sym<enumeration>     { <enumeration> }
    rule vis-item-variant:sym<union>           { <union> }
    rule vis-item-variant:sym<constant-item>   { <constant-item> }
    rule vis-item-variant:sym<static-item>     { <static-item> }
    rule vis-item-variant:sym<trait>           { <trait> }
    rule vis-item-variant:sym<implementation>  { <implementation> }
    rule vis-item-variant:sym<extern-block>    { <extern-block> }

    proto rule macro-item { * }
    rule macro-item:sym<macro-invocation-semi>  { <macro-invocation-semi> }
    rule macro-item:sym<macro-rules-definition> { <macro-rules-definition> }
}

our role Item::Actions {}
