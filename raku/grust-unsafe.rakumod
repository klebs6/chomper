our class Unsafe::G {

    proto rule maybe-unsafe { * }

    rule maybe-unsafe:sym<a> {
        <UNSAFE>
    }

    rule maybe-unsafe:sym<b> {

    }

    proto rule maybe-default_maybe_unsafe { * }

    rule maybe-default_maybe_unsafe:sym<a> {
        <DEFAULT> <UNSAFE>
    }

    rule maybe-default_maybe_unsafe:sym<b> {
        <DEFAULT>
    }

    rule maybe-default_maybe_unsafe:sym<c> {
        <UNSAFE>
    }

    rule maybe-default_maybe_unsafe:sym<d> {

    }
}

our class Unsafe::A {

    method maybe-unsafe:sym<a>($/) {
        make Unsafe.new
    }

    method maybe-unsafe:sym<b>($/) {
        MkNone<140540184096768>
    }

    method maybe-default_maybe_unsafe:sym<a>($/) {
        make DefaultUnsafe.new
    }

    method maybe-default_maybe_unsafe:sym<b>($/) {
        make Default.new
    }

    method maybe-default_maybe_unsafe:sym<c>($/) {
        make Unsafe.new
    }

    method maybe-default_maybe_unsafe:sym<d>($/) {
        MkNone<140540184096800>
    }
}
