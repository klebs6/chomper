our class ExprIf {
    has $.block-or-if;
    has $.block;
    has $.expr-nostruct;

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

our role ExprIf::Rules {

    rule expr-if {
        <kw-if> 
        <expr-nostruct> 
        <block> 
        [
            <kw-else> 
            <block-or-if>
        ]?
    }
}

our role ExprIf::Actions {

    method expr-if($/) {
        make ExprIf.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
            text          => ~$/,
        )
    }
}
