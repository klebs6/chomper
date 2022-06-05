use Chomper::Cpp;

our sub is-const-type($x where Cpp::TypeSpecifier) 
{
    if $x.value ~~ Cpp::TrailingTypeSpecifier::CvQualifier {
        return $x.value.cv-qualifier ~~ Cpp::CvQualifier::Const_;
    }

    False
}
