use Data::Dump::Tree;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRust;
use Chomper::SnakeCase;
use Chomper::Cpp;
use Chomper::Rust;

proto sub translate-postfix-expression(
    $item where Cpp::PostfixExpression, 
    Positional $token-types) 
is export { * }

multi sub translate-postfix-expression(
    $item, 
    Positional $token-types) 
{ 
    say "need write translate-postfix-expression for token-types: {$item.token-types()}";
    ddt $item;
    exit;
}

multi sub translate-postfix-expression(
    $item, 
    [
        'PrimaryExpression::Id',
        'PostfixExpressionTail::IndirectionId',
        'PostfixExpressionTail::Parens',
    ]) 
{ 
    #this one is basically a run of the mill
    #function call on an identifier

    my $body = $item.postfix-expression-body.id-expression;
    my @tail = $item.postfix-expression-tail;

    my $indirection-id = @tail[0];
    my $expr-list      = @tail[1].expression-list;

    my $params 
    = $expr-list ?? to-rust-params($expr-list)>>.gist.join(", ") !! "";

    my $ident 
    = snake-case(to-rust-ident($body).gist);

    my $func 
    = to-rust($indirection-id.id-expression).gist;

    my Bool $indirect = $indirection-id.indirect;

    if $indirect {
        "(*{$ident}).{$func}({$params})"
    } else {
        "{$ident}.{$func}({$params})"
    }
}

multi sub translate-postfix-expression(
    $item, 
    [
        'PrimaryExpression::Id',
        'PostfixExpressionTail::Bracket',
    ]) 
{ 
    my $base 
    = to-rust($item.postfix-expression-body.id-expression);

    my $bracketed-expr 
    = to-rust($item.postfix-expression-tail[0].bracket-tail.expression);

    Rust::SuffixedExpression.new(
        base-expression            => $base,
        suffixed-expression-suffix => [
            Rust::IndexExpressionSuffix.new(
                expression => $bracketed-expr,
            )
        ]
    )
}
