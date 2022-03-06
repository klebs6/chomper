our class ExprLoop {
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

our role ExprLoop::Rules {

    rule expr-loop {
        <maybe-label> 
        <kw-loop> 
        <block>
    }
}

our role ExprLoop::Actions {

    method expr-loop($/) {
        make ExprLoop.new(
            maybe-label => $<maybe-label>.made,
            block       => $<block>.made,
            text        => ~$/,
        )
    }
}
