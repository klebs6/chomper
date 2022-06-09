use Chomper::TranslateIo;
use Chomper::Rust;
use Chomper::Cpp;
use Chomper::SnakeCase;
use Chomper::ToRustIdent;
use Chomper::ToRustType;
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
    $x where Cpp::NestedNameSpecifierSuffix::Id, 
    Bool :$snake-case) 
returns Rust::PathExprSegment 
{
    my Rust::Identifier $identifier =
    to-rust-ident(
        $x.identifier, 
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
    $x where Cpp::IntegerLiteral::Hex, 
    Bool :$snake-case) 
returns Rust::PathExprSegment 
{
    use Chomper::ToRust;

    my $rust-hex = to-rust($x);

    Rust::PathExprSegment.new(
        path-ident-segment => $rust-hex,
        maybe-generic-args => Nil,
    )
}

multi sub to-rust-path-expr-segment(
    $x where Cpp::NestedNameSpecifierSuffix::Template, 
    Bool :$snake-case) 
returns Rust::PathExprSegment 
{
    my Rust::Identifier $identifier =
    to-rust-ident(
        $x.simple-template-id.template-name, 
        :$snake-case
    );

    my @cpp-template-arguments = 
    $x.simple-template-id.template-arguments.template-arguments;

    Rust::PathExprSegment.new(
        path-ident-segment => $identifier,
        maybe-generic-args => Rust::GenericArgs.new(
            args => [
                @cpp-template-arguments>>.&to-rust-type
            ]
        )
    )
}

multi sub to-rust-path-expr-segment(
    $x where Cpp::SimpleTemplateId, 
    Bool :$snake-case) 
{
    use Chomper::ToRustType;
    to-rust-type($x)
}

multi sub to-rust-path-expr-segment(
    $x, 
    Bool :$snake-case) 
{ 
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
