use Data::Dump::Tree;

our class ExprIfLet {
    has $.expr-nostruct;
    has $.block;
    has $.pat;
    has $.block-or-if;

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

our role ExprIfLet::Rules {

    rule expr-if-let {
        <kw-if> 
        <kw-let> 
        <pat> 
        '=' 
        <expr-nostruct> 
        <block> 
        [
            <kw-else> 
            <block-or-if>
        ]?
    }
}

our role ExprIfLet::Actions {

    method expr-if-let($/) {
        make ExprIfLet.new(
            pat           =>  $<pat>.made,
            expr-nostruct =>  $<expr-nostruct>.made,
            block         =>  $<block>.made,
            block-or-if   =>  $<block-or-if>.made,
            text          => ~$/,
        )
    }
}
