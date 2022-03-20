# token the-operator:sym<new> { 
#   <new_> 
#   [ <.left-bracket> <.right-bracket>]? 
# }
our class TheOperator::New does ITheOperator { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<delete> { <delete> [ <.left-bracket> <.right-bracket>]? }
our class TheOperator::Delete does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<plus> { <plus> }
our class TheOperator::Plus does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<minus> { <minus> }
our class TheOperator::Minus does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<star> { <star> }
our class TheOperator::Star does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<div_> { <div_> }
our class TheOperator::Div does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<mod_> { <mod_> }
our class TheOperator::Mod does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<caret> { <caret> }
our class TheOperator::Caret does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<and_> { <and_> <!before <and_>> }
our class TheOperator::And does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<or_> { <or_> }
our class TheOperator::Or does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<tilde> { <tilde> }
our class TheOperator::Tilde does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<not> { <not_> }
our class TheOperator::Not does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<assign> { <assign> }
our class TheOperator::Assign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<greater> { <greater> }
our class TheOperator::Greater does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<less> { <less> }
our class TheOperator::Less does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<greater-equal> { <greater-equal> }
our class TheOperator::GreaterEqual does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<plus-assign> { <plus-assign> }
our class TheOperator::PlusAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<minus-assign> { <minus-assign> }
our class TheOperator::MinusAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<star-assign> { <star-assign> }
our class TheOperator::StarAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<mod-assign> { <mod-assign> }
our class TheOperator::ModAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<xor-assign> { <xor-assign> }
our class TheOperator::XorAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<and-assign> { <and-assign> }
our class TheOperator::AndAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<or-assign> { <or-assign> }
our class TheOperator::OrAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<LessLess> { <less> <less> }
our class TheOperator::LessLess does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<GreaterGreater> { <greater> <greater> }
our class TheOperator::GreaterGreater does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<right-shift-assign> { <right-shift-assign> }
our class TheOperator::RightShiftAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<left-shift-assign> { <left-shift-assign> }
our class TheOperator::LeftShiftAssign does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<equal> { <equal> }
our class TheOperator::Equal does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<not-equal> { <not-equal> }
our class TheOperator::NotEqual does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<less-equal> { <less-equal> }
our class TheOperator::LessEqual does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<and-and> { <and-and> }
our class TheOperator::AndAnd does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<or-or> { <or-or> }
our class TheOperator::OrOr does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<plus-plus> { <plus-plus> }
our class TheOperator::PlusPlus does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<minus-minus> { <minus-minus> }
our class TheOperator::MinusMinus does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<comma> { <.comma> }
our class TheOperator::Comma does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<arrow-star> { <arrow-star> }
our class TheOperator::ArrowStar does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<arrow> { <arrow> }
our class TheOperator::Arrow does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<Parens> { <.left-paren> <.right-paren> }
our class TheOperator::Parens does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token the-operator:sym<Brak> { <.left-bracket> <.right-bracket> }
our class TheOperator::Brak does ITheOperator { 
    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

