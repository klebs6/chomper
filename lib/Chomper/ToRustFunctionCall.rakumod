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

proto sub to-rust-function-call($item) is export { * }

multi sub to-rust-function-call($item where Cpp::InitDeclarator)
{
    my $name            = to-rust-path-in-expression($item.declarator);
    my @function-params = to-rust-params($item.initializer.expression-list);

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => $name,
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => @function-params,
            )
        ]
    )
}

