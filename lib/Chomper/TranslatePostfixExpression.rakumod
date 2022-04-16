use Data::Dump::Tree;
use Chomper::ToRustIdent;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-postfix-expression(
    $item where Cpp::PostfixExpression, 
    Positional $token-types) 
is export { * }

multi sub translate-postfix-expression(
    $item, 
    Positional $token-types) 
{ 
    say "need write translate-postfix-expression for token-types: {$item.token-types()}";
    ddt $item;
    exit;
}
