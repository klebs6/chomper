our class ExprLoop {
    has $.block;
    has $.maybe-label;
}

our class ExprLoop::Rules {

    rule expr-loop {
        <maybe-label> <LOOP> <block>
    }
}

our class ExprLoop::Actions {

    method expr-loop($/) {
        make ExprLoop.new(
            maybe-label =>  $<maybe-label>.made,
            block       =>  $<block>.made,
        )
    }
}

