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

multi sub translate-postfix-expression(
    $item, 
    [
        'PrimaryExpression::Id',
        'PostfixExpressionTail::IndirectionId',
        'PostfixExpressionTail::Parens',
        'PostfixExpressionTail::Bracket',
    ]) 
{ 
    my $body = $item.postfix-expression-body.id-expression;
    my @tail = $item.postfix-expression-tail;

    my $indirection-id    = @tail[0];
    my $expr-list         = @tail[1].expression-list;

    my $rust-bracket-expr = to-rust(@tail[2].bracket-tail.expression);

    my $params 
    = $expr-list ?? to-rust-params($expr-list)>>.gist.join(", ") !! "";

    my $ident 
    = snake-case(to-rust-ident($body).gist);

    my $func 
    = to-rust($indirection-id.id-expression).gist;

    my Bool $indirect = $indirection-id.indirect;

    if $indirect {
        "(*{$ident}).{$func}({$params})[$rust-bracket-expr]"
    } else {
        "{$ident}.{$func}({$params})[$rust-bracket-expr]"
    }
}

multi sub translate-postfix-expression(
    $item, 
    [
        'PrimaryExpression::Id',
        'PostfixExpressionTail::IndirectionId',
        'PostfixExpressionTail::Parens',
        'PostfixExpressionTail::IndirectionId',
        'PostfixExpressionTail::Parens',
    ]) 
{ 
    my $body = $item.postfix-expression-body.id-expression;
    my @tail = $item.postfix-expression-tail;

    my $indirection-idA = @tail[0];
    my $expr-listA      = @tail[1].expression-list;
    my $indirection-idB = @tail[2];
    my $expr-listB      = @tail[3].expression-list;

    my $paramsA 
    = $expr-listA ?? to-rust-params($expr-listA)>>.gist.join(", ") !! "";

    my $paramsB 
    = $expr-listB ?? to-rust-params($expr-listB)>>.gist.join(", ") !! "";

    my $ident 
    = snake-case(to-rust-ident($body).gist);

    my $funcA 
    = to-rust($indirection-idA.id-expression).gist;

    my $funcB 
    = to-rust($indirection-idB.id-expression).gist;

    my Bool $indirectA = $indirection-idA.indirect;
    my Bool $indirectB = $indirection-idB.indirect;

    if $indirectA {

        if $indirectB {
            "(*(*{$ident}).{$funcA}({$paramsA})).{$funcB}({$paramsB})"
        } else {
            "(*{$ident}).{$funcA}({$paramsA}).{$funcB}({$paramsB})"
        }

    } else {

        if $indirectB {
            "(*{$ident}.{$funcA}({$paramsA})).{$funcB}({$paramsB})"
        } else {
            "{$ident}.{$funcA}({$paramsA}).{$funcB}({$paramsB})"
        }
    }
}

multi sub translate-postfix-expression(
    $item, 
    [
        'PrimaryExpression::Id',
        'PostfixExpressionTail::PlusPlus',
    ]) 
{ 
    my $body = $item.postfix-expression-body.id-expression;

    my $ident 
    = snake-case(to-rust-ident($body).gist);

    Rust::AddEqExpression.new(
        minuseq-expressions => [
            $ident,
            Rust::IntegerLiteral.new(
                value => 1
            )
        ]
    ).gist
}
