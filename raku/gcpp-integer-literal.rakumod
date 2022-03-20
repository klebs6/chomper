our class IntegerLiteral::Dec 
does IIntegerLiteral {

    has DecimalLiteral $.decimal-literal is required;
    has IIntegersuffix $.integersuffix;

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Oct 
does IIntegerLiteral {

    has OctalLiteral       $.octal-literal is required;
    has IIntegersuffix      $.integersuffix;

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

our class IntegerLiteral::Bin 
does IIntegerLiteral {

    has BinaryLiteral      $.binary-literal is required;
    has IIntegersuffix      $.integersuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Digit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class DecimalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class OctalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class HexadecimalLiteral {
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class BinaryLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Nonzerodigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Octaldigit { 
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

our class Binarydigit { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Hexquad { 
    has Quad @hexadecimaldigit is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our subset Quad of List where (HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral, HexadecimalLiteral);

our role IntegerLiteral::Actions {

    # token integer-literal:sym<dec> { <decimal-literal> <integersuffix>? }
    method integer-literal:sym<dec>($/) {
        make IntegerLiteral::Dec.new(
            decimal-literal => $<decimal-literal>.made,
            integersuffix   => $<integersuffix>.made,
        )
    }

    # token integer-literal:sym<oct> { <octal-literal> <integersuffix>? }
    method integer-literal:sym<oct>($/) {
        make IntegerLiteral::Oct.new(
            octal-literal => $<octal-literal>.made,
            integersuffix => $<integersuffix>.made,
        )
    }

    # token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
    method integer-literal:sym<hex>($/) {
        make IntegerLiteral::Hex.new(
            hexadecimal-literal => $<hexadecimal-literal>.made,
            integersuffix       => $<integersuffix>.made,
        )
    }

    # token integer-literal:sym<bin> { <binary-literal> <integersuffix>? } 
    method integer-literal:sym<bin>($/) {
        make IntegerLiteral::Bin.new(
            binary-literal => $<binary-literal>.made,
            integersuffix  => $<integersuffix>.made,
        )
    }

    # token hexquad { <hexadecimaldigit> ** 4 }
    method hexquad($/) {
        make Hexquad.new(
            hexadecimaldigit => $<hexadecimaldigit>>>.made,
        )
    }

    # token decimal-literal { <nonzerodigit> [ '\''? <digit>]* }
    method decimal-literal($/) {
        make DecimalLiteral.new(
            value => ~$/,
        )
    }

    # token octal-literal { '0' [ '\''? <octaldigit>]* }
    method octal-literal($/) {
        make OctalLiteral.new(
            value => ~$/,
        )
    }

    # token hexadecimal-literal { [ '0x' || '0X' ] <hexadecimaldigit> [ '\''? <hexadecimaldigit> ]* }
    method hexadecimal-literal($/) {
        make HexadecimalLiteral.new(
            value => ~$/,
        )
    }

    # token binary-literal { [ '0b' || '0B' ] <binarydigit> [ '\''? <binarydigit> ]* }
    method binary-literal($/) {
        make BinaryLiteral.new(
            value => ~$/,
        )
    }

    # token nonzerodigit { <[ 1 .. 9 ]> }
    method nonzerodigit($/) {
        make Nonzerodigit.new(
            value => ~$/,
        )
    }

    # token octaldigit { <[ 0 .. 7 ]> }
    method octaldigit($/) {
        make Octaldigit.new(
            value => ~$/,
        )
    }

    # token hexadecimaldigit { <[ 0 .. 9 ]> }
    method hexadecimaldigit($/) {
        make Hexadecimaldigit.new(
            value => ~$/,
        )
    }

    # token binarydigit { <[ 0 1 ]> } 
    method binarydigit($/) {
        make Binarydigit.new(
            value => ~$/,
        )
    }
}

our role IntegerLiteral::Rules {

    proto token integer-literal { * }
    token integer-literal:sym<dec> { <decimal-literal>     <integersuffix>? }
    token integer-literal:sym<oct> { <octal-literal>       <integersuffix>? }
    token integer-literal:sym<hex> { <hexadecimal-literal> <integersuffix>? }
    token integer-literal:sym<bin> { <binary-literal>      <integersuffix>? }

    token hexquad {
        <hexadecimaldigit> ** 4
    }

    token decimal-literal {
        <nonzerodigit> [ '\''?  <digit>]*
    }

    token octal-literal {
        '0' [ '\''?  <octaldigit>]*
    }

    token hexadecimal-literal {
        [ '0x' || '0X' ] <hexadecimaldigit> [ '\''?  <hexadecimaldigit> ]*
    }

    token binary-literal {
        [ '0b' || '0B' ] <binarydigit> [ '\''?  <binarydigit> ]*
    }

    token nonzerodigit {
        <[ 1 .. 9 ]>
    }

    token octaldigit {
        <[ 0 .. 7 ]>
    }

    token hexadecimaldigit {
        <[ 0 .. 9 ]>
    }

    token binarydigit {
        <[ 0 1 ]>
    }
}
