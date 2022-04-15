unit module Chomper::Cpp::GcppBalanced;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule balanced-token-seq { <balancedrule>+ }
our class BalancedTokenSeq { 
    has IBalancedrule @.balancedrules is required;

    has $.text;

    method gist(:$treemark=False) {
        @.balancedrules>>.gist(:$treemark).join(" ")
    }
}


# rule balancedrule:sym<parens> { 
#   <.left-paren> 
#   <balanced-token-seq> 
#   <.right-paren> 
# }
our class Balancedrule::Parens does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;

    has $.text;

    method gist(:$treemark=False) {
        "(" ~ $.balanced-token-seq.gist(:$treemark) ~ ")"
    }
}

# rule balancedrule:sym<brackets> { 
#   <.left-bracket> 
#   <balanced-token-seq> 
#   <.right-bracket> 
# }
our class Balancedrule::Brackets does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;

    has $.text;

    method gist(:$treemark=False) {
        "[" ~ $.balanced-token-seq ~ "]"
    }
}

# rule balancedrule:sym<braces> { 
#   <.left-brace> 
#   <balanced-token-seq> 
#   <.right-brace> 
# } 
our class Balancedrule::Braces does IBalancedrule {
    has BalancedTokenSeq $.balanced-token-seq is required;

    has $.text;

    method gist(:$treemark=False) {
        "{" ~ $.balanced-token-seq ~ "}"
    }
}

our role Balanced::Actions {

    # rule balanced-token-seq { <balancedrule>+ } 
    method balanced-token-seq($/) {
        make $<balancedrule>>>.made
    }

    # rule balancedrule:sym<parens> { <.left-paren> <balanced-token-seq> <.right-paren> }
    method balancedrule:sym<parens>($/) {
        make $<balanced-token-seq>.made
    }

    # rule balancedrule:sym<brackets> { <.left-bracket> <balanced-token-seq> <.right-bracket> }
    method balancedrule:sym<brackets>($/) {
        make $<balanced-token-seq>.made
    }

    # rule balancedrule:sym<braces> { <.left-brace> <balanced-token-seq> <.right-brace> } 
    method balancedrule:sym<braces>($/) {
        make $<balanced-token-seq>.made
    }
}

our role Balanced::Rules {

    rule balanced-token-seq {
        <balancedrule>+
    }

    proto rule balancedrule { * }
    rule balancedrule:sym<parens>   { <left-paren> <balanced-token-seq> <right-paren> }
    rule balancedrule:sym<brackets> { <left-bracket> <balanced-token-seq> <right-bracket> }
    rule balancedrule:sym<braces>   { <left-brace> <balanced-token-seq> <right-brace> }
}