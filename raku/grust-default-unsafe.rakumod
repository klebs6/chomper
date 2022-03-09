use Data::Dump::Tree;

our class Default { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class Unsafe { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our class DefaultUnsafe { 

    has $.text;

    submethod TWEAK {
        say self.gist;
    }

    method gist {
        say "need to write gist!";
        say $.text;
        ddt self;
        exit;
    }
}

our role Default::Rules {

    rule maybe-default {
        <kw-default>?
    }
}

our role Default::Actions {

    method maybe-default($/) {
        if $/<kw-default>:exists {
            make Default.new(
                text => ~$/,
            )
        }
    }
}

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
        make $/<kw-unsafe>:exists ?? Unsafe.new( text => ~$/ )!! Nil
    }

    method maybe-default-maybe-unsafe($/) { make $<maybe-default-maybe-unsafe-base>.made }

    method maybe-default-maybe-unsafe-base:sym<a>($/) { make DefaultUnsafe.new( text => ~$/ ) }
    method maybe-default-maybe-unsafe-base:sym<b>($/) { make Default.new(       text => ~$/ ) }
    method maybe-default-maybe-unsafe-base:sym<c>($/) { make Unsafe.new(        text => ~$/ ) }
}
