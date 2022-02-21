our class BlockOrIf::G {

    proto rule block-or_if { * }

    rule block-or_if:sym<a> {
        <block>
    }

    rule block-or_if:sym<b> {
        <expr-if>
    }

    rule block-or_if:sym<c> {
        <expr-if_let>
    }
}

our class BlockOrIf::A {

    method block-or_if:sym<a>($/) {
        make $<block>.made
    }

    method block-or_if:sym<b>($/) {
        make $<expr-if>.made
    }

    method block-or_if:sym<c>($/) {
        make $<expr-if_let>.made
    }
}
