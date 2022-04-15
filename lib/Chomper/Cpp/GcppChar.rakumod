unit module Chomper::Cpp::GcppChar;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppHex;

class Universalcharactername is export {
    has Hexquad $.first is required;
    has Hexquad $.second;

    has $.text;

    method gist(:$treemark=False) {
        if $.second {
            "\\U" ~ $.first.gist(:$treemark) ~ $.second.gist(:$treemark)
        } else {
            "\\u" ~ $.first.gist(:$treemark)
        }
    }
}

class Cchar::Basic does ICchar is export {
    has Str $.value is required;

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

class Cchar::Escape does ICchar is export {
    has IEscapesequence $.escapesequence is required;

    has $.text;

    method gist(:$treemark=False) {
        $.escapesequence.gist(:$treemark)
    }
}

class Cchar::Universal does ICchar is export {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist(:$treemark=False) {
        $.universalcharactername.gist(:$treemark)
    }
}

class Schar::Basic does ISchar is export {
    has Str $.value is required;

    has $.text;

    method gist(:$treemark=False) {
        $.value.gist(:$treemark)
    }
}

class Schar::Escape does ISchar is export {
    has IEscapesequence $.escapesequence is required;

    has $.text;

    method gist(:$treemark=False) {
        $.escapesequence.gist(:$treemark)
    }
}

class Schar::Ucn does ISchar is export {
    has Universalcharactername $.universalcharactername is required;

    has $.text;

    method gist(:$treemark=False) {
        $.universalcharactername.gist(:$treemark)
    }
}

class CharacterLiteralPrefix::U    does ICharacterLiteralPrefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'u'
    }
}

class CharacterLiteralPrefix::BigU does ICharacterLiteralPrefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'U'
    }
}

class CharacterLiteralPrefix::L    does ICharacterLiteralPrefix is export { 

    has $.text;

    method gist(:$treemark=False) {
        'L'
    }
}

#-------------------------------
# token literal:sym<char> { <character-literal> }
class CharacterLiteral 
does ILiteral
does IInitializerClause is export {
    has ICharacterLiteralPrefix $.character-literal-prefix;
    has ICchar                  @.cchar;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.character-literal-prefix {
            $builder ~= $.character-literal-prefix.gist(:$treemark);
        }

        $builder = "'";

        for @.cchar {
            $builder ~= $_.gist(:$treemark);
        }

        $builder ~ "'"
    }
}

package CharacterLiteralGrammar is export {

    our role Actions {

        # token character-literal-prefix:sym<u> { 'u' }
        method character-literal-prefix:sym<u>($/) {
            make 'u'
        }

        # token character-literal-prefix:sym<U> { 'U' }
        method character-literal-prefix:sym<U>($/) {
            make 'U'
        }

        # token character-literal-prefix:sym<L> { 'L' }
        method character-literal-prefix:sym<L>($/) {
            make 'L'
        }

        # token character-literal { <character-literal-prefix>? '\'' <cchar>+ '\'' } 
        method character-literal($/) {
            make CharacterLiteral.new(
                character-literal-prefix => $<character-literal-prefix>.made,
                cchar                    => $<cchar>>>.made,
                text                     => ~$/,
            )
        }

        # token universalcharactername:sym<one> { '\\u' <hexquad> }
        method universalcharactername:sym<one>($/) {
            make Universalcharactername.new(
                first => $<first>.made,
                text  => ~$/,
            )
        }

        # token universalcharactername:sym<two> { '\\U' <hexquad> <hexquad> } 
        method universalcharactername:sym<two>($/) {
            make Universalcharactername.new(
                first  => $<first>.made,
                second => $<second>.made,
                text   => ~$/,
            )
        }

        # token cchar:sym<basic> { <-[ \' \\ \r \n ]> }
        method cchar:sym<basic>($/) {
            make Cchar::Basic.new(
                value => ~$/,
            )
        }

        # token cchar:sym<escape> { <escapesequence> }
        method cchar:sym<escape>($/) {
            make $<escapesequence>.made
        }

        # token cchar:sym<universal> { <universalcharactername> } 
        method cchar:sym<universal>($/) {
            make $<universalcharactername>.made
        }

        # token schar:sym<basic> { <-[ " \\ \r \n ]> }
        method schar:sym<basic>($/) {
            make Schar::Basic.new(
                value => ~$/,
            )
        }

        # token schar:sym<escape> { <escapesequence> }
        method schar:sym<escape>($/) {
            make $<escapesequence>.made
        }

        # token schar:sym<ucn> { <universalcharactername> }
        method schar:sym<ucn>($/) {
            make $<universalcharactername>.made
        }
    }

    our role Rules {

        proto token character-literal-prefix { * }
        token character-literal-prefix:sym<u> { 'u' }
        token character-literal-prefix:sym<U> { 'U' }
        token character-literal-prefix:sym<L> { 'L' }

        token character-literal {
            <character-literal-prefix>? '\'' <cchar>+ '\''
        }

        proto token cchar { * }
        token cchar:sym<basic>     { <-[ \' \\ \r \n ]> }
        token cchar:sym<escape>    { <escapesequence> }
        token cchar:sym<universal> { <universalcharactername> }

        proto token universalcharactername { * }
        token universalcharactername:sym<one> { '\\u' <hexquad> }
        token universalcharactername:sym<two> { '\\U' <hexquad> <hexquad> }

        proto token schar { * }
        token schar:sym<basic>  { <-[ " \\ \r \n ]> }
        token schar:sym<escape> { <escapesequence> }
        token schar:sym<ucn>    { <universalcharactername> }
    }
}
