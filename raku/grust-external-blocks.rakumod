our class ExternBlock {
    has Bool $.unsafe;
    has $.maybe-abi;
    has @.inner-attributes;
    has @.external-items;

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

our class ExternalItem {
    has @.outer-attributes;
    has $.external-item-variant;

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

our class ExternalItemMacroInvocation {
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

our class ExternalItemFn {
    has $.maybe-visibility;
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

our class ExternalItemStatic {
    has $.maybe-visibility;
    has $.static-item;

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
        <macro-invocation>
    }

    rule external-item-variant:sym<fn> {
        <visibility>?
        <function>
    }

    rule external-item-variant:sym<static> {
        <visibility>?
        <static-item>
    }
}

our role ExternBlock::Actions {

    method extern-block($/) {
        make ExternBlock.new(
            unsafe           => so $/<kw-unsafe>:exists,
            maybe-abi        => $<abi>.made,
            inner-attributes => $<inner-attribute>>>.made,
            external-items   => $<external-item>>>.made,
            text       => $/.Str,
        )
    }

    method external-item($/) {
        make ExternalItem.new(
            outer-attributes      => $<outer-attribute>>>.made,
            external-item-variant => $<external-item-variant>.made,
            text       => $/.Str,
        )
    }

    method external-item-variant:sym<macro>($/) {
        make ExternalItemMacroInvocation.new(
            macro-invocation => $<macro-invocation>.made
            text       => $/.Str,
        )
    }

    method external-item-variant:sym<fn>($/) {
        make ExternalItemFn.new(
            maybe-visibility => $<visibility>.made,
            function         => $<function>.made,
            text       => $/.Str,
        )
    }

    method external-item-variant:sym<static>($/) {
        make ExternalItemStatic.new(
            maybe-visibility => $<visibility>.made,
            static-item      => $<static-item>.made,
            text       => $/.Str,
        )
    }
}
