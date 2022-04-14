
our sub crates-for-proj($proj) {
    ".".IO.dir
    ==> grep(/bitcoin\-/)
    ==> map({.Str})
    ==> sort()
}
