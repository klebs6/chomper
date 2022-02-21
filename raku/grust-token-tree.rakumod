our class TTDelim {
    has $.token_trees;
}

our class TTTok {
    has $.unpaired_token;
}

our class TokenTree::G {

    proto rule token-trees { * }

    rule token-trees:sym<a> {

    }

    rule token-trees:sym<b> {
        <token-trees> <token-tree>
    }

    proto rule token-tree { * }

    rule token-tree:sym<a> {
        <delimited-token_trees>
    }

    rule token-tree:sym<b> {
        <unpaired-token>
    }

    proto rule delimited-token_trees { * }

    rule delimited-token_trees:sym<a> {
        <parens-delimited_token_trees>
    }

    rule delimited-token_trees:sym<b> {
        <braces-delimited_token_trees>
    }

    rule delimited-token_trees:sym<c> {
        <brackets-delimited_token_trees>
    }

    rule parens-delimited_token_trees {
        '(' <token-trees> ')'
    }

    rule braces-delimited_token_trees {
        '{' <token-trees> '}'
    }

    rule brackets-delimited_token_trees {
        '[' <token-trees> ']'
    }
}

our class TokenTree::A {

    method token-trees:sym<a>($/) {
        make TokenTrees.new(

        )
    }

    method token-trees:sym<b>($/) {
        ExtNode<140250172947112>
    }

    method token-tree:sym<a>($/) {
        make $<delimited-token_trees>.made
    }

    method token-tree:sym<b>($/) {
        make TTTok.new(
            unpaired-token =>  $<unpaired-token>.made,
        )
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
        make TTDelim.new(
            token-trees =>  $<token-trees>.made,
        )
    }

    method braces-delimited_token_trees($/) {
        make TTDelim.new(
            token-trees =>  $<token-trees>.made,
        )
    }

    method brackets-delimited_token_trees($/) {
        make TTDelim.new(
            token-trees =>  $<token-trees>.made,
        )
    }
}

