use Chomper::Rust;
use Chomper::TranslateIo;
use Chomper::Cpp;

our sub create-suffixed-expression(Str :$single-variable) {
    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => $single-variable,
                        )
                    ),
                ]
            )
        )
    )
}
