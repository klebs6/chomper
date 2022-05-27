use Data::Dump::Tree;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRust;
use Chomper::SnakeCase;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-no-pointer-declarator(
    $item where Cpp::NoPointerDeclarator, 
    Positional $token-types) 
is export { * }

multi sub translate-no-pointer-declarator(
    $item, 
    Positional $token-types) 
{ 
    say "need write translate-no-pointer-declarator for 
    token-types: {$item.token-types()}";
    ddt $item;
    exit;
}

multi sub translate-no-pointer-declarator(
    $item, 
    [
        'Identifier', 
        'Bracketed'
    ]) 
{ 
    say "will translate-no-pointer-declarator for 
    token-types: {$item.token-types()}";

    my $bracketed-expr =
    to-rust($item.no-pointer-declarator-tail[0].constant-expression);

    Rust::SuffixedExpression.new(
        base-expression            => to-rust($item.no-pointer-declarator-base),
        suffixed-expression-suffix => [
            Rust::IndexExpressionSuffix.new(
                expression => $bracketed-expr,
            )
        ]
    )
}

multi sub translate-no-pointer-declarator(
    $item, 
    [
        'Identifier', 
        'Bracketed',
        'Bracketed'
    ]) 
{ 
    say "will translate-no-pointer-declarator for 
    token-types: {$item.token-types()}";

    my $bracketed-expr1 =
    to-rust($item.no-pointer-declarator-tail[0].constant-expression);

    my $bracketed-expr2 =
    to-rust($item.no-pointer-declarator-tail[1].constant-expression);

    Rust::SuffixedExpression.new(
        base-expression            => to-rust($item.no-pointer-declarator-base),
        suffixed-expression-suffix => [
            Rust::IndexExpressionSuffix.new(
                expression => $bracketed-expr1,
            ),
            Rust::IndexExpressionSuffix.new(
                expression => $bracketed-expr2,
            ),
        ]
    )
}
