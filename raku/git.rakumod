our sub git-hash-before-date($dt) {
    my $hash = qqx/git rev-list -1 --before=\"{$dt}\" master/;

    $hash.chomp.substr(0,8)
}

our sub git-diff-lines($hash) {
    qqx/git diff $hash | ag '^-' | wc -l/.chomp.trim
}

our sub git-commit-time($hash) {
    qqx/git show -s --format=%ci $hash/.chomp.trim
}
