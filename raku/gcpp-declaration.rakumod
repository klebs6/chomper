use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;
use gcpp-attr;
use gcpp-str;

our role IDeclarationseq { }

# rule declarationseq { 
#   <declaration>+ 
# }
our class Declarationseq { 
    has IDeclaration @.declarations is required;

    has $.text;

    method gist(:$treemark=False) {
        @.declarations>>.gist(:$treemark).join(" ")
    }
}

# rule alias-declaration { 
#   <.using> 
#   <identifier> 
#   <attribute-specifier-seq>? 
#   <.assign> 
#   <the-type-id> 
#   <.semi> 
# } #---------------------------
our class AliasDeclaration { 
    has IComment               $.comment;
    has Identifier             $.identifier is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ITheTypeId             $.the-type-id is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        $builder ~= "using " ~ $.identifier.gist(:$treemark) ~ " ";

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist(:$treemark) ~ " ";
        }

        $builder ~ " = " ~ $.the-type-id.gist(:$treemark) ~ ";"
    }
}

# rule simple-declaration:sym<basic> { 
#   <decl-specifier-seq>? 
#   <init-declarator-list>? 
#   <.semi> 
# }
our class SimpleDeclaration::Basic 
does IDeclarationStatement 
does ISimpleDeclaration {

    has IComment           $.comment;
    has IDeclSpecifierSeq  $.decl-specifier-seq;
    has IInitDeclarator    @.init-declarator-list;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        if $.decl-specifier-seq {
            $builder ~= $.decl-specifier-seq.gist(:$treemark) ~ " ";
        }

        my $declarator-list = @.init-declarator-list>>.gist(:$treemark).join(", ");

        if $declarator-list {
            $builder ~= $declarator-list.chomp;
        }

        $builder ~ ";"
    }
}

# rule simple-declaration:sym<init-list> { 
#   <attribute-specifier-seq> 
#   <decl-specifier-seq>? 
#   <init-declarator-list> 
#   <.semi> 
# }
our class SimpleDeclaration::InitList 
does ISimpleDeclaration {

    has IComment            $.comment;
    has IAttributeSpecifier @.attribute-specifiers is required;
    has IDeclSpecifierSeq   $.decl-specifier-seq;
    has IInitDeclarator     @.init-declarator-list;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        for @.attribute-specifiers {
            $builder ~= $_.gist(:$treemark) ~ " ";
        }

        if $.decl-specifier-seq {
            $builder ~= $.decl-specifier-seq.gist(:$treemark) ~ " ";
        }

        for @.init-declarator-list {
            $builder ~= $_.gist(:$treemark) ~ " ";
        }

        $builder ~ ";"
    }
}

# rule static-assert-declaration { 
#   <.static_assert> 
#   <.left-paren> 
#   <constant-expression> 
#   <.comma> 
#   <string-literal> 
#   <.right-paren> 
#   <.semi> 
# }
our class StaticAssertDeclaration { 
    has IComment            $.comment;
    has IConstantExpression $.constant-expression is required;
    has StringLiteral       $.string-literal is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        $builder ~ "static_assert(" 
        ~ $.constant-expression.gist(:$treemark) 
        ~ ", " 
        ~ $.string-literal.gist(:$treemark)
        ~ ");"
    }
}

# rule empty-declaration { <.semi> }
our class EmptyDeclaration { 
    has IComment           $.comment;

    has $.text;

    method gist(:$treemark=False) {
        ";"
    }
}

# rule attribute-declaration { 
#   <attribute-specifier-seq> 
#   <.semi> 
# }
our class AttributeDeclaration { 
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        $builder ~= $.attribute-specifier-seq.gist(:$treemark);

        $builder ~ ";"
    }
}

