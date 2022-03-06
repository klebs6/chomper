our class TypeTraitItem {
    has $.maybe-outer-attrs;
    has $.ty-param;

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

our role TraitType::Rules {

    rule trait-type {
        <maybe-outer-attrs> <kw-type> <ty-param> ';'
    }
}

our role TraitType::Actions {

    method trait-type($/) {
        make TypeTraitItem.new(
            maybe-outer-attrs => $<maybe-outer-attrs>.made,
            ty-param          => $<ty-param>.made,
            text              => ~$/,
        )
    }
}
