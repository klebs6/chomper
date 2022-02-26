our class ExprWhileLet {
    has $.expr_nostruct;
    has $.pat;
    has $.block;
    has $.maybe_label;
}

our class ExprWhileLet::Rules {

    rule expr-while_let {
        <maybe-label> <WHILE> <LET> <pat> '=' <expr-nostruct> <block>
    }
}

our class ExprWhileLet::Actions {

    method expr-while_let($/) {
        make ExprWhileLet.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}
