use grust-model;

our role InnerAttrsAndBlock::Rules {

    rule inner-attrs_and_block {
        '{' <maybe-inner_attrs> <maybe-stmts> '}'
    }
}

our role InnerAttrsAndBlock::Actions {

    method inner-attrs_and_block($/) {
        make ExprBlock.new(
            maybe-inner_attrs =>  $<maybe-inner_attrs>.made,
            maybe-stmts       =>  $<maybe-stmts>.made,
        )
    }
}

#---------------------------------

our role Block::Rules {

    rule block {
        '{' <maybe-stmts> '}'
    }
}

our role Block::Actions {

    method block($/) {
        make ExprBlock.new(
            maybe-stmts =>  $<maybe-stmts>.made,
        )
    }
}
