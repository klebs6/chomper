unit module Chomper::Cpp::GcppMember;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppFunction;
use Chomper::Cpp::GcppIdent;
use Chomper::Cpp::GcppDeclaration;
use Chomper::Cpp::GcppTemplate;
use Chomper::Cpp::GcppVirtual;
use Chomper::Cpp::GcppPure;
use Chomper::Cpp::GcppUsingDirective;

# rule member-declarator-list { 
#   <member-declarator> 
#   [ <.comma> <member-declarator> ]* 
# }
class MemberDeclaratorList is export { 
    has IMemberDeclarator @.member-declarators is required;

    has $.text;

    method name {
        'MemberDeclaratorList'
    }

    method gist(:$treemark=False) {
        @.member-declarators>>.gist(:$treemark).join(",")
    }
}

package MemberSpecificationBase is export {

    # rule member-specification-base:sym<decl> { 
    #   <memberdeclaration> 
    # }
    our class Decl does IMemberSpecificationBase {
        has IMemberDeclaration $.memberdeclaration is required;
        has $.text;

        method name {
            'MemberSpecificationBase::Decl'
        }

        method gist(:$treemark=False) {
            $.memberdeclaration.gist(:$treemark)
        }
    }

    # rule member-specification-base:sym<access> { 
    #   <access-specifier> 
    #   <colon> 
    # }
    our class Access does IMemberSpecificationBase {
        has IAccessSpecifier $.access-specifier is required;
        has $.text;

        method name {
            'MemberSpecificationBase::Access'
        }

        method gist(:$treemark=False) {
            $.access-specifier.gist(:$treemark) ~ ":"
        }
    }
}

# rule member-specification { 
#   <member-specification-base>+ 
# }
class MemberSpecification is export { 
    has IMemberSpecificationBase @.member-specification-bases is required;
    has $.text;

    method name {
        'MemberSpecification'
    }

    method gist(:$treemark=False) {
        @.member-specification-bases.join(" ")
    }
}

package MemberDeclaration is export {

    # rule memberdeclaration:sym<basic> { 
    #   <attribute-specifier-seq>? 
    #   <decl-specifier-seq>? 
    #   <member-declarator-list>? 
    #   <semi> 
    # }
    our class Basic does IMemberDeclaration {
        has IComment               $.comment;
        has IAttributeSpecifierSeq $.attribute-specifier-seq;
        has IDeclSpecifierSeq      $.decl-specifier-seq;
        has MemberDeclaratorList   $.member-declarator-list;
        has $.text;

        method name {
            'MemberDeclaration::Basic'
        }

        method gist(:$treemark=False) {

            my $buffer = "";

            if $.comment {
                $buffer ~= $.comment.gist(:$treemark) ~ "\n";
            }

            my $a = $.attribute-specifier-seq;

            if $a {
                $buffer ~= $a.gist(:$treemark);
            }

            my $d = $.decl-specifier-seq;

            if $d {
                $buffer ~= " " ~ $d.gist(:$treemark);
            }

            my $m = $.member-declarator-list;

            if $m {
                $buffer ~= " " ~ $m.gist(:$treemark);
            }

            $buffer ~ ";"
        }
    }

    # rule memberdeclaration:sym<func> { 
    #   <function-definition> 
    # }
    our class Func does IMemberDeclaration {
        has FunctionDefinition $.function-definition is required;
        has $.text;

        method name {
            'MemberDeclaration::Func'
        }

        method gist(:$treemark=False) {
            $.function-definition.gist(:$treemark)
        }
    }

    # rule memberdeclaration:sym<using> { 
    #   <using-declaration> 
    # }
    our class Using does IMemberDeclaration {
        has UsingDeclaration $.using-declaration is required;
        has $.text;

        method name {
            'MemberDeclaration::Using'
        }

        method gist(:$treemark=False) {
            $.using-declaration.gist(:$treemark)
        }
    }

    # rule memberdeclaration:sym<static-assert> { 
    #   <static-assert-declaration> 
    # }
    our class StaticAssert does IMemberDeclaration {
        has StaticAssertDeclaration $.static-assert-declaration is required;
        has $.text;

        method name {
            'MemberDeclaration::StaticAssert'
        }

        method gist(:$treemark=False) {
            $.static-assert-declaration.gist(:$treemark)
        }
    }

    # rule memberdeclaration:sym<template> { 
    #   <template-declaration> 
    # }
    our class Template does IMemberDeclaration {
        has TemplateDeclaration $.template-declaration is required;
        has $.text;

        method name {
            'MemberDeclaration::Template'
        }

        method gist(:$treemark=False) {
            $.template-declaration.gist(:$treemark)
        }
    }

    # rule memberdeclaration:sym<alias> { 
    #   <alias-declaration> 
    # }
    our class Alias does IMemberDeclaration {
        has AliasDeclaration $.alias-declaration is required;
        has $.text;

        method name {
            'MemberDeclaration::Alias'
        }

        method gist(:$treemark=False) {
            $.alias-declaration.gist(:$treemark)
        }
    }

    # rule memberdeclaration:sym<empty> { 
    #   <empty-declaration> 
    # }
    our class Empty does IMemberDeclaration { 

        has $.text;

        method name {
            'MemberDeclaration::Empty'
        }

        method gist(:$treemark=False) {
            ""
        }
    }
}

