use Chomper::Cpp;

proto sub is-const-type($x) is export { * }

multi sub is-const-type($x where Cpp::TypeSpecifier) {
    if $x.value ~~ Cpp::TrailingTypeSpecifier::CvQualifier {
        return $x.value.cv-qualifier ~~ Cpp::CvQualifier::Const_;
    }

    False
}

multi sub is-const-type($x where Positional)  {
    so $x.List.grep: /const/
}
