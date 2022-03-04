use grust-model;

our role InnerAttrsAndBlock::Rules {

    rule inner-attrs-and-block {
        '{' 
        <maybe-inner-attrs> 
        <maybe-stmts> 
        <comment>? 
        '}'
    }
}

our role InnerAttrsAndBlock::Actions {

    method inner-attrs-and-block($/) {
        make ExprBlock.new(
            maybe-inner-attrs =>  $<maybe-inner-attrs>.made,
            maybe-stmts       =>  $<maybe-stmts>.made,
            comment           =>  $<comment>.made,
        )
    }
}

#---------------------------------

our role Block::Rules {

    rule block {
        '{' <maybe-stmts> <comment>? '}'
    }
}

our role Block::Actions {

    method block($/) {
        make ExprBlock.new(
            maybe-stmts =>  $<maybe-stmts>.made,
            comment     =>  $<comment>.made,
        )
    }
}