package MemberDeclarator is export {

    # rule member-declarator:sym<virt> { 
    #   <declarator> 
    #   <virtual-specifier-seq>? 
    #   <pure-specifier>? 
    # }
    our class Virt does IMemberDeclarator {
        has IDeclarator         $.declarator is required;
        has VirtualSpecifierSeq $.virtual-specifier-seq;
        has PureSpecifier       $.pure-specifier;

        has $.text;

        method name {
            'MemberDeclarator::Virt'
        }

        method gist(:$treemark=False) {
            my $buffer = $.declarator.gist(:$treemark);

            my $v = $.virtual-specifier-seq;

            if $v {
                $buffer ~= " " ~ $v.gist(:$treemark);
            }

            my $p = $.pure-specifier;

            if $p {
                $buffer ~= " " ~ $p.gist(:$treemark);
            }

            $buffer
        }
    }

    # rule member-declarator:sym<brace-or-eq> { 
    #   <declarator> 
    #   <brace-or-equal-initializer>? 
    # }
    our class BraceOrEq does IMemberDeclarator {
        has IDeclarator              $.declarator is required;
        has IBraceOrEqualInitializer $.brace-or-equal-initializer;

        has $.text;

        method name {
            'MemberDeclarator::BraceOrEq'
        }

        method gist(:$treemark=False) {

            my $buffer = $.declarator.gist(:$treemark);

            my $i = $.brace-or-equal-initializer;

            if $i {
                $buffer ~= " " ~ $i.gist(:$treemark);
            }

            $buffer
        }
    }

    # rule member-declarator:sym<ident> { 
    #   <identifier>? 
    #   <attribute-specifier-seq>? 
    #   <colon> 
    #   <constant-expression> 
    # }
    our class Ident does IMemberDeclarator {
        has Identifier             $.identifier;
        has IAttributeSpecifierSeq $.attribute-specifier-seq;
        has IConstantExpression    $.constant-expression is required;

        has $.text;

        method name {
            'MemberDeclarator::Ident'
        }

        method gist(:$treemark=False) {

            my $buffer = "";

            if $.identifier {
                $buffer ~= $.identifier.gist(:$treemark);
            }

            if $.attribute-specifier-seq {
                $buffer ~= " " ~ $.attribute-specifier-seq.gist(:$treemark);
            }

            $buffer ~ ": " ~ $.constant-expression.gist(:$treemark)
        }
    }
}

