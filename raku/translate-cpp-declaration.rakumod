use Data::Dump::Tree;

use translate-io;
use gcpp-declaration;

our sub to-rust(
    SimpleDeclaration::Basic $item)
{
    debug "will translate SimpleDeclaration::Basic to Rust!";
    my $mask = $item.gist(treemark => True);
    translate-simple-declaration-to-rust($mask, $item);

}

multi sub translate-simple-declaration-to-rust(
    Str $mask,
    SimpleDeclaration::Basic $item) 
{
    die "need write hook for mask! $mask";

}

multi sub translate-simple-declaration-to-rust(
    "T I;",
    SimpleDeclaration::Basic $item) 
{
    say "got mask T I;";
    ddt $item;

}


multi sub translate-simple-declaration-to-rust(
    "I(Es);",
    SimpleDeclaration::Basic $item) 
{
    say "got mask I(Es);";
    ddt $item;

}


multi sub translate-simple-declaration-to-rust(
    "I (I);",
    SimpleDeclaration::Basic $item) 
{
    say "got mask I (I);";
    ddt $item;

}


