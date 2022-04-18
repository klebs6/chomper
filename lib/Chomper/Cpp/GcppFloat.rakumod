unit module Chomper::Cpp::GcppFloat;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDigit;

package FractionalConstant is export {

    our class WithTail does IFractionalConstant {

        has Str $.value is required;

        has $.text;

        method name {
            'FractionalConstant::WithTail'
        }

        method gist(:$treemark=False) {
            $.value
        }
    }

    our class NoTail does IFractionalConstant {

        has Str $.value is required;

        has $.text;

        method name {
            'FractionalConstant::NoTail'
        }

        method gist(:$treemark=False) {
            $.value
        }
    }
}

class ExponentPartPrefix is export { 

    has $.text;

    method name {
        'ExponentPartPrefix'
    }

    method gist(:$treemark=False) {
        'e'
    }
}

class ExponentPart is export { 

    has Str $.value is required;

    has $.text;

    method name {
        'ExponentPart'
    }

    method gist(:$treemark=False) {
        $.value
    }
}

package Sign is export {

    our class Plus { 

        has $.text;

        method name {
            'Sign::Plus'
        }

        method gist(:$treemark=False) {
            "+"
        }
    }

    our class Minus { 

        has $.text;

        method name {
            'Sign::Minus'
        }

        method gist(:$treemark=False) {
            "-"
        }
    }
}

class FloatingSuffix is export { 

    has $.text;

    method name {
        'FloatingSuffix'
    }

    method gist(:$treemark=False) {
        'f'
    }
}

package FloatingLiteral is export {

    our class Frac does IFloatingLiteral {
        has IFractionalConstant $.fractionalconstant is required;
        has ExponentPart        $.exponentpart;
        has FloatingSuffix      $.floatingsuffix;

        has $.text;

        method name {
            'FloatingLiteral::Frac'
        }

        method gist(:$treemark=False) {
            my $builder = $.fractionalconstant.gist;

            if $.exponentpart {
                $builder ~= $.exponentpart.gist;
            }

            if $.floatingsuffix {
                $builder ~= $.floatingsuffix.gist;
            }

            $builder
        }
    }

    our class Digit does IFloatingLiteral {
        has DigitSequence  $.digitsequence is required;
        has ExponentPart   $.exponentpart  is required;
        has FloatingSuffix $.floatingsuffix;

        has $.text;

        method name {
            'FloatingLiteral::Digit'
        }

        method gist(:$treemark=False) {

            my $builder = $.digitsequence.gist ~ $.exponentpart.gist;

            if $.floatingsuffix {
                $builder ~= $.floatingsuffix.gist;
            }

            $builder
        }
    }
}

package FloatingLiteralGrammar is export {

    our role Actions {

        # token floating-literal:sym<frac> { <fractionalconstant> <exponentpart>? <floatingsuffix>? }
        method floating-literal:sym<frac>($/) {
            make FloatingLiteral::Frac.new(
                fractionalconstant => $<fractionalconstant>.made,
                exponentpart       => $<exponentpart>.made,
                floatingsuffix     => $<floatingsuffix>.made,
                text               => ~$/,
            )
        }

        # token floating-literal:sym<digit> { <digitsequence> <exponentpart> <floatingsuffix>? } 
        method floating-literal:sym<digit>($/) {
            make FloatingLiteral::Digit.new(
                digitsequence  => $<digitsequence>.made,
                exponentpart   => $<exponentpart>.made,
                floatingsuffix => $<floatingsuffix>.made,
                text           => ~$/,
            )
        }

        # token fractionalconstant:sym<with-tail> { <digitsequence>? '.' <digitsequence> }
        method fractionalconstant:sym<with-tail>($/) {
            make FractionalConstant::WithTail.new(
                value => ~$/,
            )
        }

        # token fractionalconstant:sym<no-tail> { <digitsequence> '.' }
        method fractionalconstant:sym<no-tail>($/) {
            make FractionalConstant::NoTail.new(
                value => ~$/,
            )
        }

        # token exponentpart-prefix { 'e' || 'E' }
        method exponentpart-prefix($/) {
            make ExponentPartPrefix.new
        }

        # token exponentpart { <exponentpart-prefix> <sign>? <digitsequence> }
        method exponentpart($/) {
            make ExponentPart.new(
                value => ~$/,
            )
        }

        # token sign { <[ + - ]> }
        method sign:sym<+>($/) {
            make Sign::Plus.new
        }

        # token sign { <[ + - ]> }
        method sign:sym<->($/) {
            make Sign::Minus.new
        }

        # token digitsequence { <digit> [ '\''? <digit>]* }
        method digitsequence($/) {
            make DigitSequence.new(
                digits => $<digit>>>.made,
                text   => ~$/,
            )
        }

        # token floatingsuffix { <[ f l F L ]> } 
        method floatingsuffix($/) {
            make FloatingSuffix.new
        }
    }

    our role Rules {

        proto token floating-literal { * }

        token floating-literal:sym<frac> {
            <fractionalconstant>
            <exponentpart>?
            <floatingsuffix>?
        }

        token floating-literal:sym<digit> {
            <digitsequence>
            <exponentpart>
            <floatingsuffix>?
        }

        proto token fractionalconstant { * }
        token fractionalconstant:sym<with-tail> { <digitsequence>?  '.' <digitsequence> }
        token fractionalconstant:sym<no-tail>   { <digitsequence> '.' }

        token exponentpart-prefix {
            'e' || 'E'
        }

        token exponentpart {
            <exponentpart-prefix> <sign>?  <digitsequence>
        }

        token sign {
            <[ + - ]>
        }

        token digitsequence {
            <digit> [  '\''?  <digit>]*
        }

        token floatingsuffix {
            <[ f l F L ]>
        }
    }
}
