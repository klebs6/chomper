use Data::Dump::Tree;

our class Generics {
    has $.ty-params;
    has $.lifetimes;

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

our role GenericParams::Rules {

    rule generic-params { <generic-params-base>? }

    rule generic-params-base { 
        '<' 
        [
            [<lifetimes> ','?]? 
            [<ty-params> ','?]?
            [<const-generics> ','?]? 
        ]? 
        '>' 
    }
}

our role GenericParams::Actions {

    method generic-params($/) {
        make $<generic-params-base>.made
    }

    method generic-params-base($/) {
        make Generics.new(
            lifetimes      =>  $<lifetimes>.made,
            const-generics =>  $<const-generics>.made,
            ty-params      =>  $<ty-params>.made,
            text           => ~$/,
        )
    }
}
