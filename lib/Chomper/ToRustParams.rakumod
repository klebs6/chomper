use Chomper::Cpp;
use Chomper::Rust;
use Chomper::TranslateIo;
use Chomper::ToRustIdent;
use Chomper::ToRust;
use Data::Dump::Tree;

our sub octal-to-int($octal-value) {
    $octal-value.Num
}

our sub hex-to-int($hex-value) {
    say $hex-value.gist;
    exit;
    $hex-value.Num
}

proto sub to-rust-param($x) is export { * }

multi sub to-rust-param($x where Cpp::IntegerLiteral::Dec) {  
    Rust::IntegerLiteral.new(
        value => $x.decimal-literal.value,
    ).gist
}

multi sub to-rust-param($x where Cpp::IntegerLiteral::Oct) {  
    Rust::IntegerLiteral.new(
        #value => octal-to-int($x.octal-literal.value),
        value => $x.octal-literal.value,
    ).gist
}

multi sub to-rust-param($x where Cpp::IntegerLiteral::Hex) {  
    Rust::IntegerLiteral.new(
        value => $x.hexadecimal-literal.value,
    ).gist
}

multi sub to-rust-param($x where Cpp::CharacterLiteral) {  
    Rust::CharLiteral.new(
        value => $x.gist,
    ).gist
}

multi sub to-rust-param($x where Cpp::PostfixExpression) {  
    #translate-postfix-expression($x, $x.token-types)
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::UnaryExpressionCase::UnaryOp) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::StringLiteral) {  
    Rust::StringLiteral.new(
        value => $x.value
    ).gist
}

multi sub to-rust-param($x where Cpp::PrimaryExpression::Id) {  
    to-rust-ident($x.id-expression)
}

multi sub to-rust-param($x where Cpp::EqualityExpression) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::AdditiveExpression) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::CastExpression) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::MultiplicativeExpression) {  
    to-rust($x)
}

multi sub to-rust-param(
    $item where Cpp::ConditionalExpression)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::PostfixExpressionList)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::BracedInitList)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::InclusiveOrExpression)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::AndExpression)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::BooleanLiteral::T)
{
    to-rust($item)
}

multi sub to-rust-param($x where Cpp::ParameterDeclaration) {  
    do given $x.token-types {
        when [Nil,'TypeSpecifier',Nil,Nil] {
            ddt $x;
            say "here";
            exit;
        }
        default {
            die "need implement for token-types: {$x.token-types}";
        }
    }
}

multi sub to-rust-param($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}

#-------------------------
proto sub to-rust-params($x) is export { * }

multi sub to-rust-params($x where Cpp::Initializer::ParenExprList) {  
    do for $x.expression-list.initializer-list.clauses {
        to-rust-param($_)
    }
}

multi sub to-rust-params($x where Cpp::ParametersAndQualifiers) {  
    do for $x.parameter-declaration-clause.parameter-declaration-list {
        to-rust-param($_)
    }
}

multi sub to-rust-params($x where Cpp::ExpressionList) {  

    my @clauses = $x.initializer-list.clauses;

    do for @clauses {
        to-rust-param($_)
    }
}

multi sub to-rust-params($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
