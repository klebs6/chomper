our class CrateItem {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.item-variant;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class VisItem {
    has $.maybe-visibility;
    has $.vis-item-variant;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class InitExpression {
    has $.expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class ConstantItem {
    has $.identifier-or-underscore;
    has $.type;
    has $.maybe-init-expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class StaticItem {
    has Bool $.mut;
    has $.identifier;
    has $.type;
    has $.maybe-init-expression;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role Item::Rules {

    rule crate-item {
        <comment>?
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
    rule vis-item-variant:sym<trait-alias>     { <trait-alias> }
    rule vis-item-variant:sym<implementation>  { <implementation> }
    rule vis-item-variant:sym<extern-block>    { <extern-block> }

    proto rule macro-item { * }
    rule macro-item:sym<macro-invocation>       { <macro-invocation> }
    rule macro-item:sym<macro-rules-definition> { <macro-rules-definition> }

    rule init-expression {
        <tok-eq>
        <expression>
    }

    rule constant-item {
        <kw-const> 
        <identifier-or-underscore> 
        <tok-colon> 
        <type> 
        <init-expression>?
        <tok-semi>
    }

    rule static-item {
        <kw-static>
        <kw-mut>?
        <identifier>
        <tok-colon>
        <type>
        <init-expression>?
        <tok-semi>
    }
}

our role Item::Actions {}
