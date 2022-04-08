use Data::Dump::Tree;

our class CrateItem {
    has $.maybe-comment;
    has @.outer-attributes;
    has $.item-variant;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-comment {
            $builder ~= $.maybe-comment.gist ~ "\n";
        }

        for @.outer-attributes {
            $builder ~= $_.gist ~ "\n";
        }

        $builder ~= $.item-variant.gist;

        $builder
    }
}

our class VisItem {
    has $.maybe-visibility;
    has $.vis-item-variant;

    has $.text;

    method gist {

        my $builder = "";

        if $.maybe-visibility {
            $builder ~= $.maybe-visibility.gist ~ " ";
        }

        $builder ~= $.vis-item-variant.gist;

        $builder
    }

    method is-public returns Bool {
        #TODO: check the "so" clause
        so $.maybe-visibility ?? True !! False
    }

    method maybe-item-name {
        if $.vis-item-variant.has-name() {
            return $.vis-item-variant.name();
        }
    }
}

our class InitExpression {
    has $.expression;

    has $.text;

    method gist {
        "= " ~ $.expression.gist
    }
}

our class ConstantItem {
    has $.identifier-or-underscore;
    has $.type;
    has $.maybe-init-expression;

    has $.text;

    method has-name {
        True
    }

    method name {
        $.identifier-or-underscore.gist
    }

    method gist {

        my $builder = "";

        $builder ~= "const " ~ $.identifier-or-underscore.gist;

        $builder ~= ": " ~ $.type.gist;

        if $.maybe-init-expression {
            $builder ~= $.maybe-init-expression.gist;
        }

        $builder ~= ";";

        $builder
    }
}

our class StaticItem {
    has Bool $.mutable;
    has $.identifier;
    has $.type;
    has $.maybe-init-expression;

    has $.text;

    method has-name {
        True
    }

    method name {
        $.identifier.gist
    }

    method gist {
        my $builder = "";

        $builder ~= "static ";

        if $.mutable {
            $builder ~= "mut ";
        }

        $builder ~= $.identifier.gist;

        $builder ~= ": " ~ $.type.gist;

        if $.maybe-init-expression {
            $builder ~= $.maybe-init-expression.gist;
        }

        $builder ~= ";";

        $builder
    }
}

our role Item::Rules {

    proto rule crate-item { * }

    rule crate-item:sym<item> {
        <comment>?
        <outer-attribute>*
        <item-variant>
    }

    rule crate-item:sym<comment> {
        <comment>
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

our role Item::Actions {

    method crate-item:sym<item>($/) {
        make CrateItem.new(
            maybe-comment    => $<comment>.made,
            outer-attributes => $<outer-attribute>>>.made,
            item-variant     => $<item-variant>.made,
            text             => $/.Str,
        )
    }

    method crate-item:sym<comment>($/) {
        make $<comment>.made
    }

    method item-variant:sym<vis>($/)   { make $<vis-item>.made }
    method item-variant:sym<macro>($/) { make $<macro-item>.made }

    method vis-item($/) {
        make VisItem.new(
            maybe-visibility => $<visibility>.made,
            vis-item-variant => $<vis-item-variant>.made,
            text             => $/.Str,
        )
    }

    method vis-item-variant:sym<module>($/)           { make $<module>.made }
    method vis-item-variant:sym<extern-crate>($/)     { make $<extern-crate>.made }
    method vis-item-variant:sym<use-declaration>($/)  { make $<use-declaration>.made }
    method vis-item-variant:sym<function>($/)         { make $<function>.made }
    method vis-item-variant:sym<type-alias>($/)       { make $<type-alias>.made }
    method vis-item-variant:sym<struct>($/)           { make $<struct>.made }
    method vis-item-variant:sym<enumeration>($/)      { make $<enumeration>.made }
    method vis-item-variant:sym<union>($/)            { make $<union>.made }
    method vis-item-variant:sym<constant-item>($/)    { make $<constant-item>.made }
    method vis-item-variant:sym<static-item>($/)      { make $<static-item>.made }
    method vis-item-variant:sym<trait>($/)            { make $<trait>.made }
    method vis-item-variant:sym<trait-alias>($/)      { make $<trait-alias>.made }
    method vis-item-variant:sym<implementation>($/)   { make $<implementation>.made }
    method vis-item-variant:sym<extern-block>($/)     { make $<extern-block>.made }

    method macro-item:sym<macro-invocation>($/)       { make $<macro-invocation>.made }
    method macro-item:sym<macro-rules-definition>($/) { make $<macro-rules-definition>.made }

    method init-expression($/) {
        make InitExpression.new(
            expression => $<expression>.made,
            text       => $/.Str,
        )
    }

    method constant-item($/) {
        make ConstantItem.new(
            identifier-or-underscore => $<identifier-or-underscore>.made,
            type                     => $<type>.made,
            maybe-init-expression    => $<init-expression>.made,
            text                     => $/.Str,
        )
    }

    method static-item($/) {
        make StaticItem.new(
            mutable               => so $/<kw-mut>:exists,
            identifier            => $<identifier>.made,
            type                  => $<type>.made,
            maybe-init-expression => $<init-expression>.made,
            text                  => $/.Str,
        )
    }
}
