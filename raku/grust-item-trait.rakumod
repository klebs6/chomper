use Data::Dump::Tree;

our class ItemTrait {
    has $.maybe-where-clause;
    has $.maybe-unsafe;
    has $.generic-params;
    has $.for-sized;
    has $.maybe-ty-param-bounds;
    has $.maybe-trait-items;
    has $.ident;

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

our class TraitItem {
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

our class TraitMacroItem {
    has $.maybe-outer-attrs;
    has $.item-macro;

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

our role ItemTrait::Rules {

    rule item-trait {
        <maybe-unsafe> 
        <kw-trait> 
        <ident> 
        <generic-params> 
        <for-sized> 
        <maybe-ty-param-bounds> 
        <maybe-where-clause> 
        '{' <maybe-trait-items> '}'
    }

    rule maybe-trait-items {
        <trait-items>?
    }

    rule trait-items {
        <trait-item>+
    }

    #----------------------
    rule trait-item { <comment>? <trait-item-base> }

    proto rule trait-item-base { * }

    rule trait-item-base:sym<a> {
        <trait-const>
    }

    rule trait-item-base:sym<b> {
        <trait-type>
    }

    rule trait-item-base:sym<c> {
        <trait-method>
    }

    rule trait-item-base:sym<d> {
        <maybe-outer-attrs>
        <item-macro>
    }
}

our role ItemTrait::Actions {

    method item-trait($/) {
        make ItemTrait.new(
            maybe-unsafe          =>  $<maybe-unsafe>.made,
            ident                 =>  $<ident>.made,
            generic-params        =>  $<generic-params>.made,
            for-sized             =>  $<for-sized>.made,
            maybe-ty-param-bounds =>  $<maybe-ty-param-bounds>.made,
            maybe-where-clause    =>  $<maybe-where-clause>.made,
            maybe-trait-items     =>  $<maybe-trait-items>.made,
            text                  => ~$/,
        )
    }

    method maybe-trait-items($/) {
        make $<trait-items>.made
    }

    method trait-items($/) {
        make $<trait-item>>>.made
    }

    #----------
    method trait-item($/) {
        make TraitItem.new(
            value   => $<trait-item-base>.made,
            comment => $<comment>.made,
            text    => ~$/,
        )
    }

    method trait-item-base:sym<a>($/) {
        make $<trait-const>.made
    }

    method trait-item-base:sym<b>($/) {
        make $<trait-type>.made
    }

    method trait-item-base:sym<c>($/) {
        make $<trait-method>.made
    }

    method trait-item-base:sym<d>($/) {
        make TraitMacroItem.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            item-macro        =>  $<item-macro>.made,
            text              => ~$/,
        )
    }
}
