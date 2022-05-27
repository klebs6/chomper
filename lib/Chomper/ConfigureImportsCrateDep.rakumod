use Config::TOML;
use Chomper::CargoWorkspace;

our sub remove-crates($crate, :@remove-these) {

    my $imports-file = imports-file($crate);

    my @remaining = $imports-file.IO.slurp.lines.grep: {
        $_ !(elem) @remove-these.Set
    };

    my $new-text = @remaining.sort.unique.join("\n");

    $imports-file.spurt: $new-text;
}

our sub configure-imports-crate-dep-everywhere(:$root-dir, :$write = True) {

    my $project-name = $root-dir.Str.split("/")[*-1].split("-rs")[0];

    my $workspace-toml-file 
    = $root-dir ~ "/Cargo.toml";

    my $workspace-toml      
    = from-toml(file => $workspace-toml-file);

    my @workspace-crates    
    = $workspace-toml<workspace><members>.List.sort;

    my $imports-crate       
    = @workspace-crates.grep(/imports/)[0]; #assuming only one

    #need write this list, and use it to write the
    #imports crate
    #
    #then (or, first) need to remove the
    #third-party imports from each crate
    my @third-party-crates;

    for @workspace-crates -> $crate {

        my $src = $imports-crate;
        my $dst = $crate;

        if $write {
            add-neighbor-dependency(:$src, :$dst, write => True);

            glob-import-from-crates($crate, 
                [
                    $imports-crate.subst(:g, "-","_")
                ]
            );
        }

        my @crate-imports = imports-file($crate).slurp.lines.grep: { 
            so $_ 
                and $_ ~~ /pub\(crate\)/ 
                and $_ !~~ /$project-name/ 
        };

        remove-crates($crate, remove-these => @crate-imports);

        @third-party-crates.push: |@crate-imports;
    }

    my $imports-text = @third-party-crates.sort.unique.join("\n");

    my $imports-file = imports-file($imports-crate);

    $imports-file.IO.spurt: $imports-text, :append;

    sort-uniq($imports-file)
}
