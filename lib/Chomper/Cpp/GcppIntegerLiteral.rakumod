unit module Chomper::Cpp::GcppIntegerLiteral;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDigit;
use Chomper::Cpp::GcppOct;
use Chomper::Cpp::GcppHex;
use Chomper::Cpp::GcppDec;
use Chomper::Cpp::GcppBin;

package IntegerLiteral is export {

    our class Oct does IIntegerLiteral {

        has OctalLiteral    $.octal-literal is required;
        has IIntegerSuffix  $.integersuffix;

        has $.text;

        method name {
            'IntegerLiteral::Oct'
        }

        method gist(:$treemark=False) {

            if $treemark { 
                return "N";
            }

            $.octal-literal.gist(:$treemark).&maybe-extend(:$treemark,$.integersuffix)
        }
    }

    our class Hex does IIntegerLiteral {

        has HexadecimalLiteral $.hexadecimal-literal is required;
        has IIntegerSuffix      $.integersuffix;

        has $.text;

        method name {
            'IntegerLiteral::Hex'
        }

        method gist(:$treemark=False) {

            if $treemark { 
                return "N";
            }

            my $builder = $.hexadecimal-literal.gist(:$treemark);

            if $.integersuffix {
                $builder ~= $.integersuffix.gist(:$treemark);
            }

            $builder
        }
    }

    our class Dec does IConstantExpression does IIntegerLiteral {

        has DecimalLiteral $.decimal-literal is required;
        has IIntegerSuffix $.integersuffix;

        has $.text;

        method name {
            'IntegerLiteral::Dec'
        }

        method gist(:$treemark=False) {

            if $treemark { 
                return "N";
            }

            if $.integersuffix {
                $.decimal-literal.gist(:$treemark) ~ $.integersuffix.gist(:$treemark)
            } else {
                $.decimal-literal.gist(:$treemark)
            }
        }
    }

    our class Bin does IIntegerLiteral {

        has BinaryLiteral  $.binary-literal is required;
        has IIntegerSuffix $.integersuffix;

        has $.text;

        method name {
            'IntegerLiteral::Bin'
        }

        method gist(:$treemark=False) {

            if $treemark { 
                return "N";
            }

            my $builder = $.binary-literal.gist(:$treemark);

            if $.integersuffix {
                $builder ~= $.integersuffix.gist(:$treemark);
            }

            $builder
        }
    }
}

package IntegerLiteralGrammar is export {

    our role Actions {

        # token integer-literal:sym<bin> { <binary-literal> <integersuffix>? } 
        method integer-literal:sym<bin>($/) {
            make IntegerLiteral::Bin.new(
                binary-literal => $<binary-literal>.made,
                integersuffix  => $<integersuffix>.made,
                text           => ~$/,
            )
        }

        # token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
        method integer-literal:sym<hex>($/) {
            make IntegerLiteral::Hex.new(
                hexadecimal-literal => $<hexadecimal-literal>.made,
                integersuffix       => $<integersuffix>.made,
                text                => ~$/,
            )
        }

        # token integer-literal:sym<dec> { <decimal-literal> <integersuffix>? }
        method integer-literal:sym<dec>($/) {
            make IntegerLiteral::Dec.new(
                decimal-literal => $<decimal-literal>.made,
                integersuffix   => $<integersuffix>.made,
                text            => ~$/,
            )
        }

        # token integer-literal:sym<oct> { <octal-literal> <integersuffix>? }
        method integer-literal:sym<oct>($/) {
            make IntegerLiteral::Oct.new(
                octal-literal => $<octal-literal>.made,
                integersuffix => $<integersuffix>.made,
                text          => ~$/,
            )
        }

        # token nonzerodigit { <[ 1 .. 9 ]> }
        method nonzerodigit($/) {
            make NonzeroDigit.new(
                value => ~$/,
            )
        }
    }

    our role Rules {

        proto token integer-literal { * }
        token integer-literal:sym<bin> { <binary-literal>      <integersuffix>? }
        token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
        token integer-literal:sym<dec> { <decimal-literal>     <integersuffix>? }
        token integer-literal:sym<oct> { <octal-literal>       <integersuffix>? }

        token nonzerodigit {
            <[ 1 .. 9 ]>
        }
    }
}
