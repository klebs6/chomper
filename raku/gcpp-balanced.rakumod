
# rule balanced-token-seq { <balancedrule>+ }
our class BalancedTokenSeq { 
    has IBalancedrule @.balancedrules is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
