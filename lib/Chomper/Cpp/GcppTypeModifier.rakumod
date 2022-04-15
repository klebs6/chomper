unit module Chomper::Cpp::GcppTypeModifier;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

# rule simple-type-length-modifier:sym<short> { 
#   <.short> 
# }
class SimpleTypeLengthModifier::Short does ISimpleTypeLengthModifier is export { 

    has $.text;

    method gist(:$treemark=False) {
        "short"
    }
}

# rule simple-type-length-modifier:sym<long_> { 
#   <.long_> 
# }
class SimpleTypeLengthModifier::Long does ISimpleTypeLengthModifier is export { 

    has $.text;

    method gist(:$treemark=False) {
        "long"
    }
}

# rule simple-type-signedness-modifier:sym<unsigned> { 
#   <.unsigned> 
# }
class SimpleTypeSignednessModifier::Unsigned does ISimpleTypeSignednessModifier is export { 

    has $.text;

    method gist(:$treemark=False) {
        "unsigned"
    }
}

# rule simple-type-signedness-modifier:sym<signed> { 
#   <.signed> 
# }
class SimpleTypeSignednessModifier::Signed does ISimpleTypeSignednessModifier is export { 

    has $.text;

    method gist(:$treemark=False) {
        "signed"
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
