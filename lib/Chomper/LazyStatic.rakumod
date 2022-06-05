use Chomper::Rust;
use Chomper::Cpp;
use Chomper::TokenTree;

our sub create-lazy-static(
    $rust-type,
    $rust-ident,
    $default-initializer) {

    Rust::MacroInvocation.new(
        simple-path => Rust::SimplePath.new(
            simple-path-segments => [
                "lazy_static",
            ]
        ),
        token-trees => build-token-tree(
            "static ref {$rust-ident.gist.uc}: {$rust-type.gist} = {$default-initializer.gist};"
        ),
        delim-kind  => Rust::DelimKind::<Brace>,
    )
}
