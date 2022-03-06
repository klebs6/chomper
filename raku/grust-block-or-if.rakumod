use Data::Dump::Tree;

our role BlockOrIf::Rules {
    proto rule block-or-if { * }
    rule block-or-if:sym<block>       { <block> }
    rule block-or-if:sym<expr-if>     { <expr-if> }
    rule block-or-if:sym<expr-if-let> { <expr-if-let> }
}

our role BlockOrIf::Actions {
    method block-or-if:sym<block>($/)       { make $<block>.made }
    method block-or-if:sym<expr-if>($/)     { make $<expr-if>.made }
    method block-or-if:sym<expr-if-let>($/) { make $<expr-if-let>.made }
}
