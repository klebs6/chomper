unit module Chomper::Cpp::GcppMacro;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

class MultiLineMacro is export { 
    has Str $.content is required;

    has $.text;

    method name {
        'MultiLineMacro'
    }

    method gist(:$treemark=False) {
        $.content
    }
}

class Directive is export { 
    has Str $.content is required;

    has $.text;

    method name {
        'Directive'
    }

    method gist(:$treemark=False) {
        $.content
    }
}

package MultiLineMacroGrammar is export {

    our role Actions {

        # token multi-line-macro { '
        method multi-line-macro($/) {
            make ~$/
        }

        # token directive { '
        method directive($/) {
            make ~$/
        }
    }

    our role Rules {

        token multi-line-macro {
            '#'
            [ <-[ \n ]>*? '\\' '\r'? '\n' ]
            <-[ \n ]>+
        }

        token directive {
            '#' <-[ \n ]>*
        }
    }
}
