unit module Chomper::Cpp::GcppEnum;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppAttr;

our class EnumeratorList         { ... }
our class EnumeratorDefinition   { ... }
our class Enumerator { ... }
our class EnumHead { ... }
our class EnumKey { ... }

our role IEnumBase {  }

# rule enum-name { <identifier> }
class EnumName is export { 
    has Identifier $.identifier is required;

    has $.text;

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

# rule enum-specifier { 
#   <enum-head> 
#   <.left-brace> 
#   [ <enumerator-list> <.comma>? ]? 
#   <.right-brace> 
# }
class EnumSpecifier is export { 
    has EnumHead       $.enum-head is required;
    has EnumeratorList $.enumerator-list;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.enum-head.gist(:$treemark) ~ "\{\n";

        if $.enumerator-list {
            $builder ~= $.enumerator-list.gist(:$treemark).indent(4);
        }

        $builder ~ "}"
    }
}

# rule enum-head { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   [ <nested-name-specifier>? <identifier> ]? 
#   <enumbase>? 
# }
class EnumHead is export { 
    has EnumKey                $.enum-key is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has INestedNameSpecifier   $.nested-name-specifier;
    has Identifier             $.identifier;
    has IEnumBase              $.enum-base;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.enum-key.gist(:$treemark) ~ " ";

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a ~ " ";
        }

        my $i = $.identifier;

        if $i {

            my $n = $.nested-name-specifier;

            if $n {
                $builder ~= $n.gist(:$treemark) ~ " ";
            }

            $builder ~= $i.gist(:$treemark) ~ " ";
        }

        if $.enum-base {
            $builder ~= $.enum-base.gist(:$treemark);
        }

        $builder
    }
}

# rule opaque-enum-declaration { 
#   <.enumkey> 
#   <attribute-specifier-seq>? 
#   <identifier> 
#   <enumbase>? 
#   <semi> 
# }
class OpaqueEnumDeclaration is export { 
    has EnumKey                $.enum-key is required;
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Identifier             $.identifier is required;
    has IEnumBase              $.enum-base is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.enum-key.gist(:$treemark);

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist(:$treemark) ~ " ";
        }

        $builder ~= $.identifier.gist(:$treemark);

        if $.enum-base {
            $builder ~= "\n" ~ $.enum-base.gist(:$treemark);
        }

        $builder ~ ";"
    }
}

# rule enumkey { 
#   <enum_> 
#   [ <class_> || <struct> ]? 
# }
class EnumKey is export { 

    has $.text;
    has Bool $.has-modifier is required;
    has Bool $.is-class;

    method gist(:$treemark=False) {

        my $builder = "enum";

        if $.has-modifier {
            if $.is-class {
                $builder ~= " class";
            } else {
                $builder ~= " struct";
            }
        }

        $builder
    }
}

# rule enumbase { 
#   <colon> 
#   <type-specifier-seq> 
# }
class Enumbase is export { 

    has ITypeSpecifierSeq $.type-specifier-seq is required;

    has $.text;

    method gist(:$treemark=False) {
        ": " ~ $.type-specifier-seq.gist(:$treemark)
    }
}

# rule enumerator-list { 
#   <enumerator-definition> 
#   [ <.comma> <enumerator-definition> ]* 
# }
class EnumeratorList is export { 

    has EnumeratorDefinition @.enumerator-definitions is required;

    has $.text;

    method gist(:$treemark=False) {
        @.enumerator-definitions>>.gist(:$treemark).join(", ")
    }
}

# rule enumerator-definition { 
#   <enumerator> 
#   [ <assign> <constant-expression> ]? 
# }
class EnumeratorDefinition is export { 
    has Enumerator          $.enumerator is required;
    has IConstantExpression $.constant-expression;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.enumerator.gist(:$treemark);

        my $c = $.constant-expression;

        if $c {
            $builder ~= " = " ~ $c.gist(:$treemark);
        }

        $builder
    }
}

# rule enumerator { 
#   <identifier> 
# }
class Enumerator is export { 
    has Identifier $.identifier is required;

    has $.text;

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

package EnumGrammar is export {

    our role Actions {

        # rule enum-name { <identifier> }
        method enum-name($/) {
            make $<identifier>.made
        }

        # rule enum-specifier { <enum-head> <.left-brace> [ <enumerator-list> <.comma>? ]? <.right-brace> }
        method enum-specifier($/) {
            make EnumSpecifier.new(
                enumerator-list => $<enumerator-list>.made,
                text            => ~$/,
            )
        }

        # rule enum-head { <.enumkey> <attribute-specifier-seq>? [ <nested-name-specifier>? <identifier> ]? <enumbase>? }
        method enum-head($/) {
            make EnumHead.new(
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                nested-name-specifier   => $<nested-name-specifier>.made,
                identifier              => $<identifier>.made,
                enum-base               => $<enum-base>.made,
                text                    => ~$/,
            )
        }

        # rule opaque-enum-declaration { <.enumkey> <attribute-specifier-seq>? <identifier> <enumbase>? <semi> }
        method opaque-enum-declaration($/) {
            make OpaqueEnumDeclaration.new(
                comment                 => $<semi>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                identifier              => $<identifier>.made,
                enum-base               => $<enum-base>.made,
                text                    => ~$/,
            )
        }

        # rule enumkey { <enum_> [ <class_> || <struct> ]? }
        method enumkey($/) {
            make EnumKey.new
        }

        # rule enumbase { <colon> <type-specifier-seq> }
        method enumbase($/) {
            make Enumbase.new(
                type-specifier-seq => $<type-specifier-seq>.made,
                text               => ~$/,
            )
        }

        # rule enumerator-list { <enumerator-definition> [ <.comma> <enumerator-definition> ]* }
        method enumerator-list($/) {
            make $<enumerator-definition>>>.made
        }

        # rule enumerator-definition { <enumerator> [ <assign> <constant-expression> ]? }
        method enumerator-definition($/) {
            make EnumeratorDefinition.new(
                enumerator          => $<enumerator>.made,
                constant-expression => $<constant-expression>.made,
                text                => ~$/,
            )
        }

        # rule enumerator { <identifier> }
        method enumerator($/) {
            make $<identifier>.made
        }
    }

    our role Rules {

        rule elaborated-type-specifier:sym<enum> {
            <enum_> <nested-name-specifier>? <identifier>
        }

        rule enum-name {
            <identifier>
        }

        rule enum-specifier {
            <enum-head>
            <left-brace>
            [ <enumerator-list> <comma>?  ]?
            <right-brace>
        }

        rule enum-head {
            <enumkey>
            <attribute-specifier-seq>?
            [ <nested-name-specifier>? <identifier> ]?
            <enumbase>?
        }

        rule opaque-enum-declaration {
            <enumkey>
            <attribute-specifier-seq>?
            <identifier>
            <enumbase>?
            <semi>
        }

        rule enumkey {
            <enum_>
            [  <class_> || <struct> ]?
        }

        rule enumbase {
            <colon> <type-specifier-seq>
        }

        rule enumerator-list {
            <enumerator-definition>
            [ <comma> <enumerator-definition> ]*
        }

        rule enumerator-definition {
            <enumerator>
            [ <assign> <constant-expression> ]?
        }

        rule enumerator {
            <identifier>
        }
    }
}
