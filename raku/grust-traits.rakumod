use Data::Dump::Tree;

our class Trait {
    has Bool $.unsafe;
    has $.identifier;
    has $.maybe-generic-params;
    has $.maybe-type-param-bounds;
    has $.maybe-where-clause;
    has @.inner-attributes;
    has @.associated-items;
    has $.maybe-comment;

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

our class InherentImpl {
    has $.maybe-generic-params;
    has $.type;
    has $.maybe-where-clause;
    has @.inner-attributes;
    has @.associated-items;
    has $.maybe-comment;

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

our class TraitImpl {
    has Bool $.unsafe;
    has $.maybe-generic-params;
    has Bool $.bang;
    has $.type-path;
    has $.for-type;
    has $.maybe-where-clause;
    has @.inner-attributes;
    has @.associated-items;
    has $.maybe-comment;

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

our class TraitAlias {
    has @.outer-attributes;
    has $.maybe-visibility;
    has $.identifier;
    has $.maybe-generic-params;
    has $.type-param-bounds;
    has $.maybe-where-clause;

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

our role Trait::Actions {

    method trait($/) {
        make Trait.new(
            unsafe                  => so $<kw-unsafe>:exists,
            identifier              => $<identifier>.made,
            maybe-generic-params    => $<generic-params>.made,
            maybe-type-param-bounds => $<type-param-bounds>>>.made,
            maybe-where-clause      => $<where-clause>.made,
            inner-attributes        => $<inner-attribute>>>.made,
            associated-items        => $<associated-item>.made,
            maybe-comment           => $<comment>.made,
            text       => $/.Str,
        )
    }

    method implementation:sym<inherent>($/) { make $<inherent-impl>.made }
    method implementation:sym<trait>($/)    { make $<trait-impl>.made }

    method inherent-impl($/) {
        make InherentImpl.new(
            maybe-generic-params => $<generic-params>.made,
            type                 => $<type>.made,
            maybe-where-clause   => $<where-clause>.made,
            inner-attributes     => $<inner-attribute>.made,
            associated-items     => $<associated-item>.made,
            maybe-comment        => $<comment>.made,
            text       => $/.Str,
        )
    }

    method trait-impl($/) {
        our class TraitImpl {
            unsafe               => $/<kw-unsafe>:exists,
            maybe-generic-params => $<generic-params>.made,
            bang                 => so $/<tok-bang>:exists,
            type-path            => $<type-path>.made,
            for-type             => $<type>.made,
            maybe-where-clause   => $<where-clause>.made,
            inner-attributes     => $<inner-attribute>>>.made,
            associated-items     => $<associated-item>>>.made,
            maybe-comment        => $<comment>.made,
            text       => $/.Str,
        }
    }

    method trait-alias($/) {
        make TraitAlias.new(
            outer-attributes     => $<outer-attribute>>>.made,
            maybe-visibility     => $<visibility>.made,
            identifier           => $<identifier>.made,
            maybe-generic-params => $<generic-params>.made,
            type-param-bounds    => $<type-param-bounds>.made,
            maybe-where-clause   => $<where-clause>.made,
            text       => $/.Str,
        )
    }
}
