use Config::TOML;

our sub add-neighbor-dependency(
    :$src, 
    :$dst, 
    Bool :$write) 
{
    add-workspace-crate-to-neighbor-cargo-toml(
        workspace-crate => $src, 
        neighbor        => $dst,
        :$write
    );

    glob-import-from-crates($dst, [
        $src.subst(:g, "-","_")
    ]);
}

#----------------------------------------------
our sub maybe-create-directory($name) {
    if not $name.IO.d {
        mkdir $name.IO;
    }
}

#----------------------------------------------
our sub initialize-cargo-workspace($name) {
    shell "cd $name && cargo init --lib";
}

#----------------------------------------------
our sub add-to-cargo-workspace($name) {

    my $workspace-toml = get-workspace-toml();

    if not $name (elem) $workspace-toml<workspace><members>.List {
        $workspace-toml<workspace><members>.push: $name;
    }

    "Cargo.toml".IO.spurt: to-toml($workspace-toml);
}

#----------------------------------------------
our sub imports-file($crate) {
    "$crate/src/imports.rs".IO
}

#----------------------------------------------
our sub lib-file($crate) {
    "$crate/src/lib.rs".IO
}

#----------------------------------------------
our sub sort-uniq(IO $file) {
    my @lines = $file.lines.sort.unique;
    $file.spurt: @lines.join("\n")
}

#----------------------------------------------
our sub glob-import-from-crates($name, @crates) {

    my $imports-file = imports-file($name);

    for @crates -> $crate {

        my $imports = qq:to/END/;

        pub(crate) use {$crate}::*;
        END

        $imports-file.spurt: $imports, :append
    }

    sort-uniq($imports-file)
}

#----------------------------------------------
our sub add-starter-lib-file-for-crate($name) {
    my $starter = q:to/END/;
    #[macro_use] mod imports; use imports::*;

    //x!{modfile}
    END

    "$name/src/lib.rs".IO.spurt: $starter
}

#----------------------------------------------
our sub add-workspace-crate(Str $name, :$write) {

    die "crate $name exists in workspace" 
    if crate-exists-in-workspace($name);

    maybe-create-directory($name);
    add-to-cargo-workspace($name);
    initialize-cargo-workspace($name);
}

#----------------------------------------------
our sub crate-exists-in-workspace($crate) {
    crates-exist-in-workspace([$crate])
}

#----------------------------------------------
our sub get-workspace-toml {

    my $workspace-toml = from-toml("./Cargo.toml".IO.slurp);

    die "not in workspace" if not $workspace-toml<workspace>:exists;

    $workspace-toml
}

#----------------------------------------------
our sub crates-exist-in-workspace(@crates) {

    my $workspace-toml = get-workspace-toml();

    my Set $workspace-crates 
    = $workspace-toml<workspace><members>.Set;

    for @crates {
        return False if not $_.chomp.trim (elem) $workspace-crates;
    }

    True
}

#----------------------------------------------
our sub add-workspace-crate-to-neighbor-cargo-toml(
    :$workspace-crate, 
    :$neighbor, 
    :$write)
{
    die "crate DNE: $workspace-crate" if not crates-exist-in-workspace([$workspace-crate, $neighbor]);

    my $neighbor-cargo-toml-file = $neighbor ~ "/Cargo.toml";
    my $neighbor-cargo-toml      = from-toml($neighbor-cargo-toml-file.IO.slurp);
    $neighbor-cargo-toml<dependencies>{$workspace-crate}<path> = "../$workspace-crate";

    my $new-cargo-toml = to-toml($neighbor-cargo-toml);

    if $write {

        $neighbor-cargo-toml-file.IO.spurt: $new-cargo-toml;

    } else {
        say qq:to/END/;
        will update $neighbor-cargo-toml-file with:
        $new-cargo-toml
        END
    }
}

#----------------------------------------------
our sub add-dependency-to-cargo-toml(
    :$cargo-toml, 
    :$dep, 
    :$ver, 
    :$write = False) {

    my $toml = from-toml($cargo-toml.IO.slurp);

    if not $toml<dependencies>{$dep} {
        $toml<dependencies>{$dep}<version> = $ver;
    }

    my $contents = to-toml($toml);

    if $write {
        $cargo-toml.IO.spurt: $contents;
    } else {
        say $contents;
    }
}

#----------------------------------------------
our sub batch-add-dependency-to-cargo-toml(
    @crates, 
    :$dep, 
    :$ver, 
    :$write = False) {

    for @crates.map: {$_ ~ "/Cargo.toml"} -> $file {
        add-dependency-to-cargo-toml(
            cargo-toml => $file,
            :$dep,
            :$ver,
            :$write
        );
    }
}

#----------------------------------------------
our sub batch-add-dependencies-to-cargo-toml(
    @crates, 
    :@deps, 
    :$ver, 
    :$write = False) {

    for @deps -> $dep {

        batch-add-dependency-to-cargo-toml(
            @crates, 
            :$dep, 
            :$ver, 
            :$write
        );
    }
}

our sub get-crate-files($crate) {

    my @all = ($crate ~ "/src")[0].IO.dir;

    #exclude boilerplate
    @all.grep: {
        [
            $_ !~~ /lib.rs/, 
            $_ !~~ /imports.rs/,
            $_ !~~ /proto/,
        ].all
    }
}
