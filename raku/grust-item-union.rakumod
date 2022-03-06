use Data::Dump::Tree;

our class ItemUnion {

    has $.ident;
    has $.generic-params;
    has $.maybe-where-clause;
    has $.struct-decl-fields;
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

our role ItemUnion::Rules {

    rule item-union {
        <kw-union> 
        <ident> 
        <generic-params> 
        <maybe-where-clause> 
        '{' <struct-decl-fields> ','? '}'
    }
}

our role ItemUnion::Actions {

    method item-union($/) {
        make ItemUnion.new(
            ident              => $<ident>.made,
            generic-params     => $<generic-params>.made,
            maybe-where-clause => $<maybe-where-clause>.made,
            struct-decl-fields => $<struct-decl-fields>.made,
            text               => ~$/,
        )
    }
}
