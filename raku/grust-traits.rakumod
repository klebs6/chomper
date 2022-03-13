use Data::Dump::Tree;

our role Trait::Rules {

    rule trait {
        <kw-unsafe>?
        <kw-trait>
        <identifier>
        <generic-params>?
        [ <tok-colon> <type-param-bounds>? ]?
        <where-clause>?
        <tok-lbrace>
        <inner-attribute>*
        <associated-item>*
        <comment>?
        <tok-rbrace>
    }

    proto rule implementation { * }
    rule implementation:sym<inherent> { <inherent-impl> }
    rule implementation:sym<trait>    { <trait-impl> }

    rule inherent-impl {
        <kw-impl>
        <generic-params>?
        <type>
        <where-clause>?
        <tok-lbrace>
        <inner-attribute>*
        <associated-item>*
        <comment>?
        <tok-rbrace>
    }

    rule trait-impl {
        <kw-unsafe>?
        <kw-impl>
        <generic-params>?
        <tok-bang>?
        <type-path>
        <kw-for>
        <type>
        <where-clause>?
        <tok-lbrace>
        <inner-attribute>*
        <associated-item>*
        <comment>?
        <tok-rbrace>
    }

    rule trait-alias {
        <outer-attribute>* 
        <visibility>? 
        <kw-trait> 
        <identifier>
        <generic-params>? 
        <tok-eq>
        <type-param-bounds> 
        <where-clause>?
        <tok-semi>
    }
}

our role Trait::Actions {}
