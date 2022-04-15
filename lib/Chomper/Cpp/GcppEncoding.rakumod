unit module Chomper::Cpp::GcppEncoding;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class Encodingprefix::U8 does IEncodingprefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'u8'
    }
}

class Encodingprefix::u  does IEncodingprefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'u'
    }
}

class Encodingprefix::U  does IEncodingprefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'U'
    }
}

class Encodingprefix::L  does IEncodingprefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'L'
    }
}

package EncodingGrammar is export {

    our role Actions {

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

    our role Rules {

        proto token encodingprefix { * }
        token encodingprefix:sym<u8> { 'u8' }
        token encodingprefix:sym<u>  { 'u' }
        token encodingprefix:sym<U>  { 'U' }
        token encodingprefix:sym<L>  { 'L' }
    }
}
