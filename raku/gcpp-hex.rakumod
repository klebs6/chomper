use Data::Dump::Tree;

use gcpp-roles;

our class HexadecimalLiteral {
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexadecimaldigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our subset Quad of List where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);

our class Hexquad { 
    has Quad @hexadecimaldigit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Hex 
does IIntegerLiteral {

    has HexadecimalLiteral $.hexadecimal-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexadecimalescapesequence {
    has Hexadecimaldigit @.digits is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Hex::Actions {

    # token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
    method integer-literal:sym<hex>($/) {
        make IntegerLiteral::Hex.new(
            hexadecimal-literal => $<hexadecimal-literal>.made,
            integersuffix       => $<integersuffix>.made,
        )
    }

    # token hexquad { <hexadecimaldigit> ** 4 }
    method hexquad($/) {
        make Hexquad.new(
            hexadecimaldigit => $<hexadecimaldigit>>>.made,
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
