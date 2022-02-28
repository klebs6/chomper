use grust-model;

our role ExprWhile::Rules {

    rule expr-while {
        <maybe-label> 
        <kw-while> 
        <expr-nostruct> 
        <block>
    }
}

our role ExprWhile::Actions {

    method expr-while($/) {
        make ExprWhile.new(
            maybe-label   =>  $<maybe-label>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}
