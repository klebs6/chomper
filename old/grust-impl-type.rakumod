use Data::Dump::Tree;

our class ImplType {
    has $.generic-params;
    has $.attrs-and-vis;
    has $.ty-sum;
    has $.ident;
    has $.maybe-default;

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

our role ImplType::Rules {

    rule impl-type {
        <attrs-and-vis> 
        <maybe-default> 
        <kw-type> 
        <ident> 
        <generic-params> 
        '=' 
        <ty-sum> 
        ';'
    }
}

our role ImplType::Actions {

    method impl-type($/) {
        make ImplType.new(
            attrs-and-vis  =>  $<attrs-and-vis>.made,
            maybe-default  =>  $<maybe-default>.made,
            ident          =>  $<ident>.made,
            generic-params =>  $<generic-params>.made,
            ty-sum         =>  $<ty-sum>.made,
            text           => ~$/,
        )
    }
}
