use grust-model;

our role Unsafe::Rules {

    rule maybe-unsafe {
        <UNSAFE>?
    }

    proto rule maybe-default_maybe_unsafe { * }

    rule maybe-default_maybe_unsafe:sym<a> { <DEFAULT> <UNSAFE> }
    rule maybe-default_maybe_unsafe:sym<b> { <DEFAULT> }
    rule maybe-default_maybe_unsafe:sym<c> { <UNSAFE> }
    rule maybe-default_maybe_unsafe:sym<d> { }
}

our role Unsafe::Actions {

    method maybe-unsafe:sym<a>($/) {
        make Unsafe.new
    }

    method maybe-default_maybe_unsafe:sym<a>($/) { make DefaultUnsafe.new }
    method maybe-default_maybe_unsafe:sym<b>($/) { make Default.new }
    method maybe-default_maybe_unsafe:sym<c>($/) { make Unsafe.new }
    method maybe-default_maybe_unsafe:sym<d>($/) { }
}
