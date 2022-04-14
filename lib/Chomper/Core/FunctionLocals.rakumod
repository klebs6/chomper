use util;
use typemap;
use type-info;
use snake-case;

sub get-default($vectorized-rtype) {
    given $vectorized-rtype {
        when "f32" | "f64" | "f16" {
            0.0
        }
        when "u8" | "u16" | "u32" | "u64" | 
        "i8" | "i16" | "i32" | "i64" 
        {
            0
        }
        default {
            "{$vectorized-rtype}::default()"
        }
    }
}

#TODO: need rewrite/correct the handling of defaults
#it is likely there will be some bugs there
sub get-rust-decls($arg, $compute_const = True ) {

    my $ident = $arg<type><maybe-vectorized-identifier>;

    my TypeInfo $info = populate-typeinfo($ident);

    my $vectorized-rtype = $info.vectorized-rtype;
    my $default          = get-default($vectorized-rtype);

    my @decls;
    for $arg<function-local-type-suffix> {

        my $const  = False;

        my $ref    = $_<ref>:exists;
        my $ptr    = $_<ptr>:exists;

        my @dim_stack = get-dim-stack($_);

        my $name = snake-case($_<name>.trim);

        if @dim_stack.elems > 0 {

            my $aarg = get-rust-array-arg(
                $const, 
                $ref, 
                $ptr, 
                $vectorized-rtype, 
                @dim_stack);

            @decls.push: "let mut $name: $aarg = {get-arr-type($default, @dim_stack)}";

            } else {

                my $augmented = augment-rtype(
                    $vectorized-rtype, 
                    $const, 
                    $ref, 
                    $ptr
                );

                if $ptr {
                    $default = "null_mut()";

                }

                @decls.push: "let mut $name: $augmented = $default";
            }
        }

        return @decls;
    }

sub extract-function-local-data($submatch, $mock = False) {

    if $mock {
        "//test comment", 
        (
            "let mut my_strings: Vec<String> = vec![]",
            "let mut my_ints:    Vec<i32> = vec![]",
            "let mut my_int:     i32 = 0",
            "let mut my_float:   f32 = 0.0",
        )

    } else {
        get-rcomments-list($submatch),
        get-rust-decls($submatch)
    }
}

sub translate-function-local-declaration ( $submatch ) {

    my ($comment, $rust-decls) = 
    extract-function-local-data($submatch);

    my $rust = $rust-decls.List.join(";\n");

    qq:to/END/.chomp.trim;
    $comment
    $rust;
    END
}

our sub translate-function-locals( $submatch, $body, $rclass) 
{
    my @items = do for 

    $submatch<function-local-declaration> {
        translate-function-local-declaration($_)
    };

    @items.join("\n").chomp.trim
}


