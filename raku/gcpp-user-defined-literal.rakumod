# token user-defined-integer-literal:sym<dec> { 
#   <decimal-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Dec 
does IUserDefinedIntegerLiteral {

    has DecimalLiteral $.decimal-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-integer-literal:sym<oct> { 
#   <octal-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Oct 
does IUserDefinedIntegerLiteral {

    has OctalLiteral $.octal-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-integer-literal:sym<hex> { 
#   <hexadecimal-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Hex 
does IUserDefinedIntegerLiteral {

    has HexadecimalLiteral $.hexadecimal-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-integer-literal:sym<bin> { 
#   <binary-literal> 
#   <udsuffix> 
# }
our class UserDefinedIntegerLiteral::Bin 
does IUserDefinedIntegerLiteral {

    has BinaryLiteral $.binary-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-floating-literal:sym<frac> { 
#   <fractionalconstant> 
#   <exponentpart>?  
#   <udsuffix> 
# }
our class UserDefinedFloatingLiteral::Frac
does IUserDefinedFloatingLiteral {

    has IFractionalconstant $.fractionalconstant is required;
    has Exponentpart        $.exponentpart;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-floating-literal:sym<digi> { 
#   <digitsequence> 
#   <exponentpart> 
#   <udsuffix> 
# }
our class UserDefinedFloatingLiteral::Digi 
does IUserDefinedFloatingLiteral {

    has Str $.value is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-string-literal { 
#   <string-literal> 
#   <udsuffix> 
# }
our class UserDefinedStringLiteral {

    has Str $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token user-defined-character-literal { 
#   <character-literal> 
#   <udsuffix> 
# }
our class UserDefinedCharacterLiteral {
    has Str $.value is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Int {
    has IUserDefinedIntegerLiteral   $.user-defined-integer-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Float 
does IUserDefinedLiteral {

    has IUserDefinedFloatingLiteral  $.user-defined-floating-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Str 
does IUserDefinedLiteral {

    has UserDefinedStringLiteral    $.user-defined-string-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}

our class UserDefinedLiteral::Char 
does IUserDefinedLiteral {

    has UserDefinedCharacterLiteral $.user-defined-character-literal is required;

    has $.text;

    method gist {
        say "need write gist!";
        ddt self;
        exit;
    }
}
