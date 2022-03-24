use Data::Dump::Tree;

use gcpp-roles;
use gcpp-attr;
use gcpp-expression;

# rule condition:sym<expr> { 
#   <expression> 
# }
our class Condition::Expr does ICondition {
    has IExpression $.expression is required;

    has $.text;

    method gist{
        $.expression.gist
    }
}

# rule condition-decl-tail:sym<assign-init> { 
#   <assign> 
#   <initializer-clause> 
# }
our class ConditionDeclTail::AssignInit does IConditionDeclTail {
    has IInitializerClause $.initializer-clause is required;

    has $.text;

    method gist{
        "= " ~ $.initializer-clause.gist
    }
}

# rule condition-decl-tail:sym<braced-init> { 
#   <braced-init-list> 
# }
our class ConditionDeclTail::BracedInit does IConditionDeclTail {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        $.braced-init-list.gist
    }
}

# rule condition:sym<decl> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq> 
#   <declarator> 
#   <condition-decl-tail> 
# }
our class Condition::Decl does ICondition {
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq  is required;
    has IDeclarator            $.declarator          is required;
    has IConditionDeclTail    $.condition-decl-tail is required;

    has $.text;

    method gist{

        my $builder = "";

        if $.attribute-specifier-seq {
            $builder ~= $.attribute-specifier-seq.gist ~ " ";
        }

        $builder ~= $.decl-specifier-seq.gist ~ " ";
        $builder ~= $.declarator.gist ~ " ";
        $builder ~ $.condition-decl-tail.gist
    }
}

our role Condition::Actions {

    # rule condition:sym<expr> { <expression> } 
    method condition:sym<expr>($/) {
        make $<expression>.made
    }

    # rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
    method condition-decl-tail:sym<assign-init>($/) {
        make ConditionDeclTail::AssignInit.new(
            initializer-clause => $<initializer-clause>.made,
            text               => ~$/,
        )
    }

    # rule condition-decl-tail:sym<braced-init> { <braced-init-list> } 
    method condition-decl-tail:sym<braced-init>($/) {
        make $<braced-init-list>.made
    }

    # rule condition:sym<decl> { <attribute-specifier-seq>? <decl-specifier-seq> <declarator> <condition-decl-tail> } 
    method condition:sym<decl>($/) {
        make Condition::Decl.new(
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            declarator              => $<declarator>.made,
            condition-decl-tail     => $<condition-decl-tail>.made,
            text                    => ~$/,
        )
    }
}

our role Condition::Rules {

    proto rule condition { * }

    rule condition:sym<expr> {
        <expression>
    }

    #-----------------------------
    proto rule condition-decl-tail { * }
    rule condition-decl-tail:sym<assign-init> { <assign> <initializer-clause> }
    rule condition-decl-tail:sym<braced-init> { <braced-init-list> }

    #-----------------------------
    rule condition:sym<decl> {
        <attribute-specifier-seq>?
        <decl-specifier-seq> 
        <declarator>
        <condition-decl-tail>
    }
}
