use Chomper::SnakeCase;
use Chomper::TypeInfo;

our role RustArg {
    method gist { ... }
}

our class RustNamedArg does RustArg {

    has $!match is required;
    has $!rname is required;
    has $!rtype is required;

    submethod BUILD(:$named-arg) {

        $!match = $named-arg;

        my $info = populate-typeinfo($named-arg<type>);
        my $aux  = get-type-aux($named-arg);

        ($!rname, $!rtype) = get-rust-arg-name-type(
            $named-arg<name>.Str, 
            $info, 
            $aux
        );
    }

    method gist {
        "{snake-case($!rname)}: {$!rtype}"
    }
}

our class RustUnnamedArg does RustArg {

    has $!match is required;
    has $!idx   is required;
    has $!rname is required;
    has $!rtype is required;

    submethod BUILD(:$idx, :$unnamed-arg) {

        $!match = $unnamed-arg;
        $!idx   = $idx;

        my $info = populate-typeinfo($unnamed-arg<type>);
        my $aux  = get-type-aux($unnamed-arg);

        my $name = "_{$idx}";

        ($!rname, $!rtype) = get-rust-arg-name-type(
            $name, 
            $info, 
            $aux
        );
    }

    method gist {
        "{$!rname}: {$!rtype}"
    }
}

our sub get-rust-arg-name-type($name, TypeInfo $info, TypeAux $aux) {

    my $rarg = get-rust-arg-impl($name, $info, $aux);

    my $len = $rarg.chars;
    my $idx = $rarg.index(":");

    my $rname = $rarg.substr(0, $idx ).trim;

    my $rtype = $rarg.substr($idx + 1, $len ).trim;

    ($rname, $rtype)
}
