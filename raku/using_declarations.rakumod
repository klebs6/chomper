use util;
use typemap;
use type-info;

our sub translate-using-declarations( $submatch, $body, $rclass) 
{
    my @rust-declarations = do for $submatch<using-declaration>.List -> $declaration {
        my $name  = $declaration<lhs>;
        my $unnamed-arg  = $declaration<rhs>; #unnamed-arg
        my $rtype = augmented-rtype-from-qualified-cpp-type($unnamed-arg);
        "pub type $name = $rtype;"
    };

    @rust-declarations.join("\n")
}


