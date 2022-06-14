use Data::Dump::Tree;
use Chomper::ToRust;
use Chomper::ToRustIdent;
use Chomper::ToRustType;
use Chomper::ToRustBaseExpression;
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

    my $expr-list 
    = 
    $item.post-list-tail.value.Bool 
    ?? to-rust($item.post-list-tail.value.initializer-list)
    !! "";

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
                maybe-call-params => $expr-list,
            )
        ],
    );

    $rust.gist
}

multi sub translate-postfix-expression-list(
    $item, 
    ["Identifier","Braces"]) 
{  
    my $rust-type 
    = to-rust-type(
        $item.post-list-head);

    my $expr-list 
    = 
    $item.post-list-tail.value.initializer-list 
    ?? to-rust($item.post-list-tail.value.initializer-list)
    !! "";

    my $rust = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [ ],
            expression-item  => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => $rust-type,
                        maybe-generic-args => Nil,
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "new"
                        ),
                        maybe-generic-args => Nil,
                    ),
                ],
            ),
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => $expr-list,
            )
        ],
    );

    $rust.gist
}

multi sub translate-postfix-expression-list(
    $item, 
    ["FullTypeName","Parens"]) 
{  
    my $base-expr 
    = to-rust-base-expression($item.post-list-head);

    my $expr-list = do if $item.post-list-tail.value {

        to-rust($item.post-list-tail.value.initializer-list)

    } else {

        Nil
    };

    my $rust = Rust::SuffixedExpression.new(
        base-expression => $base-expr,
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => $expr-list,
            )
        ],
    );

    $rust.gist
}

multi sub translate-postfix-expression-list(
    $item, 
    ["FullTypeName","Braces"]) 
{  
    my $expr-item 
    = to-rust-type($item.post-list-head);

    my $expr-list = do if $item.post-list-tail.value {

        to-rust($item.post-list-tail.value.initializer-list)

    } else {

        Nil
    };

    my $rust = Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            outer-attributes => [ ],
            expression-item  => $expr-item,
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => $expr-list,
            )
        ],
    );

    $rust.gist
}

multi sub translate-postfix-expression-list(
    $item, 
    [
        'SimpleTemplateId', 
        'Parens',
    ]) 
{ 
    translate-postfix-expression-list($item, ["FullTypeName", "Parens"])
}
