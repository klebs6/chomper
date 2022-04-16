use Data::Dump::Tree;
use Chomper::ToRustIdent;
use Chomper::ToRustPathInExpression;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-postfix-expression-list(
    $item where Cpp::PostfixExpressionList, 
    Positional $token-types) 
is export { * }

multi sub translate-postfix-expression-list(
    $item, 
    Positional $token-types) 
{ 
    say "need write translate-postfix-expression-list for token-types: {$item.token-types()}";
    ddt $item;
    exit;
}

multi sub translate-postfix-expression-list(
    $item, 
    ["Identifier","Parens"]) 
{  
    my Rust::Identifier $identifier 
    = to-rust-ident(
        $item.post-list-head, 
        snake-case => True);

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

multi sub translate-postfix-expression-list(
    $item, 
    ["FullTypeName","Parens"]) 
{  
    my Rust::PathInExpression $expr-item 
    = to-rust-path-in-expression(
        $item.post-list-head, 
        snake-case => True);

    my $rust = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [ ],
            expression-item  => $expr-item,
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ],
    );

    $rust.gist
}
