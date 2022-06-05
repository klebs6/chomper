use Chomper::Rust;

our sub build-token-tree(Str $in) {
    [
        token-tree-leaf(""),
        token-tree-leaf($in.indent(4)),
        token-tree-leaf(""),
    ]
}

our sub token-tree-leaf(Str $in) {
    Rust::TokenTreeLeaf.new(
        rust-token-no-delim => $in
    )
}

