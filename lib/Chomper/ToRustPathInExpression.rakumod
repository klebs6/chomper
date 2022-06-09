use Chomper::TranslateIo;
use Chomper::Rust;
use Chomper::Cpp;
use Chomper::SnakeCase;
use Chomper::ToRustPathExprSegment;
use Data::Dump::Tree;

sub is-std-namespace($nns where Rust::PathExprSegment) returns Bool {
    my $match = $nns.path-ident-segment.value ~~ "std";
    so $match
}

proto sub to-rust-path-in-expression(
    $x, 
    Bool :$snake-case) is export { * }

multi sub to-rust-path-in-expression(
    $x where Cpp::QualifiedId, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    my @segments;

    my $nns = $x.nested-name-specifier;

    my $rust-nns 
    = to-rust-path-expr-segment($nns, :$snake-case);

    #we remove std namespace
    my Bool $std-namespace 
    = is-std-namespace($rust-nns);

    if not $std-namespace {
        @segments.push: $rust-nns;
    }

    @segments.push: to-rust-path-expr-segment($x.unqualified-id);

    Rust::PathInExpression.new(
        path-expr-segments => @segments
    )
}

multi sub to-rust-path-in-expression(
    $x where Cpp::NestedNameSpecifier, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    Rust::PathInExpression.new(
        path-expr-segments => [
            to-rust-path-expr-segment($x.nested-name-specifier-prefix),
            |$x.nested-name-specifier-suffixes>>.&to-rust-path-expr-segment,
        ]
    )
}

multi sub to-rust-path-in-expression(
    $x where Cpp::FullTypeName, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    my @segments;

    my $nns = $x.nested-name-specifier;
    my $ttn = $x.the-type-name;

    my $rust-nns 
    = to-rust-path-expr-segment($nns, :$snake-case);

    if $rust-nns ~~ Rust::PathInExpression {

        for $rust-nns.path-expr-segments {

            #we remove std namespace
            if $_.path-ident-segment.value !~~ "std" {
                @segments.push: $_.path-ident-segment;
            }
        }

    } else {

        #we remove std namespace
        if $rust-nns.path-ident-segment.value !~~ "std" {
            @segments.push: $rust-nns;
        }
    }

    @segments.push: 
    to-rust-path-expr-segment($ttn, :$snake-case);

    Rust::PathInExpression.new(
        path-expr-segments => @segments,
    )
}

multi sub to-rust-path-in-expression(
    $x where Cpp::Identifier, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    my @segments;

    @segments.push: to-rust-path-expr-segment($x, :$snake-case);

    Rust::PathInExpression.new(
        path-expr-segments => @segments,
    )
}

multi sub to-rust-path-in-expression(
    $x where Cpp::IntegerLiteral::Hex, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    my @segments;

    @segments.push: to-rust-path-expr-segment($x, :$snake-case);

    Rust::PathInExpression.new(
        path-expr-segments => @segments,
    )
}

multi sub to-rust-path-in-expression(
    $x where Cpp::ConstantExpression, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    to-rust-path-in-expression($x.conditional-expression)
}

multi sub to-rust-path-in-expression(
    $x where Cpp::PrimaryExpression::Id, 
    Bool :$snake-case) 
returns Rust::PathInExpression 
{
    to-rust-path-in-expression($x.id-expression)
}

multi sub to-rust-path-in-expression(
    $x, 
    Bool :$snake-case) 
{ 
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
