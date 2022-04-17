use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;

use Data::Dump::Tree;

proto sub translate-basic-declaration-to-rust(
    Str $mask,
    $item where Cpp::BasicDeclaration) is export { * }

multi sub translate-basic-declaration-to-rust(
    Str $mask,
    $item where Cpp::BasicDeclaration) 
{
    die "need write hook for mask! $mask";
}

multi sub translate-basic-declaration-to-rust(
     "I I = T(Es);",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask I I = T(Es);";
}

multi sub translate-basic-declaration-to-rust(
     "T I(P);",
    $item where Cpp::BasicDeclaration:D) 
{
    debug "mask T I(P);";
    my $type = to-rust-type($item.decl-specifier-seq);
    my $name = to-rust-ident($item.init-declarator-list[0].no-pointer-declarator-base);
    my $params = to-rust-params($item.init-declarator-list[0].no-pointer-declarator-tail[0]);
    ddt $type;
    ddt $name;
    ddt $params;
    ddt $item;
    exit;
}

multi sub translate-basic-declaration-to-rust(
    "T I;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I;";
}

multi sub translate-basic-declaration-to-rust(
    "I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I(Es);";
    ddt $item;
    exit;
}

multi sub translate-basic-declaration-to-rust(
    "I (I);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I (I);";
}

multi sub translate-basic-declaration-to-rust(
    "T I = E;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I = E;";
    ddt $item;
}

#-----------------------
proto sub translate-conditional-expression($item) is export { * }

multi sub translate-conditional-expression($item where Cpp::IntegerLiteral::Oct) {  
    Rust::IntegerLiteral.new(
        value => $item.octal-literal.value
    )
}

multi sub translate-conditional-expression($item where Cpp::IntegerLiteral::Dec) {  
    Rust::IntegerLiteral.new(
        value => $item.decimal-literal.value
    )
}

multi sub translate-conditional-expression($item) {  
    die "need write hook for \
    translate-conditional-expression! {$item.WHAT.^name}";
}

#-----------------------
proto sub to-rust-expression($item) is export { * }

multi sub to-rust-expression($item where Cpp::ConstantExpression)
{
    translate-conditional-expression($item.conditional-expression)
}

multi sub to-rust-expression($item)
{
    die "need write hook for expression! {$item.WHAT.^name}";
}

#-----------------------
proto sub to-rust-index-expression-suffix($item) is export { * }

multi sub to-rust-index-expression-suffix(
    $item where Cpp::NoPointerDeclaratorTail::Bracketed)
{
    my $constant-expr = $item.constant-expression;
    my @attribs       = $item.attribute-specifier-seq.List;

    #TODO may need to check @attribs to see what
    #is going on there...
    die "may need to check this" and ddt @attribs if @attribs[0];

    Rust::IndexExpressionSuffix.new(
        expression => to-rust-expression($constant-expr),
    )

}

multi sub to-rust-index-expression-suffix(
    $item)
{
    die "need write hook for index-expression-suffix! {$item.WHAT.^name}";
}

#-----------------------
proto sub to-rust-suffixed-expression($item) is export { * }

multi sub to-rust-suffixed-expression($item where Cpp::NoPointerDeclarator) {  

    given $item.token-types {
        when ["Identifier", "Bracketed"] {

            my Rust::PathInExpression $expression-item 
            = to-rust-path-in-expression($item.no-pointer-declarator-base);

            my $bracketed     = $item.no-pointer-declarator-tail[0];

            Rust::SuffixedExpression.new(
                base-expression => Rust::BaseExpression.new(
                    expression-item => $expression-item,
                ),
                suffixed-expression-suffix => [
                    to-rust-index-expression-suffix($bracketed)
                ],
            )
        }
        default {
            die "need to consider token-types: $_";
        }
    }
}

multi sub to-rust-suffixed-expression($item where Cpp::IntegerLiteral::Dec) {  
    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::IntegerLiteral.new(
                value => $item.decimal-literal.value
            )
        ),
    )
}

multi sub to-rust-suffixed-expression($item) {  
    die "need write hook for suffixed-expression! {$item.WHAT.^name}";
}

multi sub translate-basic-declaration-to-rust(
    "I[N] = N;",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask I[N] = N;";

    my $lhs = $item.init-declarator-list[0]
    .declarator;

    my $rhs = $item.init-declarator-list[0]
    .initializer
    .brace-or-equal-initializer
    .initializer-clause;

    Rust::ExpressionStatementNoBlock.new(
        expression-noblock => Rust::AssignExpression.new(
            addeq-expressions => [
                to-rust-suffixed-expression($lhs),
                to-rust-suffixed-expression($rhs),
            ]
        )
    ).gist
}

multi sub translate-basic-declaration-to-rust(
    "T I(Es);",
    $item where Cpp::BasicDeclaration) 
{
    debug "mask T I(Es);";

    my $rust-type   = to-rust-type($item.decl-specifier-seq);
    my $rust-ident  = to-rust-ident($item.init-declarator-list[0].declarator);
    my $rust-params = to-rust-params($item.init-declarator-list[0].initializer);

    if $rust-type.gist ~~ /^^ Vec/ {
        qq:to/END/
        let {$rust-ident.gist}: {$rust-type.gist} = vec![{$rust-params.gist}];
        END

    } else {
        qq:to/END/
        let {$rust-ident.gist}: {$rust-type.gist} = {$rust-type.gist}::new({$rust-params.gist});
        END
    }
}
