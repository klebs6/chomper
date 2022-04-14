use Test;

our sub test-for-x(Grammar $g, @examples, :$success) {

    my $kw = $success ?? "success" !! "failure";

    for @examples -> $ex {

        my $parsed = $g.parse($ex);

        my Bool $ok = $success ?? so $parsed !! so not $parsed;

        if not $ok {

            say "test for $kw failed <default-value>: $ex";
=begin comment
            use Grammar::Tracer;
            my $traced = $g;
            say $traced.parse($ex);
=end comment
        }

        ok $ok;
    }
}

our sub test-for-success(Grammar $g, @examples) {
    test-for-x($g, @examples, success => True);
}

our sub test-for-failure(Grammar $g, @examples) {
    test-for-x($g, @examples, success => False);
}

our class TestCase {
    has Grammar $.grammar   is required;
    has Str @.examples      is required;
    has Str @.fail-examples is required;

    method run {

        plan @!examples.elems + @!fail-examples.elems;

        test-for-success($!grammar, @!examples);
        test-for-failure($!grammar, @!fail-examples);

        done-testing;
    }
}
