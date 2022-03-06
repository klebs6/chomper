our role ExprWhileLet::Rules {

    rule expr-while-let {
        <maybe-label> 
        <kw-while> 
        <kw-let> 
        <pat> 
        '=' 
        <expr-nostruct> 
        <block>
    }
}

our role ExprWhileLet::Actions {

    method expr-while-let($/) {
        make ExprWhileLet.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            text          => ~$/,
        )
    }
}

our class ExprWhileLet {
    has $.expr-nostruct;
    has $.pat;
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
