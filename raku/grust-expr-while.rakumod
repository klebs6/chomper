our role ExprWhile::Rules {

    rule expr-while {
        <maybe-label> 
        <kw-while> 
        <expr-nostruct> 
        <block>
    }
}

our role ExprWhile::Actions {

    method expr-while($/) {
        make ExprWhile.new(
            maybe-label   =>  $<maybe-label>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            text          => ~$/,
        )
    }
}

our class ExprWhile {
    has $.expr-nostruct;
    has $.block;
    has $.maybe-label;

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
