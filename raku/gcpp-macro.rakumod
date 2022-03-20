
our class MultiLineMacro { 
    has Str $.content is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Directive { 
    has Str $.content is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
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
