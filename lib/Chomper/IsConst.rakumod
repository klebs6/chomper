use Chomper::Cpp;

proto sub is-const-type($x) is export { * }

multi sub is-const-type($x where Cpp::TypeSpecifier) {
    if $x.value ~~ Cpp::TrailingTypeSpecifier::CvQualifier {
        return $x.value.cv-qualifier ~~ Cpp::CvQualifier::Const_;
    }

    False
}

multi sub is-const-type($x where Positional)  {

    my @list = $x.List.grep: {
        my Bool $matches-static    = $_ ~~ Cpp::StorageClassSpecifier::Static;
        my Bool $matches-constexpr = $_ ~~ Cpp::DeclSpecifier::Constexpr;

        not [$matches-static, $matches-constexpr].any
    };

    die "need implement" if @list.elems gt 1;

    is-const-type(@list[0])
}
