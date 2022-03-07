use Data::Dump::Tree;

use grust-model;

our class TokenTree {
    has $.tree;
    has $.leaf;

    has $.text;

    method gist {

        if $.leaf {
            $.leaf.gist
        } else {
            $.tree>>.gist.join("")
        }
    }
}

our class BracesDelimitedTokenTrees {
    has $.trees;

    has $.text;

    method gist {
        "{" ~ $.trees>>.gist.join("") ~ "}"
    }
}

our class BracketsDelimitedTokenTrees {
    has $.trees;

    has $.text;

    method gist {
        "[" ~ $.trees>>.gist.join("") ~ "]"
    }
}

our class ParensDelimitedTokenTrees {
    has $.trees;

    has $.text;

    method gist {
        "(" ~ $.trees>>.gist.join("") ~ ")"
    }
}

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
        make TokenTree.new(
            tree => $<delimited-token-trees>.made
        )
    }

    method token-tree:sym<b>($/) {
        make TokenTree.new(
            leaf => $<unpaired-token>.made
        )
    }

    method delimited-token-trees:sym<a>($/) {
        make ParensDelimitedTokenTrees.new(
            trees => $<parens-delimited-token-trees>.made
        )
    }

    method delimited-token-trees:sym<b>($/) {
        make BracesDelimitedTokenTrees.new(
            trees => $<braces-delimited-token-trees>.made
        )
    }

    method delimited-token-trees:sym<c>($/) {
        make BracketsDelimitedTokenTrees.new(
            trees => $<brackets-delimited-token-trees>.made
        )
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
