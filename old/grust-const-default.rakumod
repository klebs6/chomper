use Data::Dump::Tree;

our class ConstDefault {
    has $.expr;

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

our role ConstDefault::Rules {

    rule maybe-const-default { [ '=' <expr> ]? }
}

our role ConstDefault::Actions {

    method maybe-const-default($/) {

        my $expr = $<expr>.made;

        make $expr ?? ConstDefault.new( :$expr, text => ~$/,) !! Nil
    }
}
