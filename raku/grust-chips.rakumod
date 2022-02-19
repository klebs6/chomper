
our role DelimitedTokenTrees {

    proto token delimited-token-trees { * }

    token delimited-token-trees:sym<parens> {
        <parens-delimited-token-trees>
    }

    token delimited-token-trees:sym<braces> {
        <braces-delimited-token-trees>
    }

    token delimited-token-trees:sym<brackets> {
        <brackets-delimited-token-trees>
    }
}

