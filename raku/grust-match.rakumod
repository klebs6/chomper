use Data::Dump::Tree;

our class ArmBlock {

    has $.maybe-outer-attrs;
    has $.pats-or;
    has $.maybe-guard;
    has $.block;

    has $.text;

    method gist {
        qq:to/END/.chomp.trim
        {$.maybe-outer-attrs ?? $.maybe-outer-attrs.gist !! ""}
        {$.pats-or>>.gist.join("")} {$.maybe-guard ?? $.maybe-guard.gist !! ""} => {$.block.gist}
        END
    }
}

our class ArmNonblock {
    has $.nonblock-expr;
    has $.maybe-outer-attrs;
    has $.maybe-guard;
    has $.pats-or;

    has $.text;

    method gist {
        qq:to/END/.chomp.trim
        {$.maybe-outer-attrs ?? $.maybe-outer-attrs.gist !! ""}
        {$.pats-or>>.gist.join("")} {$.maybe-guard ?? $.maybe-guard.gist !! ""} => {$.nonblock-expr.gist}
        END
    }
}

our class ArmNonblockDot {
    has $.maybe-outer-attrs;
    has $.block-expr-dot;
    has $.maybe-guard;
    has $.pats-or;

    has $.text;

    method gist {
        qq:to/END/.chomp.trim
        {$.maybe-outer-attrs ?? $.maybe-outer-attrs.gist !! ""}
        {$.pats-or.gist} {$.maybe-guard ?? $.maybe-guard.gist !! ""} => {$.block-expr-dot.gist}
        END
    }
}

our class MatchClause {
    has $.clause;
    has $.comment;

    has $.text;

    method gist {
        if $.comment {
            qq:to/END/.chomp.trim
            {$.comment.gist}
            {$.clause.gist}
            END
        } else {
            qq:to/END/.chomp.trim
            {$.clause.gist}
            END
        }
    }
}

our class ExprMatch {
    has $.match-clauses;
    has $.nonblock-match-clause;
    has $.expr-nostruct;

    has $.text;
    has $.semi = False;

    method gist {

        my @clauses = [|$.match-clauses>>.gist];

        if $.nonblock-match-clause {
            @clauses.push: $.nonblock-match-clause.gist
        }

        qq:to/END/
        match {$.expr-nostruct.gist} \{
        @clauses.join(",\n").indent(4)
        \}
        END
    }
}

our role ExprMatch::Rules {

    proto rule expr-match { * }

    rule expr-match:sym<a> { <kw-match> <expr-nostruct> '{' '}' }
    rule expr-match:sym<b> { <kw-match> <expr-nostruct> '{' <match-clauses> <comment>? '}' }
    rule expr-match:sym<c> { <kw-match> <expr-nostruct> '{' <match-clauses> <nonblock-match-clause> <comment>? '}' }
    rule expr-match:sym<d> { <kw-match> <expr-nostruct> '{' <nonblock-match-clause> <comment>? '}' }

    regex match-clauses { <match-clause>+ }

    #--------------------
    rule match-clause { <comment>? <match-clause-base> }

    proto rule match-clause-base { * }
    rule match-clause-base:sym<a> { <nonblock-match-clause> ',' }
    rule match-clause-base:sym<b> { <block-match-clause> ','? }

    #--------------------
    proto rule nonblock-match-clause { * }

    rule nonblock-match-clause:sym<a> {
        <maybe-outer-attrs> 
        <pats-or> 
        <maybe-guard> 
        <tok-fat-arrow> 
        <nonblock-expr>
    }

    rule nonblock-match-clause:sym<b> {
        <maybe-outer-attrs> 
        <pats-or> 
        <maybe-guard> 
        <tok-fat-arrow> 
        <block-expr-dot>
    }

    #--------------------
    proto rule block-match-clause { * }

    rule block-match-clause:sym<a> {
        <maybe-outer-attrs> 
        <pats-or> 
        <maybe-guard> 
        <tok-fat-arrow> 
        <block>
    }

    rule block-match-clause:sym<b> {
        <maybe-outer-attrs> 
        <pats-or> 
        <maybe-guard> 
        <tok-fat-arrow> 
        <block-expr>
    }
}

our role ExprMatch::Actions {

    method expr-match:sym<a>($/) {
        make ExprMatch.new(
            expr-nostruct =>  $<expr-nostruct>.made,
            text          => ~$/,
        )
    }

    method expr-match:sym<b>($/) {
        make ExprMatch.new(
            expr-nostruct => $<expr-nostruct>.made,
            match-clauses => $<match-clauses>.made,
            comment       => $<comment>.made,
            text          => ~$/,
        )
    }

    method expr-match:sym<c>($/) {
        make ExprMatch.new(
            expr-nostruct         => $<expr-nostruct>.made,
            match-clauses         => $<match-clauses>.made,
            nonblock-match-clause => $<nonblock-match-clause>.made,
            comment               => $<comment>.made,
            text                   => ~$/,
        )
    }

    method expr-match:sym<d>($/) {
        make ExprMatch.new(
            expr-nostruct         => $<expr-nostruct>.made,
            nonblock-match-clause => $<nonblock-match-clause>.made,
            comment               => $<comment>.made,
            text                  => ~$/,
        )
    }

    method match-clauses($/) {
        make $<match-clause>>>.made
    }

    method match-clause($/) {
        make MatchClause.new(
            comment => $<comment>.made,
            clause  => $<match-clause-base>.made,
            text    => ~$/,
        )
    }

    method match-clause-base:sym<a>($/) {
        make $<nonblock-match-clause>.made
    }

    method match-clause-base:sym<b>($/) {
        make $<block-match-clause>.made
    }

    #-----------------
    method nonblock-match-clause:sym<a>($/) {
        make ArmNonblock.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            nonblock-expr     =>  $<nonblock-expr>.made,
            text              => ~$/,
        )
    }

    method nonblock-match-clause:sym<b>($/) {
        make ArmNonblockDot.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block-expr-dot    =>  $<block-expr-dot>.made,
            text              => ~$/,
        )
    }

    method block-match-clause:sym<a>($/) {
        make ArmBlock.new(
            maybe-outer-attrs =>  $<maybe-outer-attrs>.made,
            pats-or           =>  $<pats-or>.made,
            maybe-guard       =>  $<maybe-guard>.made,
            block             =>  $<block>.made,
            text              => ~$/,
        )
    }

    method block-match-clause:sym<b>($/) {
        make ArmBlock.new(
            maybe-outer-attrs => $<maybe-outer-attrs>.made,
            pats-or           => $<pats-or>.made,
            maybe-guard       => $<maybe-guard>.made,
            block             => $<block-expr>.made,
            text              => ~$/,
        )
    }
}
