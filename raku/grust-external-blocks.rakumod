use Data::Dump::Tree;

our class ExternBlock {
    has Bool $.unsafe;
    has $.maybe-abi;
    has @.inner-attributes;
    has @.external-items;

    has $.text;

    method gist {

        my $builder;

        if $.unsafe {
            $builder ~= "unsafe ";
        }

        $builder ~= "extern ";

        if $.maybe-abi {
            $builder ~= $_.gist;
        }

        $builder ~= "{\n";

        for @.inner-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        for @.external-items {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= "\n}";

        $builder 
    }
}

our class ExternalItem {
    has @.outer-attributes;
    has $.external-item-variant;

    has $.text;

    method gist {

        my $builder = "";

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= $.external-item-variant.gist;

        $builder
    }
}

our class ExternalItemMacroInvocation {
    has $.macro-invocation;

    has $.text;

    method gist {
        $.macro-invocation.gist
    }
}

our class ExternalItemFn {
    has $.maybe-visibility;
    has $.function;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-visibility {
            $builder ~= $.maybe-visibility.gist ~ " ";
        }

        $builder ~= $.function.gist;

        $builder
    }
}

our class ExternalItemStatic {
    has $.maybe-visibility;
    has $.static-item;

    has $.text;

    method gist {

        if $.maybe-visibility {

            $.maybe-visibility.gist ~ " " ~ $.static-item.gist

        } else {

            $.static-item.gist
        }
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
            text             => $/.Str,
        )
    }

    method external-item($/) {
        make ExternalItem.new(
            outer-attributes      => $<outer-attribute>>>.made,
            external-item-variant => $<external-item-variant>.made,
            text                  => $/.Str,
        )
    }

    method external-item-variant:sym<macro>($/) {
        make ExternalItemMacroInvocation.new(
            macro-invocation => $<macro-invocation>.made,
            text             => $/.Str,
        )
    }

    method external-item-variant:sym<fn>($/) {
        make ExternalItemFn.new(
            maybe-visibility => $<visibility>.made,
            function         => $<function>.made,
            text             => $/.Str,
        )
    }

    method external-item-variant:sym<static>($/) {
        make ExternalItemStatic.new(
            maybe-visibility => $<visibility>.made,
            static-item      => $<static-item>.made,
            text             => $/.Str,
        )
    }
}
