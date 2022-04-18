unit module Chomper::Cpp::GcppCastExpression;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule cast-expression { 
#   [ <.left-paren> <the-type-id> <.right-paren> ]* 
#   <unary-expression> 
# }
class CastExpression does ICastExpression is export { 
    has ITheTypeId       @.the-type-ids     is required;
    has IUnaryExpression $.unary-expression is required;

    has $.text;

    method name {
        'CastExpression'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        for @.the-type-ids {
            $builder ~= "(" ~ $_.gist(:$treemark) ~ ") ";
        }

        $builder ~ $.unary-expression.gist(:$treemark)
    }
}

package CastToken is export {

    # token cast-token:sym<dyn> { <dynamic_cast> }
    our class Dyn does ICastToken { 

        has $.text;

        method name {
            'CastToken::Dyn'
        }

        method gist(:$treemark=False) {
            "dynamic_cast"
        }
    }

    # token cast-token:sym<static> { <static_cast> }
    our class Static does ICastToken { 

        has $.text;

        method name {
            'CastToken::Static'
        }

        method gist(:$treemark=False) {
            "static_cast"
        }
    }

    # token cast-token:sym<reinterpret> { <reinterpret_cast> }
    our class Reinterpret does ICastToken { 

        has $.text;

        method name {
            'CastToken::Reinterpret'
        }

        method gist(:$treemark=False) {
            "reinterpret_cast"
        }
    }

    # token cast-token:sym<const> { <const_cast> }
    our class Const does ICastToken { 

        has $.text;

        method name {
            'CastToken::Const'
        }

        method gist(:$treemark=False) {
            "const_cast"
        }
    }
}

package CastExpressionGrammar is export {

    our role Actions {

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
                    text             => ~$/,
                )

            } else {

                make $base
            }
        }
    }

    our role Rules {

        proto token cast-token { * }
        token cast-token:sym<dyn>         { <dynamic_cast> }
        token cast-token:sym<static>      { <static_cast> }
        token cast-token:sym<reinterpret> { <reinterpret_cast> }
        token cast-token:sym<const>       { <const_cast> }

        rule cast-expression {
            [ <left-paren> <the-type-id> <right-paren> ]* <unary-expression>
        }
    }
}
