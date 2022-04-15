unit module Chomper::Cpp::GcppStr;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::TreeMark;

# token literal:sym<str> { <string-literal> }
class StringLiteral does ILiteral is export { 
    has Str $.value;

    has $.text;

    method gist(:$treemark=False) {
        if $treemark {
            sigil(TreeMark::<_Literal>)
        } else {
            $.value
        }
    }
}

class Rawstring is export { 
    has Str $.value is required;

    has $.text;

    method gist(:$treemark=False) {
        $.value
    }
}

package StringLiteralGrammar is export {

    our role Actions {

        # token string-literal-item { 
        #   <encodingprefix>? 
        #   [ || <rawstring> || '"' <schar>* '"' ] 
        # }
        method string-literal-item($/) {
            make ~$/;
        }

        # token string-literal { 
        #   <string-literal-item> 
        #   [<.ws> <string-literal-item>]* 
        # }
        method string-literal($/) {
            my @items = $<string-literal-item>>>.made;

            make StringLiteral.new(
                value => @items.join("\n"),
            )
        }

        # token rawstring { || 'R"' [ || [ || '\\' <[ " ( ) ]> ] || <-[ \r \n ( ]> ] '(' <-[ ) ]>*? ')' [ || [ || '\\' <[ " ( ) ]> ] || <-[ \r \n " ]> ] '"' }
        method rawstring($/) {
            make Rawstring.new(
                value => ~$/,
            )
        }
    }

    our role Rules {

        token string-literal-item {
            <encodingprefix>?
            [   
               || <rawstring>
               || '"' <schar>* '"'
            ]
        }

        token string-literal {
            <string-literal-item> 
            [<ws> <string-literal-item>]*
        }

        token rawstring {
            ||  'R"'
                [   ||  [   ||  '\\'
                                <[ " ( ) ]>
                        ]
                    ||  <-[ \r \n   ( ]>
                ]
                '('
                <-[ ) ]>*?
                ')'
                [   ||  [   ||  '\\'
                                <[ " ( ) ]>
                        ]
                    ||  <-[ \r \n   " ]>
                ]
                '"'
        }
    }
}
