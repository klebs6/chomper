use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;

use Data::Dump::Tree;

use Chomper::TranslateExpression;

proto sub to-rust-index-expression-suffix($item) is export { * }

multi sub to-rust-index-expression-suffix(
    $item where Cpp::NoPointerDeclaratorTail::Bracketed)
{
    my $constant-expr = $item.constant-expression;
    my @attribs       = $item.attribute-specifier-seq.List;

    #TODO may need to check @attribs to see what
    #is going on there...
    die "may need to check this" and ddt @attribs if @attribs[0];

    Rust::IndexExpressionSuffix.new(
        expression => to-rust-expression($constant-expr),
    )

}

multi sub to-rust-index-expression-suffix(
    $item)
{
    die "need write hook for index-expression-suffix! {$item.WHAT.^name}";
}
