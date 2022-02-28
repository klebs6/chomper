use grust-model;

our role Unsafe::Rules {

    rule maybe-unsafe {
        <kw-unsafe>?
    }

    rule maybe-default-maybe-unsafe { <maybe-default-maybe-unsafe-base>? }

    #---------------
    proto rule maybe-default-maybe-unsafe-base { * }

    rule maybe-default-maybe-unsafe-base:sym<a> { <kw-default> <kw-unsafe> }
    rule maybe-default-maybe-unsafe-base:sym<b> { <kw-default> }
    rule maybe-default-maybe-unsafe-base:sym<c> { <kw-unsafe> }
}

our role Unsafe::Actions {

    method maybe-unsafe($/) {
        make $/<kw-unsafe>:exists ?? Unsafe.new !! Nil
    }

    method maybe-default-maybe-unsafe($/) { make $<maybe-default-maybe-unsafe-base>.made }

    method maybe-default-maybe-unsafe-base:sym<a>($/) { make DefaultUnsafe.new }
    method maybe-default-maybe-unsafe-base:sym<b>($/) { make Default.new }
    method maybe-default-maybe-unsafe-base:sym<c>($/) { make Unsafe.new }
}
