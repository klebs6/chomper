use util;
use case;
use typemap;
use type-info;

our sub translate-typedef-fn-ptr( $submatch, $body, $rclass) {

    my $name         = snake-to-camel($submatch<name>.Str);

    my $rt    = get-rust-type($submatch<rt><type>);

    my $pargs = ParenthesizedArgs.new(parenthesized-args => $submatch<parenthesized-args>);

    my ($arg-count, $rust-args) = get-rust-args-from-parenthesized(False, $pargs);

    my $result = format-function-type-result(
        $rust-args, 
        $arg-count, 
        $rt
    );

    "pub type $name = $result;\n"

=begin comment
    my @unnamed-args = do for $submatch<parenthesized-args><unnamed-arg>.List {
        augmented-rtype-from-qualified-cpp-type($_)
    };

    "pub type $name = fn({@unnamed-args.join(",")}){$rt ?? " -> $rt" !! ""};"
=end comment
}

our sub translate-typedef-fn-ptrs( $submatch, $body, $rclass) 
{
    do for $submatch<typedef-fn-ptr>.List {
        translate-typedef-fn-ptr($_, $body, $rclass)
    }.join("\n")
}
