use Data::Dump::Tree;

use gcpp-roles;
use gcpp-digit;

our class Fractionalconstant::WithTail 
does IFractionalconstant {

    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Fractionalconstant::NoTail 
does IFractionalconstant {

    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class ExponentpartPrefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Exponentpart { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Sign::Plus { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Sign::Minus { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Floatingsuffix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class FloatingLiteral::Frac does IFloatingLiteral {
    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;
    has Floatingsuffix      $.floatingsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class FloatingLiteral::Digit does IFloatingLiteral {
    has Digitsequence  $.digitsequence is required;
    has Exponentpart   $.exponentpart  is required;
    has Floatingsuffix $.floatingsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role FloatingLiteral::Actions {

    # token floating-literal:sym<frac> { <fractionalconstant> <exponentpart>? <floatingsuffix>? }
    method floating-literal:sym<frac>($/) {
        make FloatingLiteral::Frac.new(
            fractionalconstant => $<fractionalconstant>.made,
            exponentpart       => $<exponentpart>.made,
            floatingsuffix     => $<floatingsuffix>.made,
        )
    }

    # token floating-literal:sym<digit> { <digitsequence> <exponentpart> <floatingsuffix>? } 
    method floating-literal:sym<digit>($/) {
        make FloatingLiteral::Digit.new(
            digitsequence  => $<digitsequence>.made,
            exponentpart   => $<exponentpart>.made,
            floatingsuffix => $<floatingsuffix>.made,
        )
    }

    # token fractionalconstant:sym<with-tail> { <digitsequence>? '.' <digitsequence> }
    method fractionalconstant:sym<with-tail>($/) {
        make Fractionalconstant::WithTail.new(
            value => ~$/,
        )
    }

    # token fractionalconstant:sym<no-tail> { <digitsequence> '.' }
    method fractionalconstant:sym<no-tail>($/) {
        make Fractionalconstant::NoTail.new(
            value => ~$/,
        )
    }

    # token exponentpart-prefix { 'e' || 'E' }
    method exponentpart-prefix($/) {
        make ExponentpartPrefix.new
    }

    # token exponentpart { <exponentpart-prefix> <sign>? <digitsequence> }
    method exponentpart($/) {
        make Exponentpart.new(
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
        make Digitsequence.new(
            digits => $<digit>>>.made,
        )
    }

    # token floatingsuffix { <[ f l F L ]> } 
    method floatingsuffix($/) {
        make Floatingsuffix.new
    }
}

our role FloatingLiteral::Rules {

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
