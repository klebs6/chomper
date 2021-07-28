use util;
use typemap;
use type-info;

our sub translate-using-declarations( $submatch, $body, $rclass) 
{
    my @rust-declarations = do for $submatch<using-declaration>.List -> $declaration {

        my $name  = $declaration<lhs>;

        #could by <type> or <unnamed-arg>
        my $id  = $declaration<rhs>;

        my $rtype = do if $id<type>:exists {
            augmented-rtype-from-qualified-cpp-type($id)
        } else {
            populate-typeinfo($id).vectorized-rtype
        };

        "pub type $name = $rtype;"
    };

    @rust-declarations.join("\n")
}


