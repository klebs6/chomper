use Chomper::Cpp;
use Chomper::Rust;
use Chomper::SnakeCase;

use Data::Dump::Tree;

our %known-default-map = %(
    usize => 0,
    isize => 0,
    i8    => 0,
    u8    => 0,
    i16   => 0,
    u16   => 0,
    i32   => 0,
    u32   => 0,
    i64   => 0,
    u64   => 0,
    i128  => 0,
    u128  => 0,
);

our sub create-default-initializer($rust-type) 
{
    if $rust-type ~~ Rust::RawPtrType {
        if $rust-type.mutable {
            return "null_mut()";
        } else {
            return "null()";
        }
    }

    if %known-default-map{$rust-type.gist}:exists {
        return %known-default-map{$rust-type.gist}.Str;
    }

    Rust::SuffixedExpression.new(
        base-expression => Rust::BaseExpression.new(
            expression-item => Rust::PathInExpression.new(
                path-expr-segments => [
                    Rust::PathExprSegment.new(
                        path-ident-segment => $rust-type,
                    ),
                    Rust::PathExprSegment.new(
                        path-ident-segment => Rust::Identifier.new(
                            value => "default"
                        )
                    ),
                ],
            )
        ),
        suffixed-expression-suffix => [
            Rust::CallExpressionSuffix.new(
                maybe-call-params => Nil,
            )
        ],
    )
}
