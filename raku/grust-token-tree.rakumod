use grust-model;

our role TokenTree::Rules {

    rule token-trees { <token-tree>* }

    proto rule token-tree { * }

    rule token-tree:sym<b> { <unpaired-token> }
    rule token-tree:sym<a> { <delimited-token-trees> }

    proto rule delimited-token-trees { * }

    rule delimited-token-trees:sym<a> { <parens-delimited-token-trees> }
    rule delimited-token-trees:sym<b> { <braces-delimited-token-trees> }
    rule delimited-token-trees:sym<c> { <brackets-delimited-token-trees> }

    rule parens-delimited-token-trees   { '(' <token-trees> ')' }
    rule braces-delimited-token-trees   { '{' <token-trees> '}' }
    rule brackets-delimited-token-trees { '[' <token-trees> ']' }
}

our role TokenTree::Actions {

    method token-trees($/) {
        make $<token-tree>>>.made
    }

    method token-tree:sym<a>($/) {
        make $<delimited-token-trees>.made
    }

    method token-tree:sym<b>($/) {
        make $<unpaired-token>.made
    }

    method delimited-token-trees:sym<a>($/) {
        make $<parens-delimited-token-trees>.made
    }

    method delimited-token-trees:sym<b>($/) {
        make $<braces-delimited-token-trees>.made
    }

    method delimited-token-trees:sym<c>($/) {
        make $<brackets-delimited-token-trees>.made
    }

    method parens-delimited-token-trees($/) {
        make $<token-trees>.made
    }

    method braces-delimited-token-trees($/) {
        make $<token-trees>.made
    }

    method brackets-delimited-token-trees($/) {
        make $<token-trees>.made
    }
}
