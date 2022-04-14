use Data::Dump::Tree;

our class AssociatedItem {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.variant;

    has $.text;

    method gist {
        if $.maybe-comment {
            qq:to/END/.chomp.trim
            {$.maybe-comment.gist}
            {@.outer-attributes>>.gist.join("\n")}
            {$.variant.gist}
            END
        } else {
            qq:to/END/.chomp.trim
            {@.outer-attributes>>.gist.join("\n")}
            {$.variant.gist}
            END
        }
    }
}

our class AssociatedItemMacro {
    has $.macro-invocation;

    has $.text;

    method gist {
        $.macro-invocation.gist
    }
}

our class AssociatedItemTypeAlias {
    has $.maybe-visibility;
    has $.type-alias;

    has $.text;

    method gist {
        if $.maybe-visibility {
            $.maybe-visibility.gist ~ " " ~ $.type-alias.gist
        } else {
            $.type-alias.gist
        }
    }
}

our class AssociatedItemConstantItem {
    has $.maybe-visibility;
    has $.constant-item;

    has $.text;

    method gist {
        if $.maybe-visibility {
            $.maybe-visibility.gist ~ " " ~ $.constant-item.gist
        } else {
            $.constant-item.gist
        }
    }
}

our class AssociatedItemFunction {
    has $.maybe-visibility;
    has $.function;

    has $.text;

    method gist {
        if $.maybe-visibility {
            $.maybe-visibility.gist ~ " " ~ $.function.gist
        } else {
            $.function.gist
        }
    }
}

our role AssociatedItem::Rules {

    proto rule associated-item { * }

    rule associated-item:sym<basic> {
        <comment>?
        <outer-attribute>*
        <associated-item-variant>
    }

    rule associated-item:sym<block-comment> {
        <block-comment>
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

    method associated-item:sym<basic>($/) {
        make AssociatedItem.new(
            maybe-comment    => $<comment>.made,
            outer-attributes => $<outer-attribute>>>.made,
            variant          => $<associated-item-variant>.made,
            text             => $/.Str,
        )
    }

    method associated-item:sym<block-comment>($/) {
        make $<block-comment>.made
    }

    #---------------------
    method associated-item-variant:sym<macro>($/) {
        make AssociatedItemMacro.new(
            macro-invocation => $<macro-invocation>.made,
            text             => $/.Str,
        )
    }

    method associated-item-variant:sym<type-alias>($/) { 
        make AssociatedItemTypeAlias.new(
            maybe-visibility => $<visibility>.made,
            type-alias       => $<type-alias>.made,
            text             => $/.Str,
        )
    }

    method associated-item-variant:sym<constant-item>($/) { 
        make AssociatedItemConstantItem.new(
            maybe-visibility => $<visibility>.made,
            constant-item    => $<constant-item>.made,
            text             => $/.Str,
        )
    }

    method associated-item-variant:sym<fn>($/) { 
        make AssociatedItemFunction.new(
            maybe-visibility => $<visibility>.made,
            function         => $<function>.made,
            text             => $/.Str,
        )
    }
}
