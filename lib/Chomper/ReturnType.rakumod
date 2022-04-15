use Chomper::TypeInfo;
use Chomper::Args;

our class RustReturnType {

    has $!rtype is required;

    submethod BUILD(:$match) {
        my $info = populate-typeinfo($match<type>);
        my $aux  = get-type-aux($match);
        my ($rname, $rtype) = get-rust-arg-name-type("_", $info, $aux);
        $!rtype = $rtype;
    }

    method gist {
        $!rtype
    }
}
