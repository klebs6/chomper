use util;
use typemap;
use type-info;

our sub translate-typedef-fn-ptr( $submatch, $body, $rclass) 
{
    my $rt = get-rust-type($submatch<rt>);

    my $name         = $submatch<name>.Str;
    my @unnamed-args = do for $submatch<unnamed-args><unnamed-arg>.List {
        augmented-rtype-from-qualified-cpp-type($_)
    };

    "pub type $name = fn({@unnamed-args.join(",")}){$rt ?? " -> $rt" !! ""};"
}



