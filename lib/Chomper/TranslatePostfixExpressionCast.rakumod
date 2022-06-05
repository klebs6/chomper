use Data::Dump::Tree;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustIdent;
use Chomper::ToRustType;
use Chomper::ToRustPathInExpression;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-postfix-expression-cast(
    $item where Cpp::PostfixExpressionCast) 
is export { * }

multi sub translate-postfix-expression-cast(
    $item) 
{ 
    say "need write translate-postfix-expression-cast";

    my $rust-type = to-rust-type($item.the-type-id);
    my $rust-expr = to-rust($item.expression);

    given $item.cast-token {
        when Cpp::CastToken::Const {
            debug "const_cast";
        }
        when Cpp::CastToken::Dyn {
            debug "dyn_cast";
        }
        when Cpp::CastToken::Static {
            debug "static_cast";
        }
        when Cpp::CastToken::Reinterpret {
            debug "reinterpret_cast";
        }
    }

    Rust::CastExpression.new(
        borrow-expression => $rust-expr,
        cast-targets => [
            $rust-type
        ]
    ).gist
}
