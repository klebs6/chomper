use Data::Dump::Tree;

use gcpp-roles;

our class HexadecimalLiteral {
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our class Hexadecimaldigit { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our subset Quad of List where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);

our class Hexquad { 
    has Quad @.hexadecimaldigit is required;

    has $.text;

    method gist(:$treemark=False) {
        @.hexadecimaldigit>>.gist(:$treemark).join("")
    }
}

our class IntegerLiteral::Hex 
does IIntegerLiteral {

    has HexadecimalLiteral $.hexadecimal-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.hexadecimal-literal.gist(:$treemark);

        if $.integersuffix {
            $builder ~= $.integersuffix.gist(:$treemark);
        }

        $builder
    }
}

our class Hexadecimalescapesequence {
    has Hexadecimaldigit @.digits is required;

    has $.text;

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}

our role Hex::Actions {

    # token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
    method integer-literal:sym<hex>($/) {
        make IntegerLiteral::Hex.new(
            hexadecimal-literal => $<hexadecimal-literal>.made,
            integersuffix       => $<integersuffix>.made,
            text                => ~$/,
        )
    }

    # token hexquad { <hexadecimaldigit> ** 4 }
    method hexquad($/) {
        make Hexquad.new(
            hexadecimaldigit => $<hexadecimaldigit>>>.made,
            text             => ~$/,
        )
    }

    # token hexadecimal-literal { [ '0x' || '0X' ] <hexadecimaldigit> [ '\''? <hexadecimaldigit> ]* }
    method hexadecimal-literal($/) {
        make HexadecimalLiteral.new(
            value => ~$/,
        )
    }

    # token hexadecimaldigit { <[ 0 .. 9 ]> }
    method hexadecimaldigit($/) {
        make Hexadecimaldigit.new(
            value => ~$/,
        )
    }
}

our role Hex::Rules {

    token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }

    token hexquad {
        <hexadecimaldigit> ** 4
    }

    token hexadecimal-literal {
        [ '0x' || '0X' ] <hexadecimaldigit> [ '\''?  <hexadecimaldigit> ]*
    }

    token hexadecimaldigit {
        <[ 0 .. 9 ]>
    }
}
