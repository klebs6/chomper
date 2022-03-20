
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

