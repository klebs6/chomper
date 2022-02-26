our class ExprForLoop {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
    has $.maybe-label;
}

our class ExprFor::Rules {

    rule expr-for {
        <maybe-label> <FOR> <pat> <IN> <expr-nostruct> <block>
    }
}

our class ExprFor::Actions {

    method expr-for($/) {
        make ExprForLoop.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}

