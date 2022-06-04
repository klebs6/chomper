use Data::Dump::Tree;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustBlockExpression;
use Chomper::ToRust;
use Chomper::ToRustType;
use Chomper::SnakeCase;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-for-range-loop(
    $item where Cpp::IterationStatement::ForRange, 
    Positional $token-types) 
is export { * }

multi sub translate-for-range-loop(
    $item, 
    Positional $token-types) 
{ 
    say "need write translate-for-range-loop for 
    token-types: {$item.token-types()}";
    ddt $item;
    exit;
}

multi sub translate-for-range-loop(
    $item, 
    [
        'ForRangeDeclaration',
        'ForRangeInitializer::Expression'
    ]) 
{ 
    my $is-ptr-declarator = $item.for-range-declaration.declarator ~~ Cpp::PointerDeclarator;

    my $rust-iter
    = $is-ptr-declarator 
    ?? to-rust($item.for-range-declaration.declarator.no-pointer-declarator)
    !! to-rust($item.for-range-declaration.declarator);

    my $rust-source
    = to-rust(
        $item.for-range-initializer.expression
    );

    Rust::LoopExpressionIterator.new(
        pattern => Rust::Pattern.new(
            pattern-no-top-alts => [
                Rust::IdentifierPattern.new(
                    ref        => False,
                    mutable    => False,
                    identifier => $rust-iter,
                )
            ],
        ),
        expression-nostruct => Rust::SuffixedExpression.new(
            base-expression => Rust::BaseExpression.new(
                expression-item => Rust::PathInExpression.new(
                    path-expr-segments => [
                        Rust::PathExprSegment.new(
                            path-ident-segment => $rust-source,
                        )
                    ]
                )
            ),
            suffixed-expression-suffix => [
                Rust::MethodCallExpressionSuffix.new(
                    path-expr-segment => Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "iter",
                        )
                    )
                )
            ]
        ),
        block-expression => to-rust-block-expression($item.statements)
    )
}

