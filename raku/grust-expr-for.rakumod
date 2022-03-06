use Data::Dump::Tree;

our class ExprForLoop {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
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

our role ExprFor::Rules {

    rule expr-for {
        <maybe-label> 
        <kw-for> 
        <pat> 
        <kw-in> 
        <expr-nostruct> 
        <block>
    }
}

our role ExprFor::Actions {

    method expr-for($/) {
        make ExprForLoop.new(
            maybe-label   =>  $<maybe-label>.made,
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            text          => ~$/,
        )
    }
}
