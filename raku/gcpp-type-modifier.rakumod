# rule simple-type-length-modifier:sym<short> { 
#   <.short> 
# }
our class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-length-modifier:sym<long_> { 
#   <.long_> 
# }
our class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-signedness-modifier:sym<unsigned> { 
#   <.unsigned> 
# }
our class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-type-signedness-modifier:sym<signed> { 
#   <.signed> 
# }
our class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
