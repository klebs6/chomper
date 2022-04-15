unit module Chomper::Rust::GrustAssocItems;

use Data::Dump::Tree;

class AssociatedItem is export {
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

class AssociatedMacro is export {
    has $.macro-invocation;

    has $.text;

    method gist {
        $.macro-invocation.gist
    }
}

class AssociatedTypeAlias is export {
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

class AssociatedConstantItem is export {
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

class AssociatedFunction is export {
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

package AssociatedItemGrammar is export {

    our role Rules {

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

    our role Actions {

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
            make AssociatedMacro.new(
                macro-invocation => $<macro-invocation>.made,
                text             => $/.Str,
            )
        }

        method associated-item-variant:sym<type-alias>($/) { 
            make AssociatedTypeAlias.new(
                maybe-visibility => $<visibility>.made,
                type-alias       => $<type-alias>.made,
                text             => $/.Str,
            )
        }

        method associated-item-variant:sym<constant-item>($/) { 
            make AssociatedConstantItem.new(
                maybe-visibility => $<visibility>.made,
                constant-item    => $<constant-item>.made,
                text             => $/.Str,
            )
        }

        method associated-item-variant:sym<fn>($/) { 
            make AssociatedFunction.new(
                maybe-visibility => $<visibility>.made,
                function         => $<function>.made,
                text             => $/.Str,
            )
        }
    }
}
