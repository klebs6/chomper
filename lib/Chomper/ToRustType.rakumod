use Chomper::Cpp::GcppTypeSpecifier;
use Chomper::TranslateIo;
use Data::Dump::Tree;

proto sub to-rust-type($x) is export { * }

multi sub to-rust-type(TypeSpecifier $x) {  
    debug "to-rust-type for TypeSpecifier";
    ddt $x;
    "dummytype"
}

multi sub to-rust-type($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT;
}
