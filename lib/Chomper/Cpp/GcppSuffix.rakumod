unit module Chomper::Cpp::GcppSuffix;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class UnsignedSuffix { ... }
class LongSuffix     { ... }

package IntegerSuffix is export {

    class Ul does IIntegerSuffix {

        has UnsignedSuffix $.unsignedsuffix is required;
        has LongSuffix     $.longsuffix;

        has $.text;

        method name {
            'IntegerSuffix::Ul'
        }

        method gist(:$treemark=False) {
            $.unsignedsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.longsuffix)
        }
    }

    class Ull does IIntegerSuffix {

        has UnsignedSuffix $.unsignedsuffix is required;
        has ILongLongSuffix $.longlongsuffix;

        has $.text;

        method name {
            'IntegerSuffix::Ull'
        }

        method gist(:$treemark=False) {
            $.unsignedsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.longlongsuffix)
        }
    }

    class Lu does IIntegerSuffix {

        has LongSuffix     $.longsuffix is required;
        has UnsignedSuffix $.unsignedsuffix;

        has $.text;

        method name {
            'IntegerSuffix::Lu'
        }

        method gist(:$treemark=False) {
            $.longsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.unsignedsuffix)
        }
    }

    class Llu does IIntegerSuffix {

        has ILongLongSuffix $.longsuffix is required;
        has UnsignedSuffix $.unsignedsuffix;

        has $.text;

        method name {
            'IntegerSuffix::Llu'
        }

        method gist(:$treemark=False) {
            $.longsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.unsignedsuffix)
        }
    }
}

class UnsignedSuffix is export { 

    has $.text;

    method name {
        'UnsignedSuffix'
    }

    method gist(:$treemark=False) {
        "u"
    }
}

class LongSuffix is export { 

    has $.text;

    method name {
        'LongSuffix'
    }

    method gist(:$treemark=False) {
        "l"
    }
}

package LongLongSuffix is export {

    class Ll does ILongLongSuffix {

        has $.text;

        method name {
            'LongLongSuffix::Ll'
        }

        method gist(:$treemark=False) {
            "ll"
        }
    }

    class LL does ILongLongSuffix {

        has $.text;

        method name {
            'LongLongSuffix::LL'
        }

        method gist(:$treemark=False) {
            "LL"
        }
    }

}

# token udsuffix { <identifier> }
class UdSuffix is export { 
    has Str $.value is required;
    has $.text;

    method name {
        'UdSuffix'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

package SuffixGrammar is export {

    our role Actions {

        # token integersuffix:sym<ul> { <unsignedsuffix> <longsuffix>? }
        method integersuffix:sym<ul>($/) {
            make IntegerSuffix::Ul.new(
                unsignedsuffix => $<unsignedsuffix>.made,
                longsuffix     => $<longsuffix>.made,
                text           => ~$/,
            )
        }

        # token integersuffix:sym<ull> { <unsignedsuffix> <longlongsuffix>? }
        method integersuffix:sym<ull>($/) {
            make IntegerSuffix::Ull.new(
                unsignedsuffix => $<unsignedsuffix>.made,
                longlongsuffix => $<longlongsuffix>.made,
                text           => ~$/,
            )
        }

        # token integersuffix:sym<lu> { <longsuffix> <unsignedsuffix>? }
        method integersuffix:sym<lu>($/) {
            make IntegerSuffix::Lu.new(
                longsuffix     => $<longsuffix>.made,
                unsignedsuffix => $<unsignedsuffix>.made,
                text           => ~$/,
            )
        }

        # token integersuffix:sym<llu> { <longlongsuffix> <unsignedsuffix>? } 
        method integersuffix:sym<llu>($/) {
            make IntegerSuffix::Llu.new(
                longsuffix     => $<longlongsuffix>.made,
                unsignedsuffix => $<unsignedsuffix>.made,
                text           => ~$/,
            )
        }

        # token unsignedsuffix { <[ u U ]> }
        method unsignedsuffix($/) {
            make UnsignedSuffix.new
        }

        # token longsuffix { <[ l L ]> } 
        method longsuffix($/) {
            make LongSuffix.new
        }

        # token longlongsuffix:sym<ll> { 'll' }
        method longlongsuffix:sym<ll>($/) {
            make LongLongSuffix::Ll.new
        }

        # token longlongsuffix:sym<LL> { 'LL' } 
        method longlongsuffix:sym<LL>($/) {
            make LongLongSuffix::LL.new
        }
    }

    our role Rules {

        proto token integersuffix { * }
        token integersuffix:sym<ul>  { <unsignedsuffix> <longsuffix>? }
        token integersuffix:sym<ull> { <unsignedsuffix> <longlongsuffix>? }
        token integersuffix:sym<lu>  { <longsuffix>     <unsignedsuffix>? }
        token integersuffix:sym<llu> { <longlongsuffix> <unsignedsuffix>? }

        token unsignedsuffix {
            <[ u U ]>
        }

        token longsuffix {
            <[ l L ]>
        }

        proto token longlongsuffix { * }
        token longlongsuffix:sym<ll> { 'll' }
        token longlongsuffix:sym<LL> { 'LL' }
    }
}
