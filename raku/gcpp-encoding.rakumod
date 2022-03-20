
our class Encodingprefix::U8 does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Encodingprefix::u  does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Encodingprefix::U  does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Encodingprefix::L  does IEncodingprefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Encoding::Actions {

    # token encodingprefix:sym<u8> { 'u8' }
    method encodingprefix:sym<u8>($/) {
        make Encodingprefix::U8.new
    }

    # token encodingprefix:sym<u> { 'u' }
    method encodingprefix:sym<u>($/) {
        make Encodingprefix::U.new
    }

    # token encodingprefix:sym<U> { 'U' }
    method encodingprefix:sym<U>($/) {
        make Encodingprefix::U.new
    }

    # token encodingprefix:sym<L> { 'L' } 
    method encodingprefix:sym<L>($/) {
        make Encodingprefix::L.new
    }
}
