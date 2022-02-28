use grust-model;

our role ExprIf::Rules {

    proto rule expr-if { * }

    rule expr-if:sym<a> {
        <if_> <expr-nostruct> <block>
    }

    rule expr-if:sym<b> {
        <if_> <expr-nostruct> <block> <else_> <block-or-if>
    }
}

our role ExprIf::Actions {

    method expr-if:sym<a>($/) {
        make ExprIf.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }

    method expr-if:sym<b>($/) {
        make ExprIf.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
        )
    }
}
