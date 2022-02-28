use grust-model;

our role ExprIfLet::Rules {

    proto rule expr-if-let { * }

    rule expr-if-let:sym<a> {
        <if_> <let_> <pat> '=' <expr-nostruct> <block>
    }

    rule expr-if-let:sym<b> {
        <if_> <let_> <pat> '=' <expr-nostruct> <block> <else_> <block-or-if>
    }
}

our role ExprIfLet::Actions {

    method expr-if-let:sym<a>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }

    method expr-if-let:sym<b>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
        )
    }
}
