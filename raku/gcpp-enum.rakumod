use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-attr;

our class EnumeratorList         { ... }
our class EnumeratorDefinition   { ... }
our class Enumerator { ... }
our class EnumHead { ... }
our class EnumKey { ... }

our role IEnumBase {  }

# rule enum-name { <identifier> }
our class EnumName { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist
    }
}

# rule enum-specifier { 
#   <enum-head> 
#   <.left-brace> 
#   [ <enumerator-list> <.comma>? ]? 
#   <.right-brace> 
# }
our class EnumSpecifier { 
    has EnumHead       $.enum-head is required;
    has EnumeratorList $.enumerator-list;

    has $.text;

    method gist{

        my $builder = $.enum-head.gist ~ "\{\n";

        if $.enumerator-list {
            $builder ~= $.enumerator-list.gist.indent(4);
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
our class EnumHead { 
    has EnumKey                $.enum-key is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has INestedNameSpecifier   $.nested-name-specifier;
    has Identifier             $.identifier;
    has IEnumBase              $.enum-base;

    has $.text;

    method gist{

        my $builder = $.enum-key.gist ~ " ";

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a ~ " ";
        }

        my $i = $.identifier;

        if $i {

            my $n = $.nested-name-specifier;

            if $n {
                $builder ~= $n.gist ~ " ";
            }

            $builder ~= $i.gist ~ " ";
        }

        if $.enum-base {
            $builder ~= $.enum-base.gist;
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
our class OpaqueEnumDeclaration { 
    has EnumKey                $.enum-key is required;
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has Identifier             $.identifier is required;
    has IEnumBase              $.enum-base is required;

    has $.text;

    method gist{

        my $builder = $.enum-key.gist;

        if $.comment {
            $builder ~= $.comment.gist ~ "\n";
        }

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist ~ " ";
        }

        $builder ~= $.identifier.gist;

        if $.enum-base {
            $builder ~= "\n" ~ $.enum-base.gist;
        }

        $builder ~ ";"
    }
}

# rule enumkey { 
#   <enum_> 
#   [ <class_> || <struct> ]? 
# }
our class EnumKey { 

    has $.text;
    has Bool $.has-modifier is required;
    has Bool $.is-class;

    method gist{

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
our class Enumbase { 

    has ITypeSpecifierSeq $.type-specifier-seq is required;

    has $.text;

    method gist{
        ": " ~ $.type-specifier-seq.gist
    }
}

# rule enumerator-list { 
#   <enumerator-definition> 
#   [ <.comma> <enumerator-definition> ]* 
# }
our class EnumeratorList { 

    has EnumeratorDefinition @.enumerator-definitions is required;

    has $.text;

    method gist{
        @.enumerator-definitions>>.gist.join(", ")
    }
}

# rule enumerator-definition { 
#   <enumerator> 
#   [ <assign> <constant-expression> ]? 
# }
our class EnumeratorDefinition { 
    has Enumerator          $.enumerator is required;
    has IConstantExpression $.constant-expression;

    has $.text;

    method gist{

        my $builder = $.enumerator.gist;

        my $c = $.constant-expression;

        if $c {
            $builder ~= " = " ~ $c.gist;
        }

        $builder
    }
}

# rule enumerator { 
#   <identifier> 
# }
our class Enumerator { 
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        $.identifier.gist
    }
}

our role Enum::Actions {

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

our role Enum::Rules {

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
