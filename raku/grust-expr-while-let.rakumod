use grust-model;

our role ExprWhileLet::Rules {

    rule expr-while-let {
        <maybe-label> 
        <kw-while> 
        <kw-let> 
        <pat> 
        '=' 
        <expr-nostruct> 
        <block>
    }
}

our role ExprWhileLet::Actions {

    method expr-while-let($/) {
        make ExprWhileLet.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}
