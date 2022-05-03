unit module Chomper::Cpp::GcppEncoding;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package EncodingPrefix is export {

    class U8 does IEncodingPrefix is export { 

        has $.text;

        method name {
            'EncodingPrefix::U8'
        }

        method gist(:$treemark=False) {
            'u8'
        }
    }

    class SmallU  does IEncodingPrefix is export { 

        has $.text;

        method name {
            'EncodingPrefix::SmallU'
        }

        method gist(:$treemark=False) {
            'u'
        }
    }

    class BigU  does IEncodingPrefix is export { 

        has $.text;

        method name {
            'EncodingPrefix::BigU'
        }

        method gist(:$treemark=False) {
            'U'
        }
    }

    class L  does IEncodingPrefix is export { 

        has $.text;

        method name {
            'EncodingPrefix::L'
        }

        method gist(:$treemark=False) {
            'L'
        }
    }
}

package EncodingGrammar is export {

    our role Actions {

        # token encodingprefix:sym<u8> { 'u8' }
        method encodingprefix:sym<u8>($/) {
            make EncodingPrefix::U8.new
        }

        # token encodingprefix:sym<u> { 'u' }
        method encodingprefix:sym<u>($/) {
            make EncodingPrefix::SmallU.new
        }

        # token encodingprefix:sym<U> { 'U' }
        method encodingprefix:sym<U>($/) {
            make EncodingPrefix::BigU.new
        }

        # token encodingprefix:sym<L> { 'L' } 
        method encodingprefix:sym<L>($/) {
            make EncodingPrefix::L.new
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
