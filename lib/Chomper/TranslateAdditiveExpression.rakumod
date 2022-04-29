use Chomper::TranslateIo;
use Chomper::Cpp;
use Chomper::Rust;

use Data::Dump::Tree;

proto sub translate-additive-expression-with-mask(
    $mask,
    $item where Cpp::AdditiveExpression) { * }

multi sub translate-additive-expression-with-mask(
    $mask,
    $item where Cpp::AdditiveExpression)
{
    ddt $item;
    die "need implement for mask: $mask";
    exit;
}

multi sub translate-additive-expression-with-mask(
    "E + E",
    $item where Cpp::AdditiveExpression)
{
    debug "will translate AdditiveExpression for mask: E + E";
    ddt $item;
    exit;
}

our sub translate-additive-expression(
    $item where Cpp::AdditiveExpression)
{
    debug "will translate AdditiveExpression to Rust!";
    translate-additive-expression-with-mask($item.additive-mask, $item)
}
