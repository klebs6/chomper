use Data::Dump::Tree;

use gcpp-roles;

our class DecimalLiteral { 
    has Str $.value is required; 

    has $.text;

    method gist {

        say "need write gist!";
        ddt self;
        exit;
    }
}

our class IntegerLiteral::Dec 
does IConstantExpression
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

our role Dec::Actions {

    # token integer-literal:sym<dec> { <decimal-literal> <integersuffix>? }
    method integer-literal:sym<dec>($/) {
        make IntegerLiteral::Dec.new(
            decimal-literal => $<decimal-literal>.made,
            integersuffix   => $<integersuffix>.made,
        )
    }

    # token decimal-literal { <nonzerodigit> [ '\''? <digit>]* }
    method decimal-literal($/) {
        make DecimalLiteral.new(
            value => ~$/,
        )
    }
}

our role Dec::Rules {

    token integer-literal:sym<dec> { <decimal-literal>     <integersuffix>? }

    token decimal-literal {
        <nonzerodigit> [ '\''?  <digit>]*
    }
}
