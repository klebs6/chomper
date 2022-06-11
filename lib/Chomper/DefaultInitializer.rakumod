use Chomper::Cpp;
use Chomper::Rust;
use Chomper::SnakeCase;

our sub create-default-initializer($rust-type) 
{
    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => $rust-type,
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "default"
                        )
                    ),
                ],
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ],
    )
}
