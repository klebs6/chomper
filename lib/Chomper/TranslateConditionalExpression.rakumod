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

multi sub translate-conditional-expression($item) {  
    die "need write hook for \
    translate-conditional-expression! {$item.WHAT.^name}";
}
