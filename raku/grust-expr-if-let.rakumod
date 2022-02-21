our class ExprIfLet {
    has $.expr_nostruct;
    has $.block;
    has $.pat;
    has $.block_or_if;
}

our class ExprIfLet::Rules {

    proto rule expr-if_let { * }

    rule expr-if_let:sym<a> {
        <IF> <LET> <pat> '=' <expr-nostruct> <block>
    }

    rule expr-if_let:sym<b> {
        <IF> <LET> <pat> '=' <expr-nostruct> <block> <ELSE> <block-or_if>
    }
}

our class ExprIfLet::Actions {

    method expr-if_let:sym<a>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }

    method expr-if_let:sym<b>($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or_if   =>  $<block-or_if>.made,
        )
    }
}

