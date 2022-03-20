
# rule cast-expression { 
#   [ <.left-paren> <the-type-id> <.right-paren> ]* 
#   <unary-expression> 
# }
our class CastExpression does ICastExpression { 
    has ITheTypeId       @.the-type-ids     is required;
    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<dyn> { <dynamic_cast> }
our class CastToken::Dyn does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<static> { <static_cast> }
our class CastToken::Static does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<reinterpret> { <reinterpret_cast> }
our class CastToken::Reinterpret does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token cast-token:sym<const> { <const_cast> }
our class CastToken::Const does ICastToken { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
