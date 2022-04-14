use Data::Dump::Tree;
use to-rust-ident;
use gcpp-postfix-expression;
use grust-expressions;
use grust-path-expressions;

proto sub translate-postfix-expression-list(Cpp::PostfixExpressionList $item, Positional $token-types) 
is export { * }

multi sub translate-postfix-expression-list(Cpp::PostfixExpressionList $item, Positional $token-types) {  
    say "need write translate-postfix-expression-list for token-types: {$item.token-types()}";
    ddt $item;
    exit;
}

multi sub translate-postfix-expression-list(Cpp::PostfixExpressionList $item, ["Identifier","PostListTail::Parens"]) {  

    my Rust::Identifier $identifier = to-rust-ident($item.post-list-head);

    my $rust = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [ ],
            expression-item  => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => $identifier,
                        maybe-generic-args => Nil,
                    ),
                ],
            ),
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ],
    );

    $rust.gist
}