our role Declaration::Actions {

    # rule declarationseq { <declaration>+ } 
    method declarationseq($/) {

        my @decls = $<declaration>>>.made;

        if @decls.elems gt 1 {

            make Declarationseq.new(
                declarations => @decls,
            )

        } else {

            make @decls[0]
        }
    }

    # rule declaration:sym<block-declaration> { <block-declaration> }
    method declaration:sym<block-declaration>($/) {
        make $<block-declaration>.made
    }

    # rule declaration:sym<function-definition> { <function-definition> }
    method declaration:sym<function-definition>($/) {
        make $<function-definition>.made
    }

    # rule declaration:sym<template-declaration> { <template-declaration> }
    method declaration:sym<template-declaration>($/) {
        make $<template-declaration>.made
    }

    # rule declaration:sym<explicit-instantiation> { <explicit-instantiation> }
    method declaration:sym<explicit-instantiation>($/) {
        make $<explicit-instantiation>.made
    }

    # rule declaration:sym<explicit-specialization> { <explicit-specialization> }
    method declaration:sym<explicit-specialization>($/) {
        make $<explicit-specialization>.made
    }

    # rule declaration:sym<linkage-specification> { <linkage-specification> }
    method declaration:sym<linkage-specification>($/) {
        make $<linkage-specification>.made
    }

    # rule declaration:sym<namespace-definition> { <namespace-definition> }
    method declaration:sym<namespace-definition>($/) {
        make $<namespace-definition>.made
    }

    # rule declaration:sym<empty-declaration> { <empty-declaration> }
    method declaration:sym<empty-declaration>($/) {
        make $<empty-declaration>.made
    }

    # rule declaration:sym<attribute-declaration> { <attribute-declaration> }
    method declaration:sym<attribute-declaration>($/) {
        make $<attribute-declaration>.made
    }

    # rule block-declaration:sym<simple> { <simple-declaration> }
    method block-declaration:sym<simple>($/) {
        make $<simple-declaration>.made
    }

    # rule block-declaration:sym<asm> { <asm-definition> }
    method block-declaration:sym<asm>($/) {
        make $<asm-definition>.made
    }

    # rule block-declaration:sym<namespace-alias> { <namespace-alias-definition> }
    method block-declaration:sym<namespace-alias>($/) {
        make $<namespace-alias-definition>.made
    }

    # rule block-declaration:sym<using-decl> { <using-declaration> }
    method block-declaration:sym<using-decl>($/) {
        make $<using-declaration>.made
    }

    # rule block-declaration:sym<using-directive> { <using-directive> }
    method block-declaration:sym<using-directive>($/) {
        make $<using-directive>.made
    }

    # rule block-declaration:sym<static-assert> { <static-assert-declaration> }
    method block-declaration:sym<static-assert>($/) {
        make $<static-assert-declaration>.made
    }

    # rule block-declaration:sym<alias> { <alias-declaration> }
    method block-declaration:sym<alias>($/) {
        make $<alias-declaration>.made
    }

    # rule block-declaration:sym<opaque-enum-decl> { <opaque-enum-declaration> }
    method block-declaration:sym<opaque-enum-decl>($/) {
        make $<opaque-enum-declaration>.made
    }

    # rule alias-declaration { <.using> <identifier> <attribute-specifier-seq>? <.assign> <the-type-id> <.semi> } 
    method alias-declaration($/) {
        make AliasDeclaration.new(
            comment                 => $<semi>.made,
            identifier              => $<identifier>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            the-type-id             => $<the-type-id>.made,
            text                    => ~$/,
        )
    }

    # rule simple-declaration:sym<basic> { <decl-specifier-seq>? <init-declarator-list>? <.semi> }
    method simple-declaration:sym<basic>($/) {
        make SimpleDeclaration::Basic.new(
            comment              => $<semi>.made,
            decl-specifier-seq   => $<decl-specifier-seq>.made,
            init-declarator-list => $<init-declarator-list>.made,
            text                 => ~$/,
        )
    }

    # rule simple-declaration:sym<init-list> { <attribute-specifier-seq> <decl-specifier-seq>? <init-declarator-list> <.semi> }
    method simple-declaration:sym<init-list>($/) {
        make SimpleDeclaration::InitList.new(
            comment              => $<semi>.made,
            attribute-specifiers => $<attribute-specifier-seq>.made,
            decl-specifier-seq   => $<decl-specifier-seq>.made,
            init-declarator-list => $<init-declarator-list>.made,
            text                 => ~$/,
        )
    }

    # rule static-assert-declaration { 
    #   <static_assert> 
    #   <.left-paren> 
    #   <constant-expression> 
    #   <.comma> 
    #   <string-literal> 
    #   <.right-paren> 
    #   <.semi> 
    # }
    method static-assert-declaration($/) {
        make StaticAssertDeclaration.new(
            constant-expression => $<constant-expression>.made,
            string-literal      => $<string-literal>.made,
            text                => ~$/,
        )
    }

    # rule empty-declaration { <.semi> }
    method empty-declaration($/) {

        my $comment = $<semi>.made;

        if $comment {
            make EmptyDeclaration.new(
                comment => $comment,
                text    => ~$/,
            )
        }
    }

    # rule attribute-declaration { <attribute-specifier-seq> <.semi> } 
    method attribute-declaration($/) {

        my $comment = $<semi>.made;
        my $body    = $<attribute-specifier-seq>.made;

        if $comment {
            make AttributeDeclaration.new(
                comment                 => $comment,
                attribute-specifier-seq => $body,
                text                    => ~$/,
            )
        } else {
            make $body
        }
    }
}

