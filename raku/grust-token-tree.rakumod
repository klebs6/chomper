use grust-model;


our role TokenTree::Rules {

    rule token-trees { <token-tree>* }

    proto rule token-tree { * }

    rule token-tree:sym<a> { <delimited-token_trees> }
    rule token-tree:sym<b> { <unpaired-token> }

    proto rule delimited-token_trees { * }

    rule delimited-token_trees:sym<a> { <parens-delimited_token_trees> }
    rule delimited-token_trees:sym<b> { <braces-delimited_token_trees> }
    rule delimited-token_trees:sym<c> { <brackets-delimited_token_trees> }

    rule parens-delimited_token_trees   { '(' <token-trees> ')' }
    rule braces-delimited_token_trees   { '{' <token-trees> '}' }
    rule brackets-delimited_token_trees { '[' <token-trees> ']' }
}

our role TokenTree::Actions {

    method token-trees($/) {
        make $<token-tree>>.made
    }

    method token-tree:sym<a>($/) {
        make $<delimited-token_trees>.made
    }

    method token-tree:sym<b>($/) {
        make $<unpaired-token>.made
    }

    method delimited-token_trees:sym<a>($/) {
        make $<parens-delimited_token_trees>.made
    }

    method delimited-token_trees:sym<b>($/) {
        make $<braces-delimited_token_trees>.made
    }

    method delimited-token_trees:sym<c>($/) {
        make $<brackets-delimited_token_trees>.made
    }

    method parens-delimited_token_trees($/) {
        make $<token-trees>.made
    }

    method braces-delimited_token_trees($/) {
        make $<token-trees>.made
    }

    method brackets-delimited_token_trees($/) {
        make $<token-trees>.made
    }
}
