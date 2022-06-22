
our sub crates-for-proj($proj) {
    ".".IO.dir
    ==> grep(/surge\-/)
    ==> map({.Str})
    ==> sort()
}
