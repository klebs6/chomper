
our class Fractionalconstant::WithTail 
does IFractionalconstant {

    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Fractionalconstant::NoTail 
does IFractionalconstant {

    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class ExponentpartPrefix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Exponentpart { 
    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Sign::Plus { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Sign::Minus { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Digitsequence { 
    has Digit @.digits is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class Floatingsuffix { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class FloatingLiteral::Frac does IFloatingLiteral {
    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;
    has Floatingsuffix      $.floatingsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class FloatingLiteral::Digit does IFloatingLiteral {
    has Digitsequence  $.digitsequence is required;
    has Exponentpart   $.exponentpart  is required;
    has Floatingsuffix $.floatingsuffix;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}
