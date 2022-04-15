unit module Chomper::Cpp::GcppFunction;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppTry;
use Chomper::Cpp::GcppConstructor;
use Chomper::Cpp::GcppVirtual;
use Chomper::Cpp::GcppAttr;
use Chomper::Cpp::GcppStatement;
use Chomper::Cpp::GcppTypeSpecifier;

# rule trailing-return-type { 
#   <arrow> 
#   <trailing-type-specifier-seq> 
#   <abstract-declarator>? 
# }
our class TrailingReturnType { 
    has TrailingTypeSpecifierSeq $.trailing-type-specifier-seq is required;
    has IAbstractDeclarator      $.abstract-declarator;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = '-> ' ~ $.trailing-type-specifier.gist(:$treemark);

        if $.abstract-declarator {
            $builder ~= " " ~ $.abstract-declarator.gist(:$treemark);
        }

        $builder
    }
}

# rule function-definition { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <declarator> 
#   <virtual-specifier-seq>? 
#   <function-body> 
# } #-----------------------------
our class FunctionDefinition { 
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq;
    has IDeclarator            $.declarator is required;
    has VirtualSpecifierSeq    $.virtual-specifier-seq;
    has IFunctionBody          $.function-body is required;

    has $.text;

    method gist(:$treemark=False) {
        my $builder = "";

        my $a = $.attribute-specifier-seq;
        my $d = $.decl-specifier-seq;
        my $v = $.virtual-specifier-seq;

        if $a {
            $builder ~= $a.gist(:$treemark) ~ " ";
        }

        if $d {
            $builder ~= $d.gist(:$treemark) ~ " ";
        }

        $builder ~= $.declarator.gist(:$treemark);

        if $v {
            $builder ~= $v.gist(:$treemark) ~ " ";
        }

        $builder ~ $.function-body.gist(:$treemark)
    }
}

# rule function-body:sym<compound> { 
#   <constructor-initializer>? 
#   <compound-statement> 
# }
our class FunctionBody::Compound does IFunctionBody {
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement      $.compound-statement is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        my $i = $.constructor-initializer;

        if $i {
            $builder ~= $i.gist(:$treemark) ~ " ";
        }

        $builder ~ $.compound-statement.gist(:$treemark)
    }
}

# rule function-body:sym<try> { <function-try-block> }
our class FunctionBody::Try does IFunctionBody {
    has FunctionTryBlock $.function-try-block is required;

    has $.text;

    method gist(:$treemark=False) {
        $.function-try-block.gist(:$treemark)
    }
}

# rule function-body:sym<assign-default> { 
#   <assign> 
#   <default_> 
#   <semi> 
# }
our class FunctionBody::AssignDefault does IFunctionBody { 
    has IComment $.comment;

    has $.text;

    method gist(:$treemark=False) {
        " = default;"
    }
}

# rule function-body:sym<assign-delete> { 
#   <assign> 
#   <delete> 
#   <semi> 
# }
our class FunctionBody::AssignDelete does IFunctionBody { 
    has IComment $.comment;

    has $.text;

    method gist(:$treemark=False) {
        " = delete;"
    }
}

# rule function-specifier:sym<inline> { <.inline> }
our class FunctionSpecifier::Inline does IFunctionSpecifier { 

    has $.text;

    method gist(:$treemark=False) {
        "inline"
    }
}

# rule function-specifier:sym<virtual> { <.virtual> }
our class FunctionSpecifier::Virtual does IFunctionSpecifier { 

    has $.text;

    method gist(:$treemark=False) {
        "virtual"
    }
}

# rule function-specifier:sym<explicit> { <.explicit> }
our class FunctionSpecifier::Explicit does IFunctionSpecifier { 

    has $.text;

    method gist(:$treemark=False) {
        "explicit"
    }
}

our role Function::Actions {

    # rule function-specifier:sym<inline> { <.inline> }
    method function-specifier:sym<inline>($/) {
        make FunctionSpecifier::Inline.new
    }

    # rule function-specifier:sym<virtual> { <.virtual> }
    method function-specifier:sym<virtual>($/) {
        make FunctionSpecifier::Virtual.new
    }

    # rule function-specifier:sym<explicit> { <.explicit> }
    method function-specifier:sym<explicit>($/) {
        make FunctionSpecifier::Explicit.new
    }

    # rule trailing-return-type { <arrow> <trailing-type-specifier-seq> <abstract-declarator>? } 
    method trailing-return-type($/) {
        make TrailingReturnType.new(
            trailing-type-specifier-seq => $<trailing-type-specifier-seq>.made,
            abstract-declarator         => $<abstract-declarator>.made,
            text                        => ~$/,
        )
    }

    # rule function-definition { <attribute-specifier-seq>? <decl-specifier-seq>? <declarator> <virtual-specifier-seq>? <function-body> } 
    method function-definition($/) {
        make FunctionDefinition.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
            virtual-specifier-seq   => $<virtual-specifier-seq>.made,
            function-body           => $<function-body>.made,
            text                    => ~$/,
        )
    }

    # rule function-body:sym<compound> { <constructor-initializer>? <compound-statement> }
    method function-body:sym<compound>($/) {

        my $prefix = $<constructor-initializer>.made;
        my $body   = $<compound-statement>.made;

        if $prefix {
            make FunctionBody::Compound.new(
                constructor-initializer => $prefix,
                compound-statement      => $body,
                text                    => ~$/,
            )
        } else {
            make $body
        }
    }

    # rule function-body:sym<try> { <function-try-block> }
    method function-body:sym<try>($/) {
        make $<function-try-block>.made
    }

    # rule function-body:sym<assign-default> { <assign> <default_> <semi> }
    method function-body:sym<assign-default>($/) {
        make FunctionBody::AssignDefault.new(
            comment        => $<semi>.made,
            text           => ~$/,
        )
    }

    # rule function-body:sym<assign-delete> { <assign> <delete> <semi> } 
    method function-body:sym<assign-delete>($/) {
        make FunctionBody::AssignDelete.new(
            comment        => $<semi>.made,
            text           => ~$/,
        )
    }
}

our role Function::Rules {

    rule function-definition {
        <attribute-specifier-seq>?
        <decl-specifier-seq>?
        <declarator>
        <virtual-specifier-seq>?
        <function-body>
    }

    #-----------------------------
    proto rule function-body { * }

    rule function-body:sym<compound> {
        <constructor-initializer>?  <compound-statement>
    }

    rule function-body:sym<try> {
        <function-try-block>
    }

    rule function-body:sym<assign-default> {
        <assign> <default_> <semi>
    }

    rule function-body:sym<assign-delete> {
        <assign> <delete> <semi>
    }

    rule trailing-return-type {
        <arrow>
        <trailing-type-specifier-seq>
        <abstract-declarator>?
    }

    proto rule function-specifier { * }
    rule function-specifier:sym<inline>   { <inline> }
    rule function-specifier:sym<virtual>  { <virtual> }
    rule function-specifier:sym<explicit> { <explicit> }
}