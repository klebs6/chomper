our class ExprBlock {
    has $.maybe_stmts;
    has $.maybe_inner_attrs;
}

our class InnerAttrsAndBlock::G {

    rule inner-attrs_and_block {
        '{' <maybe-inner_attrs> <maybe-stmts> '}'
    }
}

our class InnerAttrsAndBlock::A {

    method inner-attrs_and_block($/) {
        make ExprBlock.new(
            maybe-inner_attrs =>  $<maybe-inner_attrs>.made,
            maybe-stmts       =>  $<maybe-stmts>.made,
        )
    }
}

#---------------------------------

our class Block::G {

    rule block {
        '{' <maybe-stmts> '}'
    }
}

our class Block::A {

    method block($/) {
        make ExprBlock.new(
            maybe-stmts =>  $<maybe-stmts>.made,
        )
    }
}
