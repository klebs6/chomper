unit module Chomper::Cpp::GcppUserDefinedLiteral;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppDec;
use Chomper::Cpp::GcppOct;
use Chomper::Cpp::GcppHex;
use Chomper::Cpp::GcppBin;
use Chomper::Cpp::GcppFloat;
use Chomper::Cpp::GcppChar;
use Chomper::Cpp::GcppStr;
use Chomper::Cpp::GcppIdent;

# token user-defined-integer-literal:sym<dec> { 
#   <decimal-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Dec 
does IUserDefinedIntegerLiteral {

    has DecimalLiteral $.decimal-literal is required;
    has Identifier     $.suffix is required;

    has $.text;

    method gist(:$treemark=False) {
        $.decimal-literal.gist(:$treemark) ~ $.suffix.gist(:$treemark)
    }
}

# token user-defined-integer-literal:sym<oct> { 
#   <octal-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Oct 
does IUserDefinedIntegerLiteral {

    has OctalLiteral $.octal-literal is required;
    has Identifier   $.suffix is required;

    has $.text;

    method gist(:$treemark=False) {
        $.octal-literal.gist(:$treemark) ~ $.suffix.gist(:$treemark)
    }
}

# token user-defined-integer-literal:sym<hex> { 
#   <hexadecimal-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Hex 
does IUserDefinedIntegerLiteral {

    has HexadecimalLiteral $.hexadecimal-literal is required;
    has Identifier         $.suffix is required;

    has $.text;

    method gist(:$treemark=False) {
        $.hexadecimal-literal.gist(:$treemark) ~ $.suffix.gist(:$treemark)
    }
}

# token user-defined-integer-literal:sym<bin> { 
#   <binary-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Bin 
does IUserDefinedIntegerLiteral {

    has BinaryLiteral $.binary-literal is required;
    has Identifier         $.suffix is required;

    has $.text;

    method gist(:$treemark=False) {
        $.binary-literal.gist(:$treemark) ~ $.suffix.gist(:$treemark)
    }
}

# token user-defined-floating-literal:sym<frac> { 
#   <fractionalconstant> 
#   <exponentpart>?  
#   <udsuffix> 
# }
our class UserDefinedFloatingLiteral::Frac
does IUserDefinedFloatingLiteral {

    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;
    has Identifier          $.suffix is required;

    has $.text;

    method gist(:$treemark=False) {
        $.fractionalconstant.gist(:$treemark).maybe-extend(:$treemark,$.exponentpart) ~ $.suffix.gist(:$treemark)
    }
}

# token user-defined-floating-literal:sym<digi> { 
#   <digitsequence> 
#   <exponentpart> 
#   <udsuffix> 
# }
our class UserDefinedFloatingLiteral::Digi 
does IUserDefinedFloatingLiteral {

    has Str $.value is required;

    method gist(:$treemark=False) {
        $.value
    }
}

# token user-defined-string-literal { 
#   <string-literal> 
#   <udsuffix> 
# }
our class UserDefinedStringLiteral {

    has Str $.value is required;

    method gist(:$treemark=False) {
        $.value
    }
}

# token user-defined-character-literal { 
#   <character-literal> 
#   <udsuffix> 
# }
our class UserDefinedCharacterLiteral {
    has Str $.value is required;

    method gist(:$treemark=False) {
        $.value
    }
}

our class UserDefinedLiteral::Int {
    has IUserDefinedIntegerLiteral   $.user-defined-integer-literal is required;

    method gist(:$treemark=False) {
        $.user-defined-integer-literal.gist(:$treemark)
    }
}

our class UserDefinedLiteral::Float 
does IUserDefinedLiteral {

    has IUserDefinedFloatingLiteral  $.user-defined-floating-literal is required;

    method gist(:$treemark=False) {
        $.user-defined-floating-literal.gist(:$treemark)
    }
}

our class UserDefinedLiteral::Str 
does IUserDefinedLiteral {

    has UserDefinedStringLiteral    $.user-defined-string-literal is required;

    has $.text;

    method gist(:$treemark=False) {
        $.user-defined-string-literal.gist(:$treemark)
    }
}

our class UserDefinedLiteral::Char 
does IUserDefinedLiteral {

    has UserDefinedCharacterLiteral $.user-defined-character-literal is required;

    has $.text;

    method gist(:$treemark=False) {
        $.user-defined-character-literal.gist(:$treemark)
    }
}

