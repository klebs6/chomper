use Data::Dump::Tree;

our class ItemTraitAlias {
    has Bool $.unsafe;
    has $.ident;
    has $.ty-sum;

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

our role ItemTraitAlias::Rules {

    rule item-trait-alias {
        <maybe-unsafe> 
        <kw-trait> 
        <ident> 
        '='
        <ty-sum>
        ';'
    }
}

our role ItemTraitAlias::Actions {

    method item-trait-alias($/) {
        make ItemTraitAlias.new(
            unsafe  => so $<maybe-unsafe><kw-unsafe>:exists,
            ident   => $<ident>.made,
            ty-sum  => $<ty-sum>.made,
            text    => ~$/,
        )
    }
}
