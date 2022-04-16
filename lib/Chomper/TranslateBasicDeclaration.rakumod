use Chomper::Cpp;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;

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
proto sub to-rust-suffixed-expression($item) is export { * }

multi sub to-rust-suffixed-expression($item where Cpp::NoPointerDeclarator) {  

    say "might want to use something like
    a treemask here to make sure we do it right";

    my Rust::PathInExpression $expression-item 
    = to-rust-path-in-expression($item.no-pointer-declarator-base);

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => $expression-item,
        ),
        suffixed-expression-suffix => [
            #TODO fixme! got tired and ptfo

        ],
    )
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
