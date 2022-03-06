use Data::Dump::Tree;

our class ItemTy {
    has $.generic-params;
    has $.maybe-where-clause;
    has $.ty-sum;
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

our role ItemType::Rules {

    rule item-type {
        <kw-type> 
        <ident> 
        <generic-params> 
        <maybe-where-clause> 
        '=' <ty-sum> ';'
    }
}

our role ItemType::Actions {

    method item-type($/) {
        make ItemTy.new(
            ident              =>  $<ident>.made,
            generic-params     =>  $<generic-params>.made,
            maybe-where-clause =>  $<maybe-where-clause>.made,
            ty-sum             =>  $<ty-sum>.made,
            text               => ~$/,
        )
    }
}
