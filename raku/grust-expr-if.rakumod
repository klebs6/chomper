use Data::Dump::Tree;

our class ExprIf {
    has $.expr-nostruct;
    has $.block;
    has $.block-or-if;

    has $.text;
    has Bool $.semi = False;

    method gist {

        say "go back to that one with the precedence operators and gate";
        ddt self;
        #exit;
        if not $.block-or-if {

            qq:to/END/
            if {$.expr-nostruct.gist} {$.block.gist}
            END

        } else {

            qq:to/END/
            if {$.expr-nostruct.gist} {$.block.gist} else {$.block-or-if.gist}
            END
        }
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
            expr-nostruct => $<expr-nostruct>.made,
            block         => $<block>.made,
            block-or-if   => $<block-or-if>.made,
            text          => ~$/,
        )
    }
}
