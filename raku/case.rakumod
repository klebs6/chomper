
our sub snake-to-camel($input) {
    my $type-stripped = $input.subst(/_t$/, "");
    $type-stripped.split("_")>>.tc.join("")
}

our sub is-camel-case($type) {
    my $camel-seg = regex { <[A..Z]> <[a..z]>* };
    my $camel     = regex { $camel-seg+ };
    $type ~~ $camel
}

our sub screaming-snake-case-to-camel-case($in) {
    $in.trim.chomp.split("_")>>.lc>>.tc.join("")
}

