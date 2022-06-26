use Chomper::TranslateIo;
use Chomper::Rust;
use Chomper::Cpp;
use Chomper::ToRust;
use Chomper::SnakeCase;

use Data::Dump::Tree;

our sub is-all-caps($id) returns Bool {
    $id eq $id.uc
}

proto sub to-rust-ident(
    $x, 
    Bool :$snake-case) is export { * }

multi sub to-rust-ident(
    $x where Cpp::Identifier, 
    Bool :$snake-case) 
returns Rust::Identifier 
{
    my $value = $x.value;

    if $snake-case and not is-all-caps($value) {
        $value = snake-case($value);
    }

    Rust::Identifier.new(
        value => $value
    )
}

multi sub to-rust-ident(
    $x where Cpp::PointerDeclarator, 
    Bool :$snake-case) 
returns Rust::Identifier 
{
    to-rust-ident($x.no-pointer-declarator, :$snake-case)
}

multi sub to-rust-ident(
    $x where Cpp::PrimaryExpression::This, 
    Bool :$snake-case) 
returns Rust::Identifier 
{
    Rust::Identifier.new(
        value => "self"
    )
}

multi sub to-rust-ident(
    $x where Str, 
    Bool :$snake-case) 
returns Rust::Identifier 
{
    Rust::Identifier.new(
        value => snake-case($x)
    )
}

multi sub to-rust-ident(
    $condition where Cpp::Condition::Decl,
    Bool :$snake-case) 
returns Rust::Identifier 
{
    to-rust-ident($condition.declarator.no-pointer-declarator)
}

multi sub to-rust-ident(
    $x where Cpp::QualifiedId, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    Rust::PathInExpression.new(
        path-expr-segments => [
            Rust::PathExprSegment.new(
                path-ident-segment => to-rust($x.nested-name-specifier),
            ),
            Rust::PathExprSegment.new(
                path-ident-segment => to-rust($x.unqualified-id),
            ),
        ]
    )
}

multi sub to-rust-ident($x, Bool :$snake-case) {
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
