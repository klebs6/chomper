our class Continue {}
our class Ellipsis {}
our class PythonImportSkipMe {}
our class Break {}
our class Pass {}

our class TernaryOperator {
    has $.A    is required;
    has $.cond is required;
    has $.B    is required;
}

our sub get-compound-comments($/) {
    [|$<COMMENT>>>.made, $<COMMENT_NONEWLINE>.made // Nil]
}

our sub is-test-fn-name($name) {
    my $fn-name = $name.subst(:g, /^_/, "");
    $fn-name.starts-with("test")
}

