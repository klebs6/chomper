#use Chomper::Cpp::GcppIdent;
use Chomper::TranslateIo;
use Chomper::Rust;
use Chomper::Cpp;
use Data::Dump::Tree;

proto sub to-rust-ident($x) is export { * }

multi sub to-rust-ident(Cpp::Identifier $x) returns Rust::Identifier {  
    debug "to-rust-ident for Identifier";
    ddt $x;
    "dummyident"
}

multi sub to-rust-ident($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT;
}