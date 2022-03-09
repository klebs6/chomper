use Data::Dump::Tree;

#------------------------------
# There are two forms of impl:
#
# impl (<...>)? TY { ... }
# impl (<...>)? TRAIT for TY { ... }
#
# Unfortunately since TY can begin with '<' itself
# -- as part of a TyQualifiedPath type -- there's
# an s/r conflict when we see '<' after IMPL:
#
# should we reduce one of the early rules of TY
# (such as maybe-once) or shall we continue
# shifting into the generic-params list for the
# impl?
#
# The production parser disambiguates a different
# case here by permitting / requiring the user to
# provide parens around types when they are
# ambiguous with traits. We do the same here,
# regrettably, by splitting ty into ty and
# ty-prim.
our class ImplItems {
    has $.impl-items;
    has $.comment;

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

our class ImplItem {
    has $.value;
    has $.comment;

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

our class ImplMacroItem {
    has $.item-macro;
    has $.attrs-and-vis;

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

our role ImplItem::Rules {

    rule maybe-impl-items {
        <impl-items>?
        <comment>?
    }

    rule impl-items {
        <impl-item>+
    }

    rule impl-item {  
        <comment>?
        <impl-item-base>
    }

    proto rule impl-item-base { * }

    rule impl-item-base:sym<a> {
        <impl-method>
    }

    rule impl-item-base:sym<b> {
        <attrs-and-vis> 
        <item-macro>
    }

    rule impl-item-base:sym<c> {
        <impl-const>
    }

    rule impl-item-base:sym<d> {
        <impl-type>
    }
}

our role ImplItem::Actions {

    method maybe-impl-items($/) {
        make ImplItems.new(
            impl-items => $<impl-items>.made,
            comment    => $<comment>.made,
            text       => ~$/,
        )
    }

    method impl-items($/) {
        make $<impl-item>>>.made
    }

    method impl-item($/) {
        make ImplItem.new(
            value   => $<impl-item-base>.made,
            comment => $<comment>.made,
            text    => ~$/,
        )
    }

    method impl-item-base:sym<a>($/) {
        make $<impl-method>.made
    }

    method impl-item-base:sym<b>($/) {
        make ImplMacroItem.new(
            attrs-and-vis =>  $<attrs-and-vis>.made,
            item-macro    =>  $<item-macro>.made,
            text          => ~$/,
        )
    }

    method impl-item-base:sym<c>($/) {
        make $<impl-const>.made
    }

    method impl-item-base:sym<d>($/) {
        make $<impl-type>.made
    }
}
