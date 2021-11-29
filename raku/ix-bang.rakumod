
our $ix-without-use-crate-star = rule { "ix!();" <!before "use crate::*;"> }

our sub check-has-use-crate-star-below-ix-bang($text) {
    my Bool $without = $text ~~ $ix-without-use-crate-star;
    not $without
}

our sub write-use-crate-star-below-ix-bang(:$filename) {
    my $contents = $filename.IO.slurp;
    my $new-contents = $contents.subst("ix!();", "ix!();\n\nuse crate::*;");
    spurt $filename, $new-contents;
}

our sub find-files-without-use-crate-star-below-ix-bang(:$source_dir) {

    use File::Find;

    my @files = find(dir => $source_dir);

    @files.grep: {
        if not $_.d {
            $_.IO.slurp ~~ $ix-without-use-crate-star
        } else {
            False
        }
    }
}

