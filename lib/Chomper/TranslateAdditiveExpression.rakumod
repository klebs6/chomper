use Chomper::TranslateIo;
use Chomper::ToRust;
use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

our sub translate-additive-expression(
    $item where Cpp::AdditiveExpression)
{
    Rust::AdditiveExpression.new(

        multiplicative-expression => to-rust($item.multiplicative-expression),
        additive-expression-tail  => $item.additive-expression-tail.List>>.&to-rust,
    )
}

our sub translate-additive-expression-tail(
    $item where Cpp::AdditiveExpressionTail)
{
    Rust::AdditiveExpressionTail.new(
        additive-operator         => to-rust($item.additive-operator),
        multiplicative-expression => to-rust($item.multiplicative-expression),
    )
}

proto sub translate-additive-operator(
    $item where Cpp::IAdditiveOperator) 
is export { * }

multi sub translate-additive-operator(
    $item where Cpp::AdditiveOperator::Plus)
{
    Rust::AdditiveOperator::Plus.new
}


multi sub translate-additive-operator(
    $item where Cpp::AdditiveOperator::Minus)
{
    Rust::AdditiveOperator::Minus.new
}

