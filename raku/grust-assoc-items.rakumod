our class AssociatedItem {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.variant;

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

our class AssociatedItemMacro {
    has $.macro-invocation;

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

our class AssociatedItemTypeAlias {
    has $.maybe-visibility
    has $.type-alias;

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

our class AssociatedItemConstantItem {
    has $.maybe-visibility
    has $.constant-item;

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

our class AssociatedItemFunction {
    has $.maybe-visibility
    has $.function;

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

    method associated-item($/) {
        make AssociatedItem.new(
            maybe-comment    => $<comment>.made,
            outer-attributes => $<outer-attributes>>.made,
            variant          => $<associated-item-variant>.made,
            text => $/.Str,
        )
    }

    #---------------------
    method associated-item-variant:sym<macro>($/) {
        make AssociatedItemMacro.new(
            macro-invocation => $<macro-invocation>.made
            text => $/.Str,
        )
    }

    method associated-item-variant:sym<type-alias>($/) { 
        make AssociatedItemTypeAlias.new(
            maybe-visibility => $<visibility>.made,
            type-alias       => $<type-alias>.made,
            text => $/.Str,
        )
    }

    method associated-item-variant:sym<constant-item>($/) { 
        make AssociatedItemConstantItem.new(
            maybe-visibility => $<visibility>.made,
            constant-item    => $<constant-item>.made,
            text => $/.Str,
        )
    }

    method associated-item-variant:sym<fn>($/) { 
        make AssociatedItemConstantItem.new(
            maybe-visibility => $<visibility>.made,
            function         => $<function>.made,
            text => $/.Str,
        )
    }
}
