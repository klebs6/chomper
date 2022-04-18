unit module Chomper::Cpp::GcppAttr;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAlign;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppBalanced;

our class AttributeList { ... }
our class Attrib     { ... }

our role IAttributeSpecifierSeq is export {  }

# rule attribute-specifier-seq { <attribute-specifier>+ }
class AttributeSpecifierSeq is export { 
    has IAttributeSpecifier @.attribute-specifier is required;

    has $.text;

    method name {
        'AttributeSpecifierSeq'
    }

    method gist(:$treemark=False) {
        @.attribute-specifier>>.gist(:$treemark).join(" ")
    }
}

# rule attribute-specifier:sym<double-braced> { 
#   <.left-bracket> 
#   <.left-bracket> 
#   <attribute-list>? 
#   <.right-bracket> 
#   <.right-bracket> 
# }
class AttributeSpecifier::DoubleBraced does IAttributeSpecifier is export {
    has AttributeList $.attribute-list;

    has $.text;

    method name {
        'AttributeSpecifier::DoubleBraced'
    }

    method gist(:$treemark=False) {

        my $builder = "[[";

        if $.attribute-list {
            $builder ~= $.attribute-list.gist(:$treemark);
        }

        $builder ~ "]]"
    }
}

# rule attribute-specifier:sym<alignment> { 
#   <alignmentspecifier> 
# }
class AttributeSpecifier::Alignment does IAttributeSpecifier is export {
    has IAlignmentSpecifier $.alignmentspecifier is required;

    has $.text;

    method name {
        'AttributeSpecifier::Alignment'
    }

    method gist(:$treemark=False) {
        $.alignmentspecifier.gist(:$treemark)
    }
}

# rule attribute-list { 
#   <attribute> 
#   [ <.comma> <attribute> ]* 
#   <ellipsis>? 
# }
class AttributeList is export { 
    has Attrib @.attributes is required;
    has Bool   $.has-ellipsis is required;

    has $.text;

    method name {
        'AttributeList'
    }

    method gist(:$treemark=False) {

        my $builder = @.attributes>>.gist(:$treemark).join(", ");

        if $.has-ellipsis {
            $builder ~= "...";
        }

        $builder
    }
}

# rule attribute-namespace { <identifier> }
class AttributeNamespace is export { 
    has Identifier $.identifier is required;

    has $.text;

    method name {
        'AttributeNamespace'
    }

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

# rule attribute-argument-clause { 
#   <.left-paren> 
#   <balanced-token-seq>? 
#   <.right-paren> 
# }
class AttributeArgumentClause is export { 
    has BalancedTokenSeq $.balanced-token-seq;

    has $.text;

    method name {
        'AttributeArgumentClause'
    }

    method gist(:$treemark=False) {

        my $builder = "(";

        if $.balanced-token-seq {
            $builder ~= $.balanced-token-seq.gist(:$treemark);
        }

        $builder ~ ")"
    }
}

# rule attribute { 
#   [ <attribute-namespace> <doublecolon> ]? 
#   <identifier> 
#   <attribute-argument-clause>? 
# }
class Attrib is export { 
    has AttributeNamespace      $.attribute-namespace;
    has Identifier              $.identifier is required;
    has AttributeArgumentClause $.attribute-argument-clause;

    has $.text;

    method name {
        'Attrib'
    }

    method gist(:$treemark=False) {

        my $builder = "";

        if $.attribute-namespace {
            $builder ~= $.attribute-namespace.gist(:$treemark) ~ "::";
        }

        $builder ~= $.identifier.gist(:$treemark);

        if $.attribute-argument-clause {
            $builder ~= " " ~ $.attribute-argument-clause.gist(:$treemark);
        }

        $builder
    }
}

package AttributeSpecifierSeqGrammar is export {

    our role Actions {

        # rule attribute-specifier-seq { <attribute-specifier>+ } 
        method attribute-specifier-seq($/) {
            make $<attribute-specifier>>>.made
        }

        # rule attribute-specifier:sym<double-braced> { <.left-bracket> <.left-bracket> <attribute-list>? <.right-bracket> <.right-bracket> }
        method attribute-specifier:sym<double-braced>($/) {
            make $<attribute-list>.made
        }

        # rule attribute-specifier:sym<alignment> { <alignmentspecifier> } 
        method attribute-specifier:sym<alignment>($/) {
            make $<alignmentspecifier>.made
        }

        # rule attribute-list { <attribute> [ <.comma> <attribute> ]* <ellipsis>? }
        method attribute-list($/) {

            my $has-ellipsis = so $/<ellipsis>:exists;
            my @attribs      = $<attribute>>>.made;

            if $has-ellipsis {

                make AttributeList.new(
                    attributes   => @attribs,
                    has-ellipsis => $has-ellipsis,
                    text         => ~$/,
                )

            } else {
                make @attribs[0]
            }
        }

        # rule attribute { [ <attribute-namespace> <doublecolon> ]? <identifier> <attribute-argument-clause>? }
        method attribute($/) {
            make Attrib.new(
                attribute-namespace       => $<attribute-namespace>.made,
                identifier                => $<identifier>.made,
                attribute-argument-clause => $<attribute-argument-clause>.made,
                text                      => ~$/,
            )
        }

        # rule attribute-namespace { <identifier> }
        method attribute-namespace($/) {
            make $<identifier>.made
        }

        # rule attribute-argument-clause { <.left-paren> <balanced-token-seq>? <.right-paren> }
        method attribute-argument-clause($/) {
            make $<balanced-token-seq>.made
        }
    }

    our role Rules {

        rule attribute-list {
            <attribute>
            [ <comma> <attribute> ]*
            <ellipsis>?
        }

        rule attribute {
            [ <attribute-namespace> <doublecolon> ]?
            <identifier>
            <attribute-argument-clause>?
        }

        rule attribute-namespace {
            <identifier>
        }

        rule attribute-argument-clause {
            <left-paren> <balanced-token-seq>?  <right-paren>
        }

        rule attribute-specifier-seq {
            <attribute-specifier>+
        }

        #--------------------
        proto rule attribute-specifier { * }

        rule attribute-specifier:sym<double-braced> {
            <left-bracket>
            <left-bracket>
            <attribute-list>?
            <right-bracket>
            <right-bracket>
        }

        rule attribute-specifier:sym<alignment> {
            <alignmentspecifier>
        }
    }
}
