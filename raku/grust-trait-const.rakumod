our class ConstTraitItem {
    has $.maybe-ty-ascription;
    has $.maybe-const-default;
    has $.ident;
    has $.maybe-outer-attrs;

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

our role TraitConst::Rules {

    rule trait-const {
        <maybe-outer-attrs> 
        <kw-const> 
        <ident> 
        <maybe-ty-ascription> 
        <maybe-const-default> 
        ';'
    }
}

our role TraitConst::Actions {

    method trait-const($/) {
        make ConstTraitItem.new(
            maybe-outer-attrs   => $<maybe-outer-attrs>.made,
            ident               => $<ident>.made,
            maybe-ty-ascription => $<maybe-ty-ascription>.made,
            maybe-const-default => $<maybe-const-default>.made,
            text                => ~$/,
        )
    }
}
