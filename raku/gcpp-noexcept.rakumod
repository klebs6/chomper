
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
