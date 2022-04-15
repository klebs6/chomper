use Chomper::Util;
use Chomper::Typemap;
use Chomper::TypeInfo;

our sub remove-typename($type) {

    if $type<typename>:exists {

        my $parents = $type<parent>.List.join("::");
        my $child = $type<child>.Str;
        "{$parents}::{$child}"

    } else {
        $type
    }
}

our sub translate-using-declarations( $submatch, $body, $rclass) 
{
    my @rust-declarations = do for $submatch<using-declaration>.List -> $declaration {

        my $name          = $declaration<lhs>;

        my $maybe-comment = $declaration<line-comment> // "";

        #could by <type>, <function-sig-type> or <unnamed-arg>
        my $id  = $declaration<rhs>;

        my $rtype = do if $id<typename>:exists {
            remove-typename($id)

        } elsif $id<type>:exists and not $id<type> ~~ "" {
            augmented-rtype-from-qualified-cpp-type($id)

        } else {
            populate-typeinfo($id).vectorized-rtype
        };

        "pub type $name = $rtype;{$maybe-comment}"
    };

    @rust-declarations.join("\n")
}


