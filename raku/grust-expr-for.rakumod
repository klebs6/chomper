use grust-model;

our role ExprFor::Rules {

    rule expr-for {
        <maybe-label> <FOR> <pat> <IN> <expr-nostruct> <block>
    }
}

our role ExprFor::Actions {

    method expr-for($/) {
        make ExprForLoop.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}


