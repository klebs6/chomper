use util;
use typemap;
use type-info;
use indent-rust-named-type-list;

sub get-rust-macro-body($submatch) {
    $submatch<macro-line>.List>>.chomp>>.subst(/\\ $/, "").join("\n").chomp
}

sub get-rust-macro-args($submatch) {
    if $submatch<macro-sig><macro-args>:exists {

        my @names = $submatch<macro-sig><macro-args><name-list><name>.List;

        my $result = do for @names { 
            "\${$_}:ident" 
        }.join(", ");

        if $submatch<macro-sig><macro-args><elipsis>:exists {
            $result = $result ~ ", \$(\$arg:ident),*";
        }

        $result
    } else {

        ""
    }
}

our sub translate-pound-define($submatch is rw, $body, $rclass) {

    my $rust-macro-name = $submatch<macro-sig><macro-name>.lc;
    my $rust-macro-args = get-rust-macro-args($submatch);
    my $rust-macro-body = get-rust-macro-body($submatch);

    qq:to/END/;
    macro_rules! $rust-macro-name \{
        ($rust-macro-args) => \{
            /*
            {$rust-macro-body.indent(8)}
            */
        \}
    \}
    END
}
