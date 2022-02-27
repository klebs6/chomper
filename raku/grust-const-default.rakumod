use grust-model;

our role ConstDefault::Rules {

    rule maybe-const-default { [ '=' <expr> ]? }
}

our role ConstDefault::Actions {

    method maybe-const-default($/) {

        my $expr = $<expr>.made;

        make $expr ?? ConstDefault.new( :$expr,) !! Nil
    }
}
