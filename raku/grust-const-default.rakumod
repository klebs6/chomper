our class ConstDefault {
    has $.expr;
}

our class ConstDefault::Rules {

    rule maybe-const-default { [ '=' <expr> ]? }
}

our class ConstDefault::Actions {

    method maybe-const-default($/) {

        my $expr = $<expr>.made;

        make $expr ?? ConstDefault.new( :$expr,) !! Nil
    }
}
