our class ArmBlock {
    has $.block_expr;
    has $.block;
    has $.pats_or;
    has $.maybe_guard;
    has $.maybe_outer_attrs;
}

our class ArmNonblock {
    has $.nonblock_expr;
    has $.maybe_outer_attrs;
    has $.block_expr_dot;
    has $.maybe_guard;
    has $.pats_or;
}

our class Arms {
    has $.match_clause;
}

our class ExprMatch {
    has $.match_clauses;
    has $.nonblock_match_clause;
    has $.expr_nostruct;
}

our class ExprMatch::Rules {

    proto rule expr-match { * }

    rule expr-match:sym<a> { <MATCH> <expr-nostruct> '{' '}' }
    rule expr-match:sym<b> { <MATCH> <expr-nostruct> '{' <match-clauses> '}' }
    rule expr-match:sym<c> { <MATCH> <expr-nostruct> '{' <match-clauses> <nonblock-match_clause> '}' }
    rule expr-match:sym<d> { <MATCH> <expr-nostruct> '{' <nonblock-match_clause> '}' }

    rule match-clauses { <match-clause>+ }

    #--------------------
    proto rule match-clause { * }
    rule match-clause:sym<a> { <nonblock-match_clause> ',' }
    rule match-clause:sym<b> { <block-match_clause> ','? }

    #--------------------
    proto rule nonblock-match_clause { * }

    rule nonblock-match_clause:sym<a> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <nonblock-expr>
    }

    rule nonblock-match_clause:sym<b> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block-expr_dot>
    }

    #--------------------
    proto rule block-match_clause { * }

    rule block-match_clause:sym<a> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block>
    }

    rule block-match_clause:sym<b> {
        <maybe-outer_attrs> <pats-or> <maybe-guard> <FAT-ARROW> <block-expr>
    }
}

our class ExprMatch::Actions {

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
            nonblock-match_clause =>  $<nonblock-match_clause>.made,
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
        make $<block-match_clause>.made
    }

    #-----------------
    method nonblock-match_clause:sym<a>($/) {
        make ArmNonblock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            nonblock-expr     =>  $<nonblock-expr>.made,
        )
    }

    method nonblock-match_clause:sym<b>($/) {
        make ArmNonblock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr_dot    =>  $<block-expr_dot>.made,
        )
    }

    method block-match_clause:sym<a>($/) {
        make ArmBlock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block             =>  $<block>.made,
        )
    }

    method block-match_clause:sym<b>($/) {
        make ArmBlock.new(
            maybe-outer_attrs =>  $<maybe-outer_attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr        =>  $<block-expr>.made,
        )
    }
}
