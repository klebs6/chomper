use Chomper::Cpp;
use Chomper::Rust;
use Chomper::TranslateIo;
use Chomper::ToRustIdent;
use Chomper::ToRust;
use Data::Dump::Tree;

our sub octal-to-int($octal-value) {
    if $octal-value.Num ne 0 {
        die "need handle this!";
    } else {
        0
    }
}

proto sub to-rust-param($x) is export { * }

multi sub to-rust-param($x where Cpp::IntegerLiteral::Dec) {  
    Rust::IntegerLiteral.new(
        value => $x.decimal-literal.value,
    )
}

multi sub to-rust-param($x where Cpp::IntegerLiteral::Oct) {  
    Rust::IntegerLiteral.new(
        value => octal-to-int($x.octal-literal.value),
    )
}

multi sub to-rust-param($x where Cpp::PostfixExpression) {  
    #translate-postfix-expression($x, $x.token-types)
    to-rust($x)
}

multi sub to-rust-param($x where Cpp::PrimaryExpression::Id) {  
    to-rust-ident($x.id-expression)
}

multi sub to-rust-param($x where Cpp::EqualityExpression) {  
    to-rust($x)
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
