use gcpp;
use cpp-actions;

our sub cpp-translate($in) {

    grammar G does CPP14Parser {}

    use Grammar::Tracer;
    grammar GD does CPP14Parser {}

    G.parse($in, actions => CPP14Parser::Actions.new)
    // do { say "Bad $in"; say GD.parse($in); Nil }
}
