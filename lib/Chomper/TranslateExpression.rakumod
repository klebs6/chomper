use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;

use Data::Dump::Tree;

use Chomper::TranslateConditionalExpression;

proto sub to-rust-expression($item) is export { * }

multi sub to-rust-expression($item where Cpp::ConstantExpression)
{
    translate-conditional-expression($item.conditional-expression)
}

multi sub to-rust-expression($item)
{
    die "need write hook for expression! {$item.WHAT.^name}";
}
