use Chomper::Cpp;
use Chomper::Rust;
use Chomper::TranslateIo;
use Chomper::ToRustIdent;
use Chomper::ToRustType;
use Data::Dump::Tree;

multi sub to-rust-base-expression($x where Cpp::FullTypeName, Bool :$snake-case = False) is export {

    my $a = $x.nested-name-specifier.the-type-name;
    my $b = $x.the-type-name;

    Rust::BaseExpression.new(
        expression-item => Rust::PathInExpression.new(
            path-expr-segments => [
                Rust::PathExprSegment.new(
                    path-ident-segment => to-rust-base-expression($a, snake-case => False),
                ),
                Rust::PathExprSegment.new(
                    path-ident-segment => to-rust-base-expression($b, snake-case => True),
                ),
            ]
        )
    )
}

multi sub to-rust-base-expression($x where Cpp::SimpleTemplateId, Bool :$snake-case = False) is export {
    to-rust-type($x)
}

multi sub to-rust-base-expression($x where Cpp::Identifier, Bool :$snake-case = False) is export {
    to-rust-ident($x)
}

multi sub to-rust-base-expression($x where Str, Bool :$snake-case = False) is export {
    Rust::Identifier.new(
        value => $x
    )
}
