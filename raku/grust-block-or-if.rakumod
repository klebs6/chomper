our class BlockOrIf::Rules {
    proto rule block-or_if { * }
    rule block-or_if:sym<block>       { <block> }
    rule block-or_if:sym<expr-if>     { <expr-if> }
    rule block-or_if:sym<expr-if-let> { <expr-if-let> }
}

our class BlockOrIf::Actions {
    method block-or_if:sym<block>($/)       { make $<block>.made }
    method block-or_if:sym<expr-if>($/)     { make $<expr-if>.made }
    method block-or_if:sym<expr-if-let>($/) { make $<expr-if-let>.made }
}
