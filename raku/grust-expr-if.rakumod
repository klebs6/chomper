our class ExprIf {
    has $.block_or_if;
    has $.block;
    has $.expr_nostruct;
}

our class ExprIf::Rules {

    proto rule expr-if { * }

    rule expr-if:sym<a> {
        <IF> <expr-nostruct> <block>
    }

    rule expr-if:sym<b> {
        <IF> <expr-nostruct> <block> <ELSE> <block-or_if>
    }
}

our class ExprIf::Actions {

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
            block-or_if   =>  $<block-or_if>.made,
        )
    }
}
