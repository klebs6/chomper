unit module Chomper::Cpp::GcppSimpleTypeSpecifier;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppTypeName;
use Chomper::Cpp::GcppTemplate;
use Chomper::Cpp::GcppDecltype;

# rule simple-int-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <simple-type-length-modifier>* 
#   <int_> 
# }
class SimpleIntTypeSpecifier 
does ISimpleTypeSpecifier
is export { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifiers is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier, padr => True);

        for @.simple-type-length-modifiers {
            $builder  ~= $_.gist(:$treemark) ~ " ";
        }

        $builder ~ "int"
    }
}

# rule simple-char-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <char_> 
# }
class SimpleCharTypeSpecifier 
does ISimpleTypeSpecifier
is export {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";
        $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier, padr => True);
        $builder ~ "char"
    }
}

# rule simple-char16-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <char16> 
# }
class SimpleChar16TypeSpecifier 
does ISimpleTypeSpecifier
is export { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";
        $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier, padr => True);
        $builder ~ "char16"
    }
}

# rule simple-char32-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <char32> 
# }
class SimpleChar32TypeSpecifier 
does ISimpleTypeSpecifier
is export { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";
        $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier, padr => True);
        $builder ~ "char32"
    }
}

# rule simple-wchar-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <wchar> 
# }
class SimpleWcharTypeSpecifier 
does ISimpleTypeSpecifier
is export { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";
        $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier, padr => True);
        $builder ~ "wchar"
    }
}

# rule simple-double-type-specifier { 
#   <simple-type-length-modifier>? 
#   <double> 
# }
class SimpleDoubleTypeSpecifier 
does ISimpleTypeSpecifier
is export { 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";
        $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier, padr => True);
        $builder ~ "double"
    }
}

package SimpleTypeSpecifier is export {

    # regex simple-type-specifier:sym<int> { 
    #   <simple-int-type-specifier> 
    # }
    our class Int_ does ISimpleTypeSpecifier {
        has SimpleIntTypeSpecifier $.simple-int-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-int-type-specifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<full> { <full-type-name> }
    our class Full does ISimpleTypeSpecifier {
        has FullTypeName $.full-type-name is required;

        has $.text;

        method gist(:$treemark=False) {
            $.full-type-name.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
    our class Scoped does ISimpleTypeSpecifier {
        has ScopedTemplateId $.scoped-template-id is required;

        has $.text;

        method gist(:$treemark=False) {
            $.scoped-template-id.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
    our class SignednessMod does ISimpleTypeSpecifier {
        has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-type-signedness-modifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>? <simple-type-length-modifier>+ }
    our class SignednessModLength does ISimpleTypeSpecifier {
        has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
        has ISimpleTypeLengthModifier     @.simple-type-length-modifier is required;

        has $.text;

        method gist(:$treemark=False) {
            my $builder = "";

            $builder = $builder.&maybe-extend(:$treemark,$.simple-type-signedness-modifier);

            for @.simple-type-length-modifier {
                $builder ~= $_.gist(:$treemark);
            }

            $builder
        }
    }

    # regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
    our class Char_ does ISimpleTypeSpecifier {
        has SimpleCharTypeSpecifier $.simple-char-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-char-type-specifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
    our class Char16_ does ISimpleTypeSpecifier {
        has SimpleChar16TypeSpecifier $.simple-char16-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-char16-type-specifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
    our class Char32_ does ISimpleTypeSpecifier {
        has SimpleChar32TypeSpecifier $.simple-char32-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-char32-type-specifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
    our class Wchar_ does ISimpleTypeSpecifier {
        has SimpleWcharTypeSpecifier $.simple-wchar-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-wchar-type-specifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<bool> { <bool_> }
    our class Bool_ does ISimpleTypeSpecifier {

        has $.text;

        method gist(:$treemark=False) {
            if $treemark {
                "T"
            } else {
                "bool"
            }
        }
    }

    # regex simple-type-specifier:sym<float> { <float> }
    our class Float_ does ISimpleTypeSpecifier { 

        has $.text;

        method gist(:$treemark=False) {
            if $treemark {
                "T"
            } else {
                "float"
            }
        }
    }

    # regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
    our class Double_ does ISimpleTypeSpecifier {
        has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;

        has $.text;

        method gist(:$treemark=False) {
            $.simple-double-type-specifier.gist(:$treemark)
        }
    }

    # regex simple-type-specifier:sym<void> { <void_> }
    our class Void_ does ISimpleTypeSpecifier { 

        has $.text;

        method gist(:$treemark=False) {
            if $treemark {
                "T"
            } else {
                "void"
            }
        }
    }

    # regex simple-type-specifier:sym<auto> { <auto> }
    our class Auto_ does ISimpleTypeSpecifier { 

        has $.text;

        method gist(:$treemark=False) {
            if $treemark {
                "T"
            } else {
                "void"
            }
        }
    }

    # regex simple-type-specifier:sym<decltype> { 
    #   <decltype-specifier> 
    # }
    our class Decltype_ does ISimpleTypeSpecifier {
        has DecltypeSpecifier $.decltype-specifier is required;
        has $.text;

        method gist(:$treemark=False) {
            $.decltype-specifier.gist(:$treemark)
        }
    }
}
