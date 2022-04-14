use gcpp;
use cpp-actions;
use Data::Dump::Tree;

our sub cpp-translate($in) {

    grammar G does Cpp::Parser {}

    use Grammar::Tracer;
    grammar GD does Cpp::Parser {}

    G.parse($in, actions => Cpp::Actions.new)
    // do { say "Bad $in"; say GD.parse($in); Nil }
}
