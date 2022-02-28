use grust-model;

our role ExprIfLet::Rules {

    proto rule expr-if-let { * }

    rule expr-if-let:sym<a> {
        <IF> <LET> <pat> '=' <expr-nostruct> <block>
    }

    rule expr-if-let:sym<b> {
        <IF> <LET> <pat> '=' <expr-nostruct> <block> <ELSE> <block-or-if>
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


