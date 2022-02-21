our class ExprForLoop {
    has $.expr_nostruct;
    has $.block;
    has $.pat;
    has $.maybe_label;
}

our class ExprFor::G {

    rule expr-for {
        <maybe-label> <FOR> <pat> <IN> <expr-nostruct> <block>
    }
}

our class ExprFor::A {

    method expr-for($/) {
        make ExprForLoop.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}

