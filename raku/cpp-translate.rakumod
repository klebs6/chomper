use gcpp;

our sub cpp-translate($in) {

    grammar G does CPP14Parser {}

    use Grammar::Tracer;
    grammar GD does CPP14Parser {}

    G.parse($in) // do { say "Bad $in"; GD.parse($in) }
}
