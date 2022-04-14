use Data::Dump::Tree;

use gcpp-roles;

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

our role Literal::Rules {

    proto token literal { * }
    token literal:sym<int>                  { <integer-literal> }
    token literal:sym<char>                 { <character-literal> }
    token literal:sym<float>                { <floating-literal> }

    #Note: are we allowed to have many strings in a row?
    token literal:sym<str>                  { <string-literal> } 

    token literal:sym<bool>                 { <boolean-literal> }
    token literal:sym<ptr>                  { <pointer-literal> }
    token literal:sym<user-defined>         { <user-defined-literal> }
}
