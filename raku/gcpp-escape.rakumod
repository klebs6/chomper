use Data::Dump::Tree;

use gcpp-roles;
use gcpp-hex;
use gcpp-oct;

our class Escapesequence::Simple does IEscapesequence {
    has ISimpleescapesequence $.simpleescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Escapesequence::Octal does IEscapesequence {
    has Octalescapesequence $.octalescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Escapesequence::Hex does IEscapesequence {
    has Hexadecimalescapesequence $.hexadecimalescapesequence is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Slash does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Quote does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::Question does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::DoubleSlash does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::A does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::B does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::F does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::N does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::R does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::T does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::V does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Simpleescapesequence::RnN does ISimpleescapesequence { 
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role Escape::Actions {

    # token escapesequence:sym<simple> { <simpleescapesequence> }
    method escapesequence:sym<simple>($/) {
        make $<simpleescapesequence>.made
    }

    # token escapesequence:sym<octal> { <octalescapesequence> }
    method escapesequence:sym<octal>($/) {
        make $<octalescapesequence>.made
    }

    # token escapesequence:sym<hex> { <hexadecimalescapesequence> } 
    method escapesequence:sym<hex>($/) {
        make $<hexadecimalescapesequence>.made
    }

    # token simpleescapesequence:sym<slash> { '\\\'' }
    method simpleescapesequence:sym<slash>($/) {
        make Simpleescapesequence::Slash.new
    }

    # token simpleescapesequence:sym<quote> { '\\"' }
    method simpleescapesequence:sym<quote>($/) {
        make Simpleescapesequence::Quote.new
    }

    # token simpleescapesequence:sym<question> { '\\?' }
    method simpleescapesequence:sym<question>($/) {
        make Simpleescapesequence::Question.new
    }

    # token simpleescapesequence:sym<double-slash> { '\\\\' }
    method simpleescapesequence:sym<double-slash>($/) {
        make Simpleescapesequence::DoubleSlash.new
    }

    # token simpleescapesequence:sym<a> { '\\a' }
    method simpleescapesequence:sym<a>($/) {
        make Simpleescapesequence::A.new
    }

    # token simpleescapesequence:sym<b> { '\\b' }
    method simpleescapesequence:sym<b>($/) {
        make Simpleescapesequence::B.new
    }

    # token simpleescapesequence:sym<f> { '\\f' }
    method simpleescapesequence:sym<f>($/) {
        make Simpleescapesequence::F.new
    }

    # token simpleescapesequence:sym<n> { '\\n' }
    method simpleescapesequence:sym<n>($/) {
        make Simpleescapesequence::N.new
    }

    # token simpleescapesequence:sym<r> { '\\r' }
    method simpleescapesequence:sym<r>($/) {
        make Simpleescapesequence::R.new
    }

    # token simpleescapesequence:sym<t> { '\\t' }
    method simpleescapesequence:sym<t>($/) {
        make Simpleescapesequence::T.new
    }

    # token simpleescapesequence:sym<v> { '\\v' }
    method simpleescapesequence:sym<v>($/) {
        make Simpleescapesequence::V.new
    }

    # token simpleescapesequence:sym<rn-n> { '\\' [ || '\r' '\n'? || '\n' ] } 
    method simpleescapesequence:sym<rn-n>($/) {
        make Simpleescapesequence::RnN.new
    }

    # token octalescapesequence { '\\' [<octaldigit> ** 1..3] }
    method octalescapesequence($/) {
        make Octalescapesequence.new(
            digits => $<octaldigit>>>.made,
        )
    }

    # token hexadecimalescapesequence { '\\x' <hexadecimaldigit>+ }
    method hexadecimalescapesequence($/) {
        make Hexadecimalescapesequence.new(
            digits => $<hexadecimaldigit>>>.made,
        )
    }
}

our role Escape::Rules {

    proto token escapesequence { * }
    token escapesequence:sym<simple> { <simpleescapesequence> }
    token escapesequence:sym<octal>  { <octalescapesequence> }
    token escapesequence:sym<hex>    { <hexadecimalescapesequence> }

    proto token simpleescapesequence { * }
    token simpleescapesequence:sym<slash>        { '\\\'' }
    token simpleescapesequence:sym<quote>        { '\\"' }
    token simpleescapesequence:sym<question>     { '\\?' }
    token simpleescapesequence:sym<double-slash> { '\\\\' }
    token simpleescapesequence:sym<a>            { '\\a' }
    token simpleescapesequence:sym<b>            { '\\b' }
    token simpleescapesequence:sym<f>            { '\\f' }
    token simpleescapesequence:sym<n>            { '\\n' }
    token simpleescapesequence:sym<r>            { '\\r' }
    token simpleescapesequence:sym<t>            { '\\t' }
    token simpleescapesequence:sym<v>            { '\\v' }
    token simpleescapesequence:sym<rn-n> {
        '\\'
        [   
            ||  '\r' '\n'?
            ||  '\n'
        ]
    }

    token octalescapesequence {
        '\\' [<octaldigit> ** 1..3]
    }

    token hexadecimalescapesequence {
        '\\x' <hexadecimaldigit>+
    }
}
