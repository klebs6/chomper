use grust-model;

our role ExprLoop::Rules {

    rule expr-loop {
        <maybe-label> <LOOP> <block>
    }
}

our role ExprLoop::Actions {

    method expr-loop($/) {
        make ExprLoop.new(
            maybe-label =>  $<maybe-label>.made,
            block       =>  $<block>.made,
        )
    }
}


