our class ExprLoop {
    has $.block;
    has $.maybe_label;
}

our class ExprLoop::G {

    rule expr-loop {
        <maybe-label> <LOOP> <block>
    }
}

our class ExprLoop::A {

    method expr-loop($/) {
        make ExprLoop.new(
            maybe-label =>  $<maybe-label>.made,
            block       =>  $<block>.made,
        )
    }
}

