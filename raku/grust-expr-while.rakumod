our class ExprWhile {
    has $.expr_nostruct;
    has $.block;
    has $.maybe_label;
}

our class ExprWhile::G {

    rule expr-while {
        <maybe-label> <WHILE> <expr-nostruct> <block>
    }
}

our class ExprWhile::A {

    method expr-while($/) {
        make ExprWhile.new(
            maybe-label   =>  $<maybe-label>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
        )
    }
}

