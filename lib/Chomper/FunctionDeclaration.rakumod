use Chomper::Util;

our class FunctionDeclaration {

    has @!comments = [];

    has Bool $!inline = False;

    has Bool $!static = False;

    has Bool $!constexpr = False;

    has ReturnType $!return-type;

    has $name is required;

    has RustArg @.maybe-unnamed-args;

    has Bool $trailing-elipsis-arg = False;

    has Bool $!const = False;

    submethod BUILD(:$match) {

    }

    method gist {

    }

}