our role UserDefinedLiteral::Actions {

    # token user-defined-literal:sym<int> { <user-defined-integer-literal> }
    method user-defined-literal:sym<int>($/) {
        make $<user-defined-integer-literal>.made
    }

    # token user-defined-literal:sym<float> { <user-defined-floating-literal> }
    method user-defined-literal:sym<float>($/) {
        make $<user-defined-floating-literal>.made
    }

    # token user-defined-literal:sym<str> { <user-defined-string-literal> }
    method user-defined-literal:sym<str>($/) {
        make $<user-defined-string-literal>.made
    }

    # token user-defined-literal:sym<char> { <user-defined-character-literal> }
    method user-defined-literal:sym<char>($/) {
        make $<user-defined-character-literal>.made
    }

    # token user-defined-integer-literal:sym<dec> { <decimal-literal> <udsuffix> }
    method user-defined-integer-literal:sym<dec>($/) {
        make UserDefinedIntegerLiteral::Dec.new(
            decimal-literal => $<decimal-literal>.made,
            suffix          => $<udsuffix>.made,
            text            => ~$/,
        )
    }

    # token user-defined-integer-literal:sym<oct> { <octal-literal> <udsuffix> }
    method user-defined-integer-literal:sym<oct>($/) {
        make UserDefinedIntegerLiteral::Oct.new(
            octal-literal => $<octal-literal>.made,
            suffix        => $<udsuffix>.made,
            text          => ~$/,
        )
    }

    # token user-defined-integer-literal:sym<hex> { <hexadecimal-literal> <udsuffix> }
    method user-defined-integer-literal:sym<hex>($/) {
        make UserDefinedIntegerLiteral::Hex.new(
            hexadecimal-literal => $<hexadecimal-literal>.made,
            suffix              => $<udsuffix>.made,
            text                => ~$/,
        )
    }

    # token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> } 
    method user-defined-integer-literal:sym<bin>($/) {
        make UserDefinedIntegerLiteral::Bin.new(
            binary-literal => $<binary-literal>.made,
            suffix         => $<udsuffix>.made,
            text           => ~$/,
        )
    }

    # token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>? <udsuffix> }
    method user-defined-floating-literal:sym<frac>($/) {
        make UserDefinedFloatingLiteral::Frac.new(
            fractionalconstant => $<fractionalconstant>.made,
            exponentpart       => $<exponentpart>.made,
            text               => ~$/,
        )
    }

    # token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> } 
    method user-defined-floating-literal:sym<digi>($/) {
        make UserDefinedFloatingLiteral::Digi.new(
            value => ~$/,
        )
    }

    # token user-defined-string-literal { <string-literal> <udsuffix> }
    method user-defined-string-literal($/) {
        make UserDefinedStringLiteral.new(
            value => ~$/,
        )
    }

    # token user-defined-character-literal { <character-literal> <udsuffix> }
    method user-defined-character-literal($/) {
        make UserDefinedCharacterLiteral.new(
            value => ~$/,
        )
    }

    # token udsuffix { <identifier> }
    method udsuffix($/) {
        make $<identifier>.made
    }
}

our role UserDefinedLiteral::Rules {

    proto token user-defined-literal { * }
    token user-defined-literal:sym<int>   { <user-defined-integer-literal> }
    token user-defined-literal:sym<float> { <user-defined-floating-literal> }
    token user-defined-literal:sym<str>   { <user-defined-string-literal> }
    token user-defined-literal:sym<char>  { <user-defined-character-literal> }

    proto token user-defined-integer-literal { * }
    token user-defined-integer-literal:sym<dec> { <decimal-literal> <udsuffix> }
    token user-defined-integer-literal:sym<oct> { <octal-literal> <udsuffix> }
    token user-defined-integer-literal:sym<hex> { <hexadecimal-literal> <udsuffix> }
    token user-defined-integer-literal:sym<bin> { <binary-literal> <udsuffix> }

    proto token user-defined-floating-literal { * }
    token user-defined-floating-literal:sym<frac> { <fractionalconstant> <exponentpart>?  <udsuffix> }
    token user-defined-floating-literal:sym<digi> { <digitsequence> <exponentpart> <udsuffix> }

    token user-defined-string-literal    { <string-literal> <udsuffix> }
    token user-defined-character-literal { <character-literal> <udsuffix> }

    token udsuffix {
        <identifier>
    }
}