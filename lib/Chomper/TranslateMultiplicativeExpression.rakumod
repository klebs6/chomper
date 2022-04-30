use Chomper::TranslateIo;
use Chomper::ToRust;
use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

our sub translate-multiplicative-expression(
    $item where Cpp::MultiplicativeExpression)
{
    Rust::MultiplicativeExpression.new(
        cast-expression                => to-rust($item.pointer-member-expression),
        multiplicative-expression-tail => $item.multiplicative-expression-tail.List>>.&to-rust,
    ).gist
}

our sub translate-multiplicative-expression-tail(
    $item where Cpp::MultiplicativeExpressionTail)
{
    Rust::MultiplicativeExpressionTail.new(
        multiplicative-operator => to-rust($item.multiplicative-operator),
        cast-expression         => to-rust($item.pointer-member-expression),
    )
}

proto sub translate-multiplicative-operator($item where Cpp::IMultiplicativeOperator) is export { * }

multi sub translate-multiplicative-operator(
    $item where Cpp::MultiplicativeOperator::Star)
{
    Rust::MultiplicativeOperator::Star.new
}

multi sub translate-multiplicative-operator(
    $item where Cpp::MultiplicativeOperator::Slash)
{
    Rust::MultiplicativeOperator::Slash.new
}

multi sub translate-multiplicative-operator(
    $item where Cpp::MultiplicativeOperator::Mod)
{
    Rust::MultiplicativeOperator::Mod.new
}
