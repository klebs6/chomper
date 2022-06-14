use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRust;
use Chomper::TranslateIo;
use Chomper::ToRustType;
use Chomper::ToRustIdent;
use Chomper::ToRustParams;
use Chomper::ToRustPathInExpression;

use Data::Dump::Tree;

proto sub translate-conditional-expression($item) is export { * }

multi sub translate-conditional-expression($item where Cpp::IntegerLiteral::Oct) {  
    Rust::IntegerLiteral.new(
        value => $item.octal-literal.value
    )
}

multi sub translate-conditional-expression($item where Cpp::IntegerLiteral::Dec) {  
    Rust::IntegerLiteral.new(
        value => $item.decimal-literal.value
    )
}

multi sub translate-conditional-expression($item where Cpp::IntegerLiteral::Hex) {  
    Rust::IntegerLiteral.new(
        value => $item.hexadecimal-literal.value
    )
}

multi sub translate-conditional-expression($item where Cpp::PrimaryExpression::Id) {  
    to-rust-ident($item.id-expression, snake-case => True)
}

multi sub translate-conditional-expression($item where Cpp::AdditiveExpression) {  
    to-rust($item)
}

multi sub translate-conditional-expression($item where Cpp::PostfixExpression) {  
    to-rust($item)
}

multi sub translate-conditional-expression($item where Cpp::PostfixExpressionList) {  
    to-rust($item)
}

multi sub translate-conditional-expression($item where Cpp::InclusiveOrExpression) {  
    to-rust($item)
}

multi sub translate-conditional-expression($item where Cpp::AndExpression) {  
    to-rust($item)
}

multi sub translate-conditional-expression($item) {  
    die "need write hook for \
    translate-conditional-expression! {$item.WHAT.^name}";
}
