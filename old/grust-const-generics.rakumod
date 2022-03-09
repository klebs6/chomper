use Data::Dump::Tree;

our class ConstGeneric {
    has $.name;
    has $.ty  ;

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

our role ConstGenerics::Rules {

    rule const-generic {
        <kw-const> <ident> <ty-ascription>
    }

    rule const-generics {
        <const-generic>+ %% ","
    }
}

our role ConstGenerics::Actions {

    method const-generic($/) {
        make ConstGeneric.new(
            name => $<ident>.made,
            ty   => $<ty-ascription>.made,
        )
    }

    method const-generics($/) {
        make $<const-generic>>>.made
    }
}

