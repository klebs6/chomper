use Data::Dump::Tree;

use gcpp-roles;

our class MultiLineMacro { 
    has Str $.content is required;

    has $.text;

    method gist(:$treemark=False) {
        $.content
    }
}

our class Directive { 
    has Str $.content is required;

    has $.text;

    method gist(:$treemark=False) {
        $.content
    }
}

our role MultiLineMacro::Actions {

    # token multi-line-macro { '
    method multi-line-macro($/) {
        make ~$/
    }

    # token directive { '
    method directive($/) {
        make ~$/
    }
}

our role MultiLineMacro::Rules {

    token multi-line-macro {
        '#'
        [ <-[ \n ]>*? '\\' '\r'? '\n' ]
        <-[ \n ]>+
    }

    token directive {
        '#' <-[ \n ]>*
    }
}
