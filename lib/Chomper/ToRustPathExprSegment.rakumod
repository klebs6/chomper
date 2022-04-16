use Chomper::TranslateIo;
use Chomper::Rust;
use Chomper::Cpp;
use Chomper::SnakeCase;
use Chomper::ToRustIdent;
use Data::Dump::Tree;

proto sub to-rust-path-expr-segment(
    $x, 
    Bool :$snake-case) is export { * }

multi sub to-rust-path-expr-segment(
    $x where Cpp::NestedNameSpecifierPrefix::Type, 
    Bool :$snake-case) 
returns Rust::PathExprSegment 
{
    my Rust::Identifier $identifier =
    to-rust-ident(
        $x.the-type-name, 
        :$snake-case
    );

    Rust::PathExprSegment.new(
        path-ident-segment => $identifier,
        maybe-generic-args => Nil,
    )
}

multi sub to-rust-path-expr-segment(
    $x where Cpp::Identifier, 
    Bool :$snake-case) 
returns Rust::PathExprSegment 
{
    my Rust::Identifier $identifier =
    to-rust-ident(
        $x, 
        :$snake-case
    );

    Rust::PathExprSegment.new(
        path-ident-segment => $identifier,
        maybe-generic-args => Nil,
    )
}

multi sub to-rust-path-expr-segment(
    $x, 
    Bool :$snake-case) 
{ 
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
