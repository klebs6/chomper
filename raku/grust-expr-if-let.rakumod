use grust-model;

our role ExprIfLet::Rules {

    rule expr-if-let {
        <kw-if> 
        <kw-let> 
        <pat> 
        '=' 
        <expr-nostruct> 
        <block> 
        [
            <kw-else> 
            <block-or-if>
        ]?
    }
}

our role ExprIfLet::Actions {

    method expr-if-let($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
        )
    }
}
