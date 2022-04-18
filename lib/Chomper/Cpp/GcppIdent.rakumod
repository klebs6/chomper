unit module Chomper::Cpp::GcppIdent;

use Data::Dump::Tree;

use Chomper::TreeMark;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppChar;
use Chomper::Cpp::GcppDigit;

package IdentifierStart is export {

    our class Nondigit does IIdentifierStart {

        has Nondigit $.nondigit is required;

        has $.text;

        method name {
            'IdentifierStart::Nondigit'
        }

        method gist(:$treemark=False) {
            $.nondigit.gist(:$treemark)
        }
    }

    our class Ucn does IIdentifierStart {

        has UniversalCharacterName $.universalcharactername is required;

        has $.text;

        method name {
            'IdentifierStart::Ucn'
        }

        method gist(:$treemark=False) {
            $.universalcharactername.gist(:$treemark)
        }
    }
}

package IdentifierContinue is export {

    our class Digit does IIdentifierContinue {

        has Digit $.digit is required;

        has $.text;

        method name {
            'IdentifierContinue::Digit'
        }

        method gist(:$treemark=False) {
            $.digit.gist(:$treemark)
        }
    }

    our class Nondigit does IIdentifierContinue {

        has Nondigit $.nondigit is required;

        has $.text;

        method name {
            'IdentifierContinue::Nondigit'
        }

        method gist(:$treemark=False) {
            $.nondigit.gist(:$treemark)
        }
    }

    our class Ucn does IIdentifierContinue {

        has UniversalCharacterName $.universalcharactername is required;

        has $.text;

        method name {
            'IdentifierContinue::Ucn'
        }

        method gist(:$treemark=False) {
            $.universalcharactername.gist(:$treemark)
        }
    }
}

class Identifier 
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
does ITheTypeName is export { 
    has Str $.value is required; 

    method name {
        'Identifier'
    }

    method gist(:$treemark=False) {

        if $treemark {
            return sigil(TreeMark::<_Identifier>); 
        }

        $.value
    }
}

package IdentifierGrammar is export {

    our role Actions {

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

    our role Rules {

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
}
