use Data::Dump::Tree;

our class ItemMod {
    has $.ident;
    has $.maybe-mod-items;
    has $.inner-attrs;

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

our class ItemForeignMod {
    has $.inner-attrs;
    has $.item-foreign-mod;
    has $.maybe-foreign-items;

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

our role ItemMod::Rules {

    proto rule item-mod { * }

    rule item-mod:sym<a> {
        <kw-mod> <ident> ';'
    }

    rule item-mod:sym<b> {
        <kw-mod> <ident> '{' <inner-attrs>? <maybe-mod-items> '}'
    }

    rule item-foreign-mod {
        <kw-extern> <maybe-abi> '{' <inner-attrs>? <maybe-foreign-items> '}'
    }

    rule maybe-abi {
        <str>?
    }
}

our role ItemMod::Actions {

    method item-mod:sym<a>($/) {
        make ItemMod.new(
            ident => $<ident>.made,
            text  => ~$/,
        )
    }

    method item-mod:sym<b>($/) {
        make ItemMod.new(
            ident           => $<ident>.made,
            inner-attrs     => $<inner-attrs>.made,
            maybe-mod-items => $<maybe-mod-items>.made,
            text            => ~$/,
        )
    }

    method item-foreign-mod($/) {
        make ItemForeignMod.new(
            inner-attrs         =>  $<inner-attrs>.made,
            maybe-foreign-items =>  $<maybe-foreign-items>.made,
            text                => ~$/,
        )
    }

    method maybe-abi($/) {
        make $<str>.made
    }
}
