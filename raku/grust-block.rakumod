use Data::Dump::Tree;

our class ExprBlock {
    has $.maybe-stmts;
    has $.maybe-inner-attrs;
    has $.comment;

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

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
            text              => ~$/,
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
            text        => ~$/,
        )
    }
}
