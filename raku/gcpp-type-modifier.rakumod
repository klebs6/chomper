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

our role TypeModifier::Actions {

    # rule simple-type-length-modifier:sym<short> { <.short> }
    method simple-type-length-modifier:sym<short>($/) {
        make SimpleTypeLengthModifier::Short.new
    }

    # rule simple-type-length-modifier:sym<long_> { <.long_> }
    method simple-type-length-modifier:sym<long_>($/) {
        make SimpleTypeLengthModifier::Long.new
    }

    # rule simple-type-signedness-modifier:sym<unsigned> { <.unsigned> }
    method simple-type-signedness-modifier:sym<unsigned>($/) {
        make SimpleTypeSignednessModifier::Unsigned.new
    }

    # rule simple-type-signedness-modifier:sym<signed> { <.signed> }
    method simple-type-signedness-modifier:sym<signed>($/) {
        make SimpleTypeSignednessModifier::Signed.new
    }
}