our role Declaration::Rules {

    rule declarationseq { <declaration>+ }

    #-------------------------------
    proto rule declaration { * }
    rule declaration:sym<block-declaration>       { <block-declaration>         } 
    rule declaration:sym<function-definition>     { <function-definition>       } 
    rule declaration:sym<template-declaration>    { <template-declaration>      } 
    rule declaration:sym<explicit-instantiation>  { <explicit-instantiation>    } 
    rule declaration:sym<explicit-specialization> { <explicit-specialization>   } 
    rule declaration:sym<linkage-specification>   { <linkage-specification>     } 
    rule declaration:sym<namespace-definition>    { <namespace-definition>      } 
    rule declaration:sym<empty-declaration>       { <empty-declaration>         } 
    rule declaration:sym<attribute-declaration>   { <attribute-declaration>     } 

    proto rule block-declaration { * }
    rule block-declaration:sym<simple>            { <simple-declaration>        } 
    rule block-declaration:sym<asm>               { <asm-definition>            } 
    rule block-declaration:sym<namespace-alias>   { <namespace-alias-definition> } 
    rule block-declaration:sym<using-decl>        { <using-declaration>         } 
    rule block-declaration:sym<using-directive>   { <using-directive>           } 
    rule block-declaration:sym<static-assert>     { <static-assert-declaration>  } 
    rule block-declaration:sym<alias>             { <alias-declaration>         } 
    rule block-declaration:sym<opaque-enum-decl>  { <opaque-enum-declaration>    } 

    rule alias-declaration {
        <using>
        <identifier>
        <attribute-specifier-seq>?
        <assign>
        <the-type-id>
        <semi>
    }

    #---------------------------
    proto rule simple-declaration { * }

    rule simple-declaration:sym<basic> { 
        <decl-specifier-seq>? 
        <init-declarator-list>? 
        <semi> 
    }

    rule simple-declaration:sym<init-list> { 
        <attribute-specifier-seq> 
        <decl-specifier-seq>? 
        <init-declarator-list> 
        <semi> 
    }

    rule static-assert-declaration {
        <static_assert>
        <left-paren>
        <constant-expression>
        <comma>
        <string-literal>
        <right-paren>
        <semi>
    }

    rule empty-declaration {
        <semi>
    }

    rule attribute-declaration {
        <attribute-specifier-seq> <semi>
    }

    rule declaration-statement { <block-declaration> }
}
