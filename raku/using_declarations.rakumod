use util;
use typemap;
use type-info;

our sub translate-using-declarations( $submatch, $body, $rclass) 
{
    my @rust-declarations = do for $submatch<using-declaration>.List -> $declaration {
        my $name  = $declaration<lhs>;
        my $type  = $declaration<rhs>;
        my $rtype = populate-typeinfo($type).vectorized-rtype;
        "pub type $name = $rtype;"
    };

    @rust-declarations.join("\n")
}


