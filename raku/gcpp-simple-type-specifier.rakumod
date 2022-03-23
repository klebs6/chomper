use Data::Dump::Tree;

use gcpp-roles;
use gcpp-type-name;
use gcpp-template;
use gcpp-decltype;

# rule simple-int-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <simple-type-length-modifier>* 
#   <int_> 
# }
our class SimpleIntTypeSpecifier 
does ISimpleTypeSpecifier
{ 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifiers is required;

    has $.text;

    method gist{

        my $builder = "";

        $builder.&maybe-extend($.simple-type-signedness-modifier, padr => True);

        for @.simple-type-length-modifiers {
            $builder  ~= $_.gist ~ " ";
        }

        $builder ~ "int"
    }
}

# rule simple-char-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <char_> 
# }
our class SimpleCharTypeSpecifier 
does ISimpleTypeSpecifier
{
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        my $builder = "";
        $builder.&maybe-extend($.simple-type-signedness-modifier, padr => True);
        $builder ~ "char"
    }
}

# rule simple-char16-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <char16> 
# }
our class SimpleChar16TypeSpecifier 
does ISimpleTypeSpecifier
{ 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        my $builder = "";
        $builder.&maybe-extend($.simple-type-signedness-modifier, padr => True);
        $bulider ~ "char16"
    }
}

# rule simple-char32-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <char32> 
# }
our class SimpleChar32TypeSpecifier 
does ISimpleTypeSpecifier
{ 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        my $builder = "";
        $builder.&maybe-extend($.simple-type-signedness-modifier, padr => True);
        $bulider ~ "char32"
    }
}

# rule simple-wchar-type-specifier { 
#   <simple-type-signedness-modifier>? 
#   <wchar> 
# }
our class SimpleWcharTypeSpecifier 
does ISimpleTypeSpecifier
{ 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        my $builder = "";
        $builder.&maybe-extend($.simple-type-signedness-modifier, padr => True);
        $bulider ~ "wchar"
    }
}

# rule simple-double-type-specifier { 
#   <simple-type-length-modifier>? 
#   <double> 
# }
our class SimpleDoubleTypeSpecifier 
does ISimpleTypeSpecifier
{ 
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;

    has $.text;

    method gist{
        my $builder = "";
        $builder.&maybe-extend($.simple-type-signedness-modifier, padr => True);
        $bulider ~ "double"
    }
}

# regex simple-type-specifier:sym<int> { 
#   <simple-int-type-specifier> 
# }
our class SimpleTypeSpecifier::Int_ does ISimpleTypeSpecifier {
    has SimpleIntTypeSpecifier $.simple-int-type-specifier is required;

    has $.text;

    method gist{
        $.simple-int-type-specifier.gist
    }
}

# regex simple-type-specifier:sym<full> { <full-type-name> }
our class SimpleTypeSpecifier::Full does ISimpleTypeSpecifier {
    has FullTypeName $.full-type-name is required;

    has $.text;

    method gist{
        $.full-type-name.gist
    }
}

# regex simple-type-specifier:sym<scoped> { <scoped-template-id> }
our class SimpleTypeSpecifier::Scoped does ISimpleTypeSpecifier {
    has ScopedTemplateId $.scoped-template-id is required;

    has $.text;

    method gist{
        $.scoped-template-id.gist
    }
}

# regex simple-type-specifier:sym<signedness-mod> { <simple-type-signedness-modifier> }
our class SimpleTypeSpecifier::SignednessMod does ISimpleTypeSpecifier {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier is required;

    has $.text;

    method gist{
        $.simple-type-signedness-modifier.gist
    }
}

# regex simple-type-specifier:sym<signedness-mod-length> { <simple-type-signedness-modifier>? <simple-type-length-modifier>+ }
our class SimpleTypeSpecifier::SignednessModLength does ISimpleTypeSpecifier {
    has ISimpleTypeSignednessModifier $.simple-type-signedness-modifier;
    has ISimpleTypeLengthModifier     @.simple-type-length-modifier is required;

    has $.text;

    method gist{
        my $builder = "";

        $builder.&maybe-extend($.simple-type-signedness-modifier);

        for @.simple-type-length-modifier {
            $builder ~= $_.gist;
        }

        $builder
    }
}

# regex simple-type-specifier:sym<char> { <simple-char-type-specifier> }
our class SimpleTypeSpecifier::Char does ISimpleTypeSpecifier {
    has SimpleCharTypeSpecifier $.simple-char-type-specifier is required;

    has $.text;

    method gist{
        $.simple-char-type-specifier.gist
    }
}

# regex simple-type-specifier:sym<char16> { <simple-char16-type-specifier> }
our class SimpleTypeSpecifier::Char16 does ISimpleTypeSpecifier {
    has SimpleChar16TypeSpecifier $.simple-char16-type-specifier is required;

    has $.text;

    method gist{
        $.simple-char16-type-specifier.gist
    }
}

# regex simple-type-specifier:sym<char32> { <simple-char32-type-specifier> }
our class SimpleTypeSpecifier::Char32 does ISimpleTypeSpecifier {
    has SimpleChar32TypeSpecifier $.simple-char32-type-specifier is required;

    has $.text;

    method gist{
        $.simple-char32-type-specifier.gist
    }
}

# regex simple-type-specifier:sym<wchar> { <simple-wchar-type-specifier> }
our class SimpleTypeSpecifier::Wchar does ISimpleTypeSpecifier {
    has SimpleWcharTypeSpecifier $.simple-wchar-type-specifier is required;

    has $.text;

    method gist{
        $.simple-wchar-type-specifier.gist
    }
}

# regex simple-type-specifier:sym<bool> { <bool_> }
our class SimpleTypeSpecifier::Bool does ISimpleTypeSpecifier {

    has $.text;

    method gist{
        "bool"
    }
}

# regex simple-type-specifier:sym<float> { <float> }
our class SimpleTypeSpecifier::Float does ISimpleTypeSpecifier { 

    has $.text;

    method gist{
        "float"
    }
}

# regex simple-type-specifier:sym<double> { <simple-double-type-specifier> }
our class SimpleTypeSpecifier::Double does ISimpleTypeSpecifier {
    has SimpleDoubleTypeSpecifier $.simple-double-type-specifier is required;

    has $.text;

    method gist{
        $.simple-double-type-specifier.gist
    }
}

# regex simple-type-specifier:sym<void> { <void_> }
our class SimpleTypeSpecifier::Void does ISimpleTypeSpecifier { 

    has $.text;

    method gist{
        "void"
    }
}

# regex simple-type-specifier:sym<auto> { <auto> }
our class SimpleTypeSpecifier::Auto does ISimpleTypeSpecifier { 

    has $.text;

    method gist{
        "auto"
    }
}

# regex simple-type-specifier:sym<decltype> { 
#   <decltype-specifier> 
# }
our class SimpleTypeSpecifier::Decltype does ISimpleTypeSpecifier {
    has DecltypeSpecifier $.decltype-specifier is required;
    has $.text;

    method gist{
        $.decltype-specifier.gist
    }
}
