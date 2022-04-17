use Chomper::Cpp;
use Chomper::Rust;
use Chomper::ToRustIdent;
use Chomper::TranslateIo;
use Data::Dump::Tree;

proto sub to-rust-type($x) is export { * }

sub to-rust-generic-args(@cpp-template-arguments) {

    my @args = do for @cpp-template-arguments {
        to-rust-type($_)
    };

    Rust::GenericArgs.new(
        args => @args,
    )
}

multi sub to-rust-type($x where Cpp::SimpleTemplateId) {  

    my Rust::Identifier $template-name = to-rust-type($x.template-name);

    my $rust-generic-args = to-rust-generic-args($x.template-arguments);

    Rust::TypePath.new(
        type-path-segments => [
            Rust::TypePathSegment.new(
                path-ident-segment => $template-name,
                maybe-type-path-segment-suffix => Rust::TypePathSegmentSuffixGeneric.new(
                    generic-args => $rust-generic-args,
                ),
            )
        ]
    )
}

multi sub to-rust-type($x where Cpp::Identifier) {  

    my %typemap = %(
        "vector" => "Vec",
        "int"    => "i32",
        "Tensor" => "Tensor",
    );

    Rust::Identifier.new(
        value => %typemap{to-rust-ident($x).value}
    )
}

multi sub to-rust-type($x where Cpp::TypeSpecifier) {  
    to-rust-type($x.value)
}

multi sub to-rust-type($x) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT;
}
