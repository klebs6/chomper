unit module Chomper::Cpp::GcppEncoding;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

our class Encodingprefix::U8 does IEncodingprefix { 

    has $.text;

    method gist(:$treemark=False) {
        'u8'
    }
}

our class Encodingprefix::u  does IEncodingprefix { 

    has $.text;

    method gist(:$treemark=False) {
        'u'
    }
}

our class Encodingprefix::U  does IEncodingprefix { 

    has $.text;

    method gist(:$treemark=False) {
        'U'
    }
}

our class Encodingprefix::L  does IEncodingprefix { 

    has $.text;

    method gist(:$treemark=False) {
        'L'
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

our role Encoding::Rules {

    proto token encodingprefix { * }
    token encodingprefix:sym<u8> { 'u8' }
    token encodingprefix:sym<u>  { 'u' }
    token encodingprefix:sym<U>  { 'U' }
    token encodingprefix:sym<L>  { 'L' }
}