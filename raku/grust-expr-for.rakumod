use Data::Dump::Tree;

our class ExprForLoop {
    has $.maybe-label;
    has $.pat;
    has $.expr-nostruct;
    has $.block;

    has $.text;
    has Bool $.semi = False;

    method gist {
        qq:to/END/.chomp.trim
        for {$.pat.gist.trim} in {$.expr-nostruct.gist} {$.block.gist}
        END
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
