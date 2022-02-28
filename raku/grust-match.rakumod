use grust-model;


our role ExprMatch::Rules {

    proto rule expr-match { * }

    rule expr-match:sym<a> { <MATCH_> <expr-nostruct> '{' '}' }
    rule expr-match:sym<b> { <MATCH_> <expr-nostruct> '{' <match-clauses> '}' }
    rule expr-match:sym<c> { <MATCH_> <expr-nostruct> '{' <match-clauses> <nonblock-match-clause> '}' }
    rule expr-match:sym<d> { <MATCH_> <expr-nostruct> '{' <nonblock-match-clause> '}' }

    rule match-clauses { <match-clause>+ }

    #--------------------
    proto rule match-clause { * }
    rule match-clause:sym<a> { <nonblock-match-clause> ',' }
    rule match-clause:sym<b> { <block-match-clause> ','? }

    #--------------------
    proto rule nonblock-match-clause { * }

    rule nonblock-match-clause:sym<a> {
        <maybe-outer-attrs> <pats-or> <maybe-guard> <FAT-ARROW> <nonblock-expr>
    }

    rule nonblock-match-clause:sym<b> {
        <maybe-outer-attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block-expr-dot>
    }

    #--------------------
    proto rule block-match-clause { * }

    rule block-match-clause:sym<a> {
        <maybe-outer-attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block>
    }

    rule block-match-clause:sym<b> {
        <maybe-outer-attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block-expr>
    }
}

our role ExprMatch::Actions {

    method expr-match:sym<a>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method expr-match:sym<b>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            match-clauses =>  $<match-clauses>.made,
        )
    }

    method expr-match:sym<c>($/) {
        make ExprMatch.new(
            expr-nostruct         =>  $<expr-nostruct>.made,
            match-clauses         =>  $<match-clauses>.made,
            nonblock-match-clause =>  $<nonblock-match-clause>.made,
        )
    }

    method expr-match:sym<d>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
        )
    }

    method match-clauses($/) {
        make $<match-clause>>>.made
    }

    method match-clause:sym<a>($/) {

    }

    method match-clause:sym<b>($/) {
        make $<block-match-clause>.made
    }

    #-----------------
    method nonblock-match-clause:sym<a>($/) {
        make ArmNonblock.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            nonblock-expr     =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-match-clause:sym<b>($/) {
        make ArmNonblock.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr-dot    =>  $<block-expr-dot>.made,
        )
    }

    method block-match-clause:sym<a>($/) {
        make ArmBlock.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block             =>  $<block>.made,
        )
    }

    method block-match-clause:sym<b>($/) {
        make ArmBlock.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr        =>  $<block-expr>.made,
        )
    }
}

