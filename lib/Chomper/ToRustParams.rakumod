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

multi sub to-rust-param($x where Cpp::PointerLiteral) {  
    Rust::Identifier.new(
        value => "None",
    ).gist
}

multi sub to-rust-param($x where Cpp::IntegerLiteral::Oct) {  
    Rust::IntegerLiteral.new(
        #value => octal-to-int($x.octal-literal.value),
        value => $x.octal-literal.value,
    ).gist
}

multi sub to-rust-param($x where Cpp::UnaryExpressionCase::Sizeof) {
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::NewExpression::NewTypeId) {
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::IntegerLiteral::Hex) {  
    Rust::IntegerLiteral.new(
        value => $x.hexadecimal-literal.value,
    ).gist
}

multi sub to-rust-param($x where Cpp::FloatingLiteral::Frac) {  
    Rust::FloatLiteral.new(
        value => $x.fractionalconstant.value,
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

multi sub to-rust-param($x where Cpp::InitializerClause::Braced) {

    my $body    = to-rust-param($x.braced-init-list);
    my $comment = to-rust($x.comment);

    Rust::CommentWrapped.new(
        maybe-comment => $comment,
        wrapped       => $body,
    )
}

multi sub to-rust-param($x where Cpp::UnaryExpressionCase::UnaryOp) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::ShiftExpression) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::RelationalExpression) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::StringLiteral) {  
    Rust::StringLiteral.new(
        value => $x.value
    ).gist
}

multi sub to-rust-param($x where Cpp::PrimaryExpression::Id) {  
    to-rust-ident($x.id-expression, snake-case => True).gist
}

multi sub to-rust-param($x where Cpp::LambdaExpression) {  
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::PrimaryExpression::Lambda) {  
    to-rust($x)
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

multi sub to-rust-param($item where Cpp::ConditionalExpression)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::PostfixExpressionList)
{
    to-rust($item)
}


multi sub to-rust-param(
    $item where Cpp::InclusiveOrExpression)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::InitializerClause::Assignment)
{
    my $comment = to-rust($item.comment);
    my $body    = to-rust($item.assignment-expression);

    Rust::CommentWrapped.new(
        maybe-comment => $comment,
        wrapped       => $body,
        chomp         => True,
    )
}

our sub rust-default-default {
    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "Default",
                        )
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "default",
                        )
                    ),
                ]
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ]
    )
}

multi sub to-rust-param($item where Cpp::DecimalLiteral) {
    to-rust($item)
}

multi sub to-rust-param($item where Cpp::UserDefinedIntegerLiteral::Dec) {
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::BracedInitList)
{
    my $res = do if not $item.initializer-list.Bool {
        rust-default-default()
    } else {
        to-rust($item)
    };

    $res.gist
}

multi sub to-rust-param(
    $item where Cpp::LogicalAndExpression)
{
    to-rust($item)
}

multi sub to-rust-param(
    $item where Cpp::LogicalOrExpression)
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

multi sub to-rust-param(
    $item where Cpp::BooleanLiteral::F)
{
    to-rust($item)
}

multi sub to-rust-param($x where Cpp::ParameterDeclaration) {  
    do given $x.token-types {
        when [Nil,'TypeSpecifier',Nil,Nil] {

            my $ident 
            = to-rust-ident(
                $x.decl-specifier-seq.value, 
                snake-case => True
            );

            Rust::SuffixedExpression.new(
                base-expression => Rust::BaseExpression.new(
                    expression-item => Rust::PathInExpression.new(
                        path-expr-segments => [
                            Rust::PathExprSegment.new(
                                path-ident-segment => $ident,
                            )
                        ]
                    )
                ),
                suffixed-expression-suffix => [
                    Rust::CallExpressionSuffix.new(
                        maybe-call-params => Nil,
                    )
                ]
            )
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

multi sub to-rust-params(
    $item where Cpp::BracedInitList)
{
    my @list = $item.initializer-list.Bool 
    ?? $item.initializer-list.clauses>>.&to-rust-param 
    !! [];

    @list.join(",")
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
