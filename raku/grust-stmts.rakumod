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
    has @.stmts;
    has $.nonblock-expr;
}

our class Stmts::Rules {

    rule maybe-stmts { <stmts>? <nonblock-expr>? }

    rule stmts { <stmt>+ }

    proto rule stmt { * }
    rule stmt:sym<a> { <maybe-outer-attrs> <let> }
    rule stmt:sym<b> { <stmt-item> }
    rule stmt:sym<c> { <PUB> <stmt-item> }
    rule stmt:sym<d> { <outer-attrs> <stmt-item> }
    rule stmt:sym<e> { <outer-attrs> <PUB> <stmt-item> }
    rule stmt:sym<f> { <full-block-expr> }
    rule stmt:sym<g> { <maybe-outer-attrs> <block> }
    rule stmt:sym<h> { <nonblock-expr> ';' }
    rule stmt:sym<i> { <outer-attrs> <nonblock-expr> ';' }
    rule stmt:sym<j> { ';' }
}

our class Stmts::Actions {

    method maybe-stmts:sym<a>($/) {
        make Stmts.new(
            stmts         => $<stmts>.made,
            nonblock-expr => $<nonblock-expr>.made,
        )
    }

    method stmts($/) {
        make $<stmt>>>.made
    }

    method stmt:sym<a>($/) { make $<let>.made }
    method stmt:sym<b>($/) { make $<stmt-item>.made }
    method stmt:sym<c>($/) { make $<stmt-item>.made }
    method stmt:sym<d>($/) { make $<stmt-item>.made }
    method stmt:sym<e>($/) { make $<stmt-item>.made }
    method stmt:sym<f>($/) { make $<full-block-expr>.made }
    method stmt:sym<g>($/) { make $<block>.made }
    method stmt:sym<h>($/) { }
    method stmt:sym<i>($/) { make $<nonblock-expr>.made }
    method stmt:sym<j>($/) { }
}
