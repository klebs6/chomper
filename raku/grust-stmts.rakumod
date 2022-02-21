
#---------------------------------
# There are two sub-grammars within a "stmts:
# exprs" derivation depending on whether each
# stmt-expr is a block-expr form; this is to
# handle the "semicolon rule" for stmt sequencing
# that permits writing
#
#     if foo { bar } 10
#
# as a sequence of two stmts (one if-expr stmt,
# one lit-10-expr stmt). Unfortunately by
# permitting juxtaposition of exprs in sequence
# like that, the non-block expr grammar has to
# have a second limited sub-grammar that excludes
# the prefix exprs that are ambiguous with
# binops. That is to say:
#
#     {10} - 1
#
# should parse as (progn (progn 10) (- 1)) not (-
# (progn 10) 1), that is to say, two statements
# rather than one, at least according to the
# mainline rust parser.
#
# So we wind up with a 3-way split in exprs that
# occur in stmt lists: block, nonblock-prefix, and
# nonblock-nonprefix.
#
# In non-stmts contexts, expr can relax this
# trichotomy.
our class Stmts {
    has $.stmt;
}

our class Stmts::G {

    proto rule maybe-stmts { * }

    rule maybe-stmts:sym<a> {
        <stmts>
    }

    rule maybe-stmts:sym<b> {
        <stmts> <nonblock-expr>
    }

    rule maybe-stmts:sym<c> {
        <nonblock-expr>
    }

    rule maybe-stmts:sym<d> {

    }

    proto rule stmts { * }

    rule stmts:sym<a> {
        <stmt>
    }

    rule stmts:sym<b> {
        <stmts> <stmt>
    }

    proto rule stmt { * }

    rule stmt:sym<a> {
        <maybe-outer_attrs> <let>
    }

    rule stmt:sym<b> {
        <stmt-item>
    }

    rule stmt:sym<c> {
        <PUB> <stmt-item>
    }

    rule stmt:sym<d> {
        <outer-attrs> <stmt-item>
    }

    rule stmt:sym<e> {
        <outer-attrs> <PUB> <stmt-item>
    }

    rule stmt:sym<f> {
        <full-block_expr>
    }

    rule stmt:sym<g> {
        <maybe-outer_attrs> <block>
    }

    rule stmt:sym<h> {
        <nonblock-expr> ';'
    }

    rule stmt:sym<i> {
        <outer-attrs> <nonblock-expr> ';'
    }

    rule stmt:sym<j> {
        ';'
    }
}

our class Stmts::A {

    method maybe-stmts:sym<a>($/) {
        make $<stmts>.made
    }

    method maybe-stmts:sym<b>($/) {
        ExtNode<140397158386760>
    }

    method maybe-stmts:sym<c>($/) {
        make $<nonblock-expr>.made
    }

    method maybe-stmts:sym<d>($/) {
        MkNone<140397971049472>
    }

    method stmts:sym<a>($/) {
        make stmts.new(
            stmt =>  $<stmt>.made,
        )
    }

    method stmts:sym<b>($/) {
        ExtNode<140397158387120>
    }

    method stmt:sym<a>($/) {
        make $<let>.made
    }

    method stmt:sym<b>($/) {
        make $<stmt-item>.made
    }

    method stmt:sym<c>($/) {
        make $<stmt_item>.made
    }

    method stmt:sym<d>($/) {
        make $<stmt_item>.made
    }

    method stmt:sym<e>($/) {
        make $<stmt_item>.made
    }

    method stmt:sym<f>($/) {
        make $<full-block_expr>.made
    }

    method stmt:sym<g>($/) {
        make $<block>.made
    }

    method stmt:sym<h>($/) {

    }

    method stmt:sym<i>($/) {
        make $<nonblock_expr>.made
    }

    method stmt:sym<j>($/) {
        MkNone<140397971051360>
    }
}
