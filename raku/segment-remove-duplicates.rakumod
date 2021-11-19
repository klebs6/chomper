
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

our sub remove-duplicate-segments($filename, :$marker = /_/, :$sep = "_") {
    my ($name, $ext) = $filename.split(".");

    my @segs = $name.split($marker);
    my @builder = [];

    for @segs {
        @builder.push: $_ if not @builder.grep($_);
    }
    @builder.join($sep) ~ ".$ext"

}
