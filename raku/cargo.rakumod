our $cargo = qq:to/END/;
env 
RUSTFLAGS=-Awarnings
CARGO_MSG_LIMIT=15
CARGO_BUILD_JOBS=12
NUM_JOBS=12
cargo +nightly 
END

our sub crates-for-repo {
    my $stem = $*CWD.Str.split("/")[*-1].split("-")[0];
    ".".IO.dir.grep: /$stem\-/
}

our sub rustdoc-db-for-crate($crate, :$unfold = False) {
    my $json-file = $crate.subst("-","_") ~ ".json";

    if $unfold {
        "./target/doc/$json-file.unfold"
    } else {
        "./target/doc/$json-file"
    }
}

our sub generate-json-rustdoc($crate) {
    my $ofile = rustdoc-db-for-crate($crate);

    my $cmd = qq:to/END/.split("\n").join(" ");
    $cargo 
    rustdoc 
    -p $crate
    --lib 
    -- 
    --output-format json 
    -Z unstable-options
    END

    silent-run($cmd);
}

our sub unfold-rustdoc-json($crate) {

    my $ofile  = rustdoc-db-for-crate($crate);
    my $ofile-unfold = rustdoc-db-for-crate($crate, unfold => True);

    my $unfold = qq:to/END/.split("\n").join(" ");
    /bin/cat $ofile | jq > $ofile-unfold
    END

    silent-run($unfold);
}

our sub silent-run($cmd) {
    my $proc = shell $cmd, :out, :err;
    my $out = $proc.out.slurp(:close); # OUTPUT: «Raku is Great!␤» 
    my $err = $proc.err.slurp(:close);
}

our sub generate-full-rustdoc-db {
    my @crates = crates-for-repo();
    @crates.map: &generate-json-rustdoc;
    @crates.map: &unfold-rustdoc-json;
}

our sub generate-single-rustdoc-db($crate) {
    generate-json-rustdoc($crate);
    unfold-rustdoc-json($crate);
}
