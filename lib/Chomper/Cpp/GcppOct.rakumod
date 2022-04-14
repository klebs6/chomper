use Data::Dump::Tree;

use gcpp-roles;

our class OctalLiteral { 
    has Str $.value is required; 

    method gist(:$treemark=False) {

        if $treemark { 
            return "N";
        }

        $.value
    }
}

our class Octaldigit { 
    has Str $.value is required; 

    method gist(:$treemark=False) {
        $.value
    }
}

our class IntegerLiteral::Oct 
does IIntegerLiteral {

    has OctalLiteral    $.octal-literal is required;
    has IIntegersuffix  $.integersuffix;

    has $.text;

    method gist(:$treemark=False) {

        if $treemark { 
            return "N";
        }

        $.octal-literal.gist(:$treemark).&maybe-extend(:$treemark,$.integersuffix)
    }
}

our class Octalescapesequence {
    has Octaldigit @.digits is required;

    has $.text;

    method gist(:$treemark=False) {
        @.digits>>.gist(:$treemark).join("")
    }
}

our role Oct::Actions {

    # token integer-literal:sym<oct> { <octal-literal> <integersuffix>? }
    method integer-literal:sym<oct>($/) {
        make IntegerLiteral::Oct.new(
            octal-literal => $<octal-literal>.made,
            integersuffix => $<integersuffix>.made,
            text          => ~$/,
        )
    }

    # token octal-literal { '0' [ '\''? <octaldigit>]* }
    method octal-literal($/) {
        make OctalLiteral.new(
            value => ~$/,
        )
    }

    # token octaldigit { <[ 0 .. 7 ]> }
    method octaldigit($/) {
        make Octaldigit.new(
            value => ~$/,
        )
    }
}

our role Oct::Rules {

    token integer-literal:sym<oct> { <octal-literal>       <integersuffix>? }

    token octal-literal {
        '0' [ '\''?  <octaldigit>]*
    }

    token octaldigit {
        <[ 0 .. 7 ]>
    }
}
