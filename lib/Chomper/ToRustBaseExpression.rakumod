use Chomper::Cpp;
use Chomper::Rust;
use Chomper::TranslateIo;
use Chomper::ToRustIdent;
use Chomper::ToRust;
use Chomper::ToRustType;
use Data::Dump::Tree;

multi sub to-rust-base-expression($x where Cpp::FullTypeName, Bool :$snake-case = False) is export {

    my $a = $x.nested-name-specifier;
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

multi sub to-rust-base-expression($x where Cpp::NestedNameSpecifier, Bool :$snake-case = False) is export {
    ddt $x;

    my $prefix   = to-rust-base-expression($x.nested-name-specifier-prefix);
    my @suffixes = $x.nested-name-specifier-suffixes.List>>.&to-rust-base-expression;

    Rust::BaseExpression.new(
        expression-item => Rust::PathInExpression.new(
            path-expr-segments => [
                Rust::PathExprSegment.new(
                    path-ident-segment => $prefix,
                ),
                |@suffixes.map: {
                    Rust::PathExprSegment.new(
                        path-ident-segment => $_,
                    ),
                }
            ]
        )
    )
}

multi sub to-rust-base-expression($x where Cpp::NestedNameSpecifierPrefix::Type, Bool :$snake-case = False) is export {
    to-rust-base-expression($x.the-type-name)
}

multi sub to-rust-base-expression($x where Cpp::NestedNameSpecifierSuffix::Template, Bool :$snake-case = False) is export {
    to-rust-base-expression($x.simple-template-id)
}

multi sub to-rust-base-expression($x where Cpp::NestedNameSpecifierSuffix::Id, Bool :$snake-case = False) is export {
    to-rust-base-expression($x.identifier)
}

multi sub to-rust-base-expression($x where Cpp::Identifier, Bool :$snake-case = False) is export {
    to-rust-ident($x)
}

multi sub to-rust-base-expression($x where Str, Bool :$snake-case = False) is export {
    Rust::Identifier.new(
        value => $x
    )
}
