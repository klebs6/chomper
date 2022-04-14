use Data::Dump::Tree;

use tree-mark;

use gcpp-roles;
use gcpp-char;
use gcpp-digit;

our class IdentifierStart::Nondigit 
does IIdentifierStart {

    has Nondigit $.nondigit is required;

    has $.text;

    method gist(:$treemark=False) {
        $.nondigit.gist(:$treemark)
    }
}

our class IdentifierStart::Ucn 
does IIdentifierStart {

    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist(:$treemark=False) {
        $.universalcharactername.gist(:$treemark)
    }
}

our class IdentifierContinue::Digit 
does IIdentifierContinue {

    has Digit $.digit is required;

    has $.text;

    method gist(:$treemark=False) {
        $.digit.gist(:$treemark)
    }
}

our class IdentifierContinue::Nondigit 
does IIdentifierContinue {

    has Nondigit $.nondigit is required;

    has $.text;

    method gist(:$treemark=False) {
        $.nondigit.gist(:$treemark)
    }
}

our class IdentifierContinue::Ucn 
does IIdentifierContinue {

    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist(:$treemark=False) {
        $.universalcharactername.gist(:$treemark)
    }
}

our class Identifier 
does INewTypeId
does ITheTypeId
does ITemplateArgument
does ISimpleTypeSpecifier
does IConstantExpression
does IDeclSpecifier
does IPointerMemberExpression
does INoPointerDeclarator
does IForRangeInitializer
does IMultiplicativeExpression
does IParameterDeclarationBody
does IInitDeclarator
does IUnqualifiedId
does IIdExpression
does IPostfixExpressionBody
does IPostfixExpressionTail
does IPostListHead
does IDeclarator
does IDeclSpecifierSeq
does INoPointerDeclaratorBase
does IPointerDeclarator
does ITheTypeName { 
    has Str $.value is required; 

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_Identifier>); 
        }

        $.value
    }
}

our role Identifier::Actions {

    # token identifier-start:sym<nondigit> { <nondigit> }
    method identifier-start:sym<nondigit>($/) {
        make $<nondigit>.made
    }

    # token identifier-start:sym<ucn> { <universalcharactername> } 
    method identifier-start:sym<ucn>($/) {
        make $<universalcharactername>.made
    }

    # token identifier-continue:sym<digit> { <digit> }
    method identifier-continue:sym<digit>($/) {
        make $<digit>.made
    }

    # token identifier-continue:sym<nondigit> { <nondigit> }
    method identifier-continue:sym<nondigit>($/) {
        make $<nondigit>.made
    }

    # token identifier-continue:sym<ucn> { <universalcharactername> }
    method identifier-continue:sym<ucn>($/) {
        make $<universalcharactername>.made
    }

    # token identifier { <identifier-start> <identifier-continue>* }
    method identifier($/) {
        make Identifier.new(
            value => ~$/,
        )
    }

    # token nondigit { <[ a .. z A .. Z _]> }
    method nondigit($/) {
        make Nondigit.new(
            value => ~$/,
        )
    }

    # token digit { <[ 0 .. 9 ]> }
    method digit($/) {
        make Digit.new(
            value => ~$/,
        )
    }
}

our role Identifier::Rules {

    proto token identifier-start { * }
    token identifier-start:sym<nondigit> { <nondigit> }
    token identifier-start:sym<ucn>      { <universalcharactername> }

    proto token identifier-continue { * }
    token identifier-continue:sym<digit>    { <digit> }
    token identifier-continue:sym<nondigit> { <nondigit> }
    token identifier-continue:sym<ucn>      { <universalcharactername> }

    token identifier {
        <.identifier-start>
        <.identifier-continue>*
    }

    token nondigit {
        <[ a .. z A .. Z _]>
    }

    token digit {
        <[ 0 .. 9 ]>
    }
}
