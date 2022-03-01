use grust-model;

our role ExprIf::Rules {

    rule expr-if {
        <kw-if> 
        <expr-nostruct> 
        <block> 
        [
            <kw-else> 
            <block-or-if>
        ]?
    }
}

our role ExprIf::Actions {

    method expr-if($/) {
        make ExprIf.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
        )
    }
}
