
our role Literal::Actions {

    # token literal:sym<int> { <integer-literal> }
    method literal:sym<int>($/) {
        make $<integer-literal>.made
    }

    # token literal:sym<char> { <character-literal> }
    method literal:sym<char>($/) {
        make $<character-literal>.made,
    }

    # token literal:sym<float> { <floating-literal> } 
    method literal:sym<float>($/) {
        make $<floating-literal>.made,
    }

    # token literal:sym<str> { <string-literal> }
    method literal:sym<str>($/) {
        make $<string-literal>.made,
    }

    # token literal:sym<bool> { <boolean-literal> }
    method literal:sym<bool>($/) {
        make $<boolean-literal>.made
    }

    # token literal:sym<ptr> { <pointer-literal> }
    method literal:sym<ptr>($/) {
        make $<pointer-literal>.made
    }

    # token literal:sym<user-defined> { <user-defined-literal> }
    method literal:sym<user-defined>($/) {
        make $<user-defined-literal>.made
    }
}
