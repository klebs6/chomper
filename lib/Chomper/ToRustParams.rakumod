use Chomper::Cpp::GcppExpression;
use Chomper::TranslateIo;
use Data::Dump::Tree;

proto sub to-rust-params($x) is export { * }

multi sub to-rust-params(Initializer::ParenExprList $x) {  
    debug "to-rust-params for ParenExprList";
    ddt $x;
    "dummyparams"
}

multi sub to-rust-params($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT;
}

