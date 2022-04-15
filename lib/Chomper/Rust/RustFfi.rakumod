use NativeCall;
use Chomper::Crates;
use Chomper::Rust::InferRustdoc;

our class LineRange is repr('CStruct') {
    has uint32 $.begin;
    has uint32 $.end;
}

sub get_rust_fname( 
    CArray[uint8], 
    CArray[uint8], 
    uint32, 
    uint32
)
returns Str is encoded('utf8')
is native(
%*ENV<WORK> ~ "/repo/translator/target/debug/translator"
) { * }

sub get_rust_current_function_linerange( 
    CArray[uint8], 
    CArray[uint8], 
    uint32, 
    uint32
)
returns Pointer[LineRange]
is native(
%*ENV<WORK> ~ "/repo/translator/target/debug/translator"
) { * }

our sub get-rust-fn(
    Str $crate, 
    Str $cur-file, 
    uint32 $begin, 
    uint32 $end) 
{
    my $json-db = CArray[uint8].new(json-db-file($crate).encode.list, 0);
    my $file    = CArray[uint8].new($cur-file.encode.list, 0);

    get_rust_fname($json-db,$file,$begin,$end)
}

our sub get-rust-fn-range(
    Str $crate, 
    Str $cur-file, 
    uint32 $begin, 
    uint32 $end) 
{
    my $json-db = CArray[uint8].new(json-db-file($crate).encode.list, 0);
    my $file    = CArray[uint8].new($cur-file.encode.list, 0);

    my $range    = get_rust_current_function_linerange($json-db,$file,$begin,$end);
    $range.deref
}
