unit module Chomper::Cpp::GcppSuffix;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class Unsignedsuffix { ... }
class Longsuffix     { ... }

class Integersuffix::Ul 
does IIntegersuffix is export {

    has Unsignedsuffix $.unsignedsuffix is required;
    has Longsuffix     $.longsuffix;

    has $.text;

    method gist(:$treemark=False) {
        $.unsignedsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.longsuffix)
    }
}

class Integersuffix::Ull 
does IIntegersuffix is export {

    has Unsignedsuffix $.unsignedsuffix is required;
    has ILonglongsuffix $.longlongsuffix;

    has $.text;

    method gist(:$treemark=False) {
        $.unsignedsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.longlongsuffix)
    }
}

class Integersuffix::Lu 
does IIntegersuffix is export {

    has Longsuffix     $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;

    has $.text;

    method gist(:$treemark=False) {
        $.longsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.unsignedsuffix)
    }
}

class Integersuffix::Llu 
does IIntegersuffix is export {

    has ILonglongsuffix $.longsuffix is required;
    has Unsignedsuffix $.unsignedsuffix;

    has $.text;

    method gist(:$treemark=False) {
        $.longsuffix.gist(:$treemark).&maybe-extend(:$treemark,$.unsignedsuffix)
    }
}

class Unsignedsuffix is export { 

    has $.text;

    method gist(:$treemark=False) {
        "u"
    }
}

class Longsuffix is export { 

    has $.text;

    method gist(:$treemark=False) {
        "l"
    }
}

class Longlongsuffix::Ll 
does ILonglongsuffix is export {

    has $.text;

    method gist(:$treemark=False) {
        "ll"
    }
}

class Longlongsuffix::LL 
does ILonglongsuffix is export {

    has $.text;

    method gist(:$treemark=False) {
        "LL"
    }
}

# token udsuffix { <identifier> }
class Udsuffix is export { 
    has Str $.value is required;
    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

package SuffixGrammar is export {

    our role Actions {

        # token integersuffix:sym<ul> { <unsignedsuffix> <longsuffix>? }
        method integersuffix:sym<ul>($/) {
            make Integersuffix::Ul.new(
                unsignedsuffix => $<unsignedsuffix>.made,
                longsuffix     => $<longsuffix>.made,
                text           => ~$/,
            )
        }

        # token integersuffix:sym<ull> { <unsignedsuffix> <longlongsuffix>? }
        method integersuffix:sym<ull>($/) {
            make Integersuffix::Ull.new(
                unsignedsuffix => $<unsignedsuffix>.made,
                longlongsuffix => $<longlongsuffix>.made,
                text           => ~$/,
            )
        }

        # token integersuffix:sym<lu> { <longsuffix> <unsignedsuffix>? }
        method integersuffix:sym<lu>($/) {
            make Integersuffix::Lu.new(
                longsuffix     => $<longsuffix>.made,
                unsignedsuffix => $<unsignedsuffix>.made,
                text           => ~$/,
            )
        }

        # token integersuffix:sym<llu> { <longlongsuffix> <unsignedsuffix>? } 
        method integersuffix:sym<llu>($/) {
            make Integersuffix::Llu.new(
                longsuffix     => $<longlongsuffix>.made,
                unsignedsuffix => $<unsignedsuffix>.made,
                text           => ~$/,
            )
        }

        # token unsignedsuffix { <[ u U ]> }
        method unsignedsuffix($/) {
            make Unsignedsuffix.new
        }

        # token longsuffix { <[ l L ]> } 
        method longsuffix($/) {
            make Longsuffix.new
        }

        # token longlongsuffix:sym<ll> { 'll' }
        method longlongsuffix:sym<ll>($/) {
            make Longlongsuffix::Ll.new
        }

        # token longlongsuffix:sym<LL> { 'LL' } 
        method longlongsuffix:sym<LL>($/) {
            make Longlongsuffix::LL.new
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
