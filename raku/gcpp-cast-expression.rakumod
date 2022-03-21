use Data::Dump::Tree;

use gcpp-roles;

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

our role CastExpression::Actions {

    # token cast-token:sym<dyn> { <dynamic_cast> }
    method cast-token:sym<dyn>($/) {
        make CastToken::Dyn.new
    }

    # token cast-token:sym<static> { <static_cast> }
    method cast-token:sym<static>($/) {
        make CastToken::Static.new
    }

    # token cast-token:sym<reinterpret> { <reinterpret_cast> }
    method cast-token:sym<reinterpret>($/) {
        make CastToken::Reinterpret.new
    }

    # token cast-token:sym<const> { <const_cast> }
    method cast-token:sym<const>($/) {
        make CastToken::Const.new
    }

    # rule cast-expression { [ <.left-paren> <the-type-id> <.right-paren> ]* <unary-expression> }
    method cast-expression($/) {

        my $base     = $<unary-expression>.made;
        my @type-ids = $<the-type-id>>>.made.List;

        if @type-ids.elems gt 0 {

            make CastExpression.new(
                unary-expression => $base,
                the-type-ids     => @type-ids,
            )

        } else {

            make $base
        }
    }
}

our role CastExpression::Rules {

    proto token cast-token { * }
    token cast-token:sym<dyn>         { <dynamic_cast> }
    token cast-token:sym<static>      { <static_cast> }
    token cast-token:sym<reinterpret> { <reinterpret_cast> }
    token cast-token:sym<const>       { <const_cast> }

    rule cast-expression {
        [ <left-paren> <the-type-id> <right-paren> ]* <unary-expression>
    }
}
