our class ExprBlock {
    has $.maybe_stmts;
    has $.maybe_inner_attrs;
}

our class InnerAttrsAndBlock::Rules {

    rule inner-attrs_and_block {
        '{' <maybe-inner_attrs> <maybe-stmts> '}'
    }
}

our class InnerAttrsAndBlock::Actions {

    method inner-attrs_and_block($/) {
        make ExprBlock.new(
            maybe-inner_attrs =>  $<maybe-inner_attrs>.made,
            maybe-stmts       =>  $<maybe-stmts>.made,
        )
    }
}

#---------------------------------

our class Block::Rules {

    rule block {
        '{' <maybe-stmts> '}'
    }
}

our class Block::Actions {

    method block($/) {
        make ExprBlock.new(
            maybe-stmts =>  $<maybe-stmts>.made,
        )
    }
}
