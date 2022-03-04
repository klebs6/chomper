use grust-model;

our role ExprIfLet::Rules {

    proto rule expr-if-let { * }

    rule expr-if-let:sym<b> {
        <kw-if> 
        <kw-let> 
        <pat> 
        '=' 
        <expr-nostruct> 
        <block> 
        <kw-else> 
        <block-or-if>
    }

    rule expr-if-let:sym<a> {
        <kw-if> 
        <kw-let> 
        <pat> 
        '=' 
        <expr-nostruct> 
        <block>
    }
}

our role ExprIfLet::Actions {

    method expr-if-let:sym<b>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
        )
    }

    method expr-if-let:sym<a>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}
