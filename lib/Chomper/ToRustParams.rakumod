use Chomper::Cpp;
use Chomper::Rust;
use Chomper::TranslateIo;
use Data::Dump::Tree;

proto sub to-rust-param($x) is export { * }

multi sub to-rust-param($x where Cpp::IntegerLiteral::Dec) {  
    Rust::IntegerLiteral.new(
        value => $x.decimal-literal.value,
    )
}

multi sub to-rust-param($x where Cpp::ParameterDeclaration) {  
    ddt $x;
    exit;
    Rust::IntegerLiteral.new(
        value => $x.decimal-literal.value,
    )
}

multi sub to-rust-param($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT;
}

#-------------------------
proto sub to-rust-params($x) is export { * }

multi sub to-rust-params($x where Cpp::Initializer::ParenExprList) {  
    do for $x.expression-list.initializer-list.clauses {
        to-rust-param($_).gist
    }.join(", ")
}

multi sub to-rust-params($x where Cpp::ParametersAndQualifiers) {  
    do for $x.parameter-declaration-clause.parameter-declaration-list {
        to-rust-param($_).gist
    }.join(", ")
}

multi sub to-rust-params($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
