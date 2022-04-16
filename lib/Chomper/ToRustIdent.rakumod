use Chomper::TranslateIo;
use Chomper::Rust;
use Chomper::Cpp;
use Chomper::SnakeCase;
use Data::Dump::Tree;

proto sub to-rust-ident(
    $x, 
    Bool :$snake-case) is export { * }

multi sub to-rust-ident(
    $x where Cpp::Identifier, 
    Bool :$snake-case) 
returns Rust::Identifier 
{
    my $value = $x.value;

    if $snake-case {
        $value = snake-case($value);
    }

    Rust::Identifier.new(
        value => $value
    )
}

multi sub to-rust-ident($x, Bool :$snake-case) {  
    ddt $x;
    die "need to write method for type: " ~ $x.WHAT.^name;
}
