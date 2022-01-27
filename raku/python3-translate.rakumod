use snake-case;
use wrap-body-todo;

our sub get-scope-prefix(Bool $is-test, Bool $private) {

    if $is-test {
        return "#[test] ";
    }

    $private ?? "" !! "pub "
}

our sub python3-function-to-rust-stub(
    :$name,
    :$parameters,
    :$test,
    :$suite,
    Bool :$private,
    Bool :$is-test) {

    my $prefix    = get-scope-prefix($is-test, $private);
    my $body      = wrap-body-todo($suite, python => True);
    my $rust-args = $parameters ?? $parameters.Str !! "";

    qq:to/END/
    {$prefix}fn {snake-case($name)}\($rust-args\) \{
        $body
    \}
    END
}

our sub python3-classdef-to-rust-stub(

) {

}
