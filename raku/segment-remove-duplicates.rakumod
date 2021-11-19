
our sub segment-remove-duplicates($name) {

    my @pieces = $name.split("_");
    my $count = @pieces.elems;
    my $set = SetHash.new;

    my @builder;

    for @pieces {
        if not $_ (elem) $set {
            @builder.push: $_;
            $set{$_} = True
        }
    }

    @builder.join("_")
}