package MemberGrammar is export {

    our role Actions {

        # rule member-specification-base:sym<decl> { <memberdeclaration> }
        method member-specification-base:sym<decl>($/) {
            make $<memberdeclaration>.made
        }

        # rule member-specification-base:sym<access> { <access-specifier> <colon> }
        method member-specification-base:sym<access>($/) {
            make MemberSpecificationBase::Access.new(
                access-specifier => $<access-specifier>.made,
                text             => ~$/,
            )
        }

        # rule member-specification { <member-specification-base>+ } 
        method member-specification($/) {
            make $<member-specification-base>>>.made
        }

        # rule memberdeclaration:sym<basic> { 
        #   <attribute-specifier-seq>? 
        #   <decl-specifier-seq>? 
        #   <member-declarator-list>? 
        #   <semi> 
        # }
        method memberdeclaration:sym<basic>($/) {
            make MemberDeclaration::Basic.new(
                comment                 => $<semi>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                decl-specifier-seq      => $<decl-specifier-seq>.made,
                member-declarator-list  => $<member-declarator-list>.made,
                text                    => ~$/,
            )
        }

        # rule memberdeclaration:sym<func> { <function-definition> }
        method memberdeclaration:sym<func>($/) {
            make $<function-definition>.made
        }

        # rule memberdeclaration:sym<using> { <using-declaration> }
        method memberdeclaration:sym<using>($/) {
            make $<using-declaration>.made
        }

        # rule memberdeclaration:sym<static-assert> { <static-assert-declaration> }
        method memberdeclaration:sym<static-assert>($/) {
            make $<static-assert-declaration>.made
        }

        # rule memberdeclaration:sym<template> { <template-declaration> }
        method memberdeclaration:sym<template>($/) {
            make $<template-declaration>.made
        }

        # rule memberdeclaration:sym<alias> { <alias-declaration> }
        method memberdeclaration:sym<alias>($/) {
            make $<alias-declaration>.made
        }

        # rule memberdeclaration:sym<empty> { <empty-declaration> } 
        method memberdeclaration:sym<empty>($/) {
            make MemberDeclaration::Empty.new
        }

        # rule member-declarator-list { <member-declarator> [ <.comma> <member-declarator> ]* } 
        method member-declarator-list($/) {
            make $<member-declarator>>>.made
        }

        # rule member-declarator:sym<virt> { <declarator> <virtual-specifier-seq>? <pure-specifier>? }
        method member-declarator:sym<virt>($/) {

            my $base = $<declarator>.made;
            my $t0   = $<virtual-specifier-seq>.made;
            my $t1   = $<pure-specifier>.made;

            if $t0 or $t1 {
                make MemberDeclarator::Virt.new(
                    declarator            => $base,
                    virtual-specifier-seq => $t0,
                    pure-specifier        => $t1,
                    text                  => ~$/,
                )
            } else {
                make $base
            }
        }

        # rule member-declarator:sym<brace-or-eq> { <declarator> <brace-or-equal-initializer>? }
        method member-declarator:sym<brace-or-eq>($/) {
            my $body = $<declarator>.made;
            my $tail = $<brace-or-equal-initializer>.made;

            if $tail {
                make MemberDeclarator::BraceOrEq.new(
                    declarator                 => $body,
                    brace-or-equal-initializer => $tail,
                    text                       => ~$/,
                )
            } else {
                make $body
            }
        }

        # rule member-declarator:sym<ident> { <identifier>? <attribute-specifier-seq>? <colon> <constant-expression> } 
        method member-declarator:sym<ident>($/) {
            make MemberDeclarator::Ident.new(
                identifier              => $<identifier>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                constant-expression     => $<constant-expression>.made,
                text                    => ~$/,
            )
        }
    }

    our role Rules {

        proto rule member-specification-base { * }
        rule member-specification-base:sym<decl>   { <memberdeclaration> }
        rule member-specification-base:sym<access> { <access-specifier> <colon> }

        rule member-specification {
            <member-specification-base>+
        }

        proto rule memberdeclaration { * }

        rule memberdeclaration:sym<basic> {
            <attribute-specifier-seq>?  
            <decl-specifier-seq>?  
            <member-declarator-list>?  
            <semi>
        }

        rule memberdeclaration:sym<func>          { <function-definition> }
        rule memberdeclaration:sym<using>         { <using-declaration> }
        rule memberdeclaration:sym<static-assert> { <static-assert-declaration> }
        rule memberdeclaration:sym<template>      { <template-declaration> }
        rule memberdeclaration:sym<alias>         { <alias-declaration> }
        rule memberdeclaration:sym<empty>         { <empty-declaration> }

        rule member-declarator-list {
            <member-declarator> [ <comma> <member-declarator> ]*
        }

        proto rule member-declarator { * }

        rule member-declarator:sym<virt> {
            <declarator>
            <virtual-specifier-seq>? 
            <pure-specifier>?
        }

        rule member-declarator:sym<brace-or-eq> {
            <declarator>
            <brace-or-equal-initializer>?
        }

        rule member-declarator:sym<ident> {
            <identifier>?
            <attribute-specifier-seq>?
            <colon>
            <constant-expression>
        }
    }
}
