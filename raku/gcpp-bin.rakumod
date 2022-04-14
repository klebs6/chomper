use Data::Dump::Tree;

use gcpp-roles;

our class BinaryLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our class Binarydigit { 
    has Str $.value is required; 

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

our class IntegerLiteral::Bin 
does IIntegerLiteral {

    has BinaryLiteral  $.binary-literal is required;
    has IIntegersuffix $.integersuffix;

    has $.text;

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

our role Bin::Actions {

    # token integer-literal:sym<bin> { <binary-literal> <integersuffix>? } 
    method integer-literal:sym<bin>($/) {
        make IntegerLiteral::Bin.new(
            binary-literal => $<binary-literal>.made,
            integersuffix  => $<integersuffix>.made,
            text           => ~$/,
        )
    }

    # token binary-literal { [ '0b' || '0B' ] <binarydigit> [ '\''? <binarydigit> ]* }
    method binary-literal($/) {
        make BinaryLiteral.new(
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

our role Bin::Rules {

    token integer-literal:sym<bin> { <binary-literal>      <integersuffix>? }

    token binary-literal {
        [ '0b' || '0B' ] <binarydigit> [ '\''?  <binarydigit> ]*
    }

    token binarydigit {
        <[ 0 1 ]>
    }
}
