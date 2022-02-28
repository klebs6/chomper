use grust-model;

our role ExprFor::Rules {

    rule expr-for {
        <maybe-label> 
        <for_> 
        <pat> 
        <in> 
        <expr-nostruct> 
        <block>
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
