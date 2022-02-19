use grust-from-antlr;

our sub rust-translate($in) {

    grammar G does Rust::Grammar {}

    use Grammar::Tracer;
    grammar GD does Rust::Grammar {}

    say G.parse($in) // GD.parse($in);
}

