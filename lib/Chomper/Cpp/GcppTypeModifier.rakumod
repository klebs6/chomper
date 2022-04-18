unit module Chomper::Cpp::GcppTypeModifier;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

package SimpleTypeLengthModifier is export {

    # rule simple-type-length-modifier:sym<short> { 
    #   <.short> 
    # }
    class Short does ISimpleTypeLengthModifier { 

        has $.text;

        method name {
            'SimpleTypeLengthModifier::Short'
        }

        method gist(:$treemark=False) {
            "short"
        }
    }

    # rule simple-type-length-modifier:sym<long_> { 
    #   <.long_> 
    # }
    class Long does ISimpleTypeLengthModifier { 

        has $.text;

        method name {
            'SimpleTypeLengthModifier::Long'
        }

        method gist(:$treemark=False) {
            "long"
        }
    }
}

package SimpleTypeSignednessModifier is export {

    # rule simple-type-signedness-modifier:sym<unsigned> { 
    #   <.unsigned> 
    # }
    class Unsigned does ISimpleTypeSignednessModifier { 

        has $.text;

        method name {
            'SimpleTypeSignednessModifier::Unsigned'
        }

        method gist(:$treemark=False) {
            "unsigned"
        }
    }

    # rule simple-type-signedness-modifier:sym<signed> { 
    #   <.signed> 
    # }
    class Signed does ISimpleTypeSignednessModifier { 

        has $.text;

        method name {
            'SimpleTypeSignednessModifier::Signed'
        }

        method gist(:$treemark=False) {
            "signed"
        }
    }
}

package TypeModifierGrammar is export {

    our role Actions {

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

    our role Rules {

        proto rule simple-type-length-modifier { * }
        rule simple-type-length-modifier:sym<short>  { <short> }
        rule simple-type-length-modifier:sym<long_>  { <long_>  }

        proto rule simple-type-signedness-modifier         { * }
        rule simple-type-signedness-modifier:sym<unsigned> { <unsigned> }
        rule simple-type-signedness-modifier:sym<signed>   { <signed> }
    }
}
