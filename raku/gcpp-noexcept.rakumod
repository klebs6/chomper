use Data::Dump::Tree;

use gcpp-roles;

# token noe-except-specification:sym<full> { 
#   <noexcept> 
#   <.left-paren> 
#   <constant-expression> 
#   <.right-paren> 
# }
our class NoeExceptSpecification::Full 
does INoeExceptSpecification {
    has IConstantExpression $.constant-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token noe-except-specification:sym<keyword-only> { 
#   <noexcept> 
# }
our class NoeExceptSpecification::KeywordOnly 
does INoeExceptSpecification { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-except-expression { 
#   <noexcept> 
#   <.left-paren> 
#   <expression> 
#   <.right-paren> 
# }
our class NoExceptExpression { 
    has IExpression $.expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role NoExceptExpression::Actions {

    # rule no-except-expression { 
    #   <noexcept> 
    #   <.left-paren> 
    #   <expression> 
    #   <.right-paren> 
    # }
    method no-except-expression($/) {
        make NoExceptExpression.new(
            expression => $<expression>.made,
        )
    }

    # token noe-except-specification:sym<full> { <noexcept> <.left-paren> <constant-expression> <.right-paren> }
    method noe-except-specification:sym<full>($/) {
        make NoeExceptSpecification::Full.new(
            constant-expression => $<constant-expression>.made,
        )
    }

    # token noe-except-specification:sym<keyword-only> { <noexcept> } 
    method noe-except-specification:sym<keyword-only>($/) {
        make NoeExceptSpecification::KeywordOnly.new
    }
}

our role NoExceptExpression::Rules {

    rule no-except-expression {
        <noexcept>
        <left-paren>
        <expression>
        <right-paren>
    }

    proto token noe-except-specification { * }
    token noe-except-specification:sym<full>         { <noexcept> <left-paren> <constant-expression> <right-paren> }
    token noe-except-specification:sym<keyword-only> { <noexcept> }
}