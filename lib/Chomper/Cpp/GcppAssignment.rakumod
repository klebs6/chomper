unit module Chomper::Cpp::GcppAssignment;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppException;

# rule assignment-expression:sym<throw> { <throw-expression> }
our class AssignmentExpression::Throw 
does IAssignmentExpression {

    has ThrowExpression $.throw-expression is required;
    has $.text;

    method gist(:$treemark=False) {
        $.throw-expression.gist(:$treemark)
    }
}

# rule assignment-expression:sym<basic> { 
#   <logical-or-expression> 
#   <assignment-operator> 
#   <initializer-clause> 
# }
our class AssignmentExpression::Basic 
does IAssignmentExpression {

    has ILogicalOrExpression $.logical-or-expression is required;
    has IAssignmentOperator  $.assignment-operator   is required;
    has IInitializerClause   $.initializer-clause    is required;

    has $.text;

    method gist(:$treemark=False) {
        $.logical-or-expression.gist(:$treemark) 
        ~ " " 
        ~ $.assignment-operator.gist(:$treemark) 
        ~ " " 
        ~ $.initializer-clause.gist(:$treemark)
    }
}

# rule assignment-expression:sym<conditional> { 
#   <conditional-expression> 
# }
our class AssignmentExpression::Conditional 
does IAssignmentExpression {

    has IConditionalExpression $.conditional-expression is required;

    has $.text;

    method gist(:$treemark=False) {
        $.conditional-expression.gist(:$treemark)
    }
}

# token assignment-operator:sym<assign> { <.assign> }
our class AssignmentOperator::Assign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "="
    }
}

# token assignment-operator:sym<star-assign> { <.star-assign> }
our class AssignmentOperator::StarAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "*="
    }
}

# token assignment-operator:sym<div-assign> { <.div-assign> }
our class AssignmentOperator::DivAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "/="
    }
}

# token assignment-operator:sym<mod-assign> { <.mod-assign> }
our class AssignmentOperator::ModAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "%="
    }
}

# token assignment-operator:sym<plus-assign> { <.plus-assign> }
our class AssignmentOperator::PlusAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "+="
    }
}

# token assignment-operator:sym<minus-assign> { <.minus-assign> }
our class AssignmentOperator::MinusAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "-="
    }
}

# token assignment-operator:sym<rshift-assign> { <.right-shift-assign> }
our class AssignmentOperator::RshiftAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        ">>="
    }
}

# token assignment-operator:sym<lshift-assign> { <.left-shift-assign> }
our class AssignmentOperator::LshiftAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "<<="
    }
}

# token assignment-operator:sym<and-assign> { <.and-assign> }
our class AssignmentOperator::AndAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "&="
    }
}

# token assignment-operator:sym<xor-assign> { <.xor-assign> }
our class AssignmentOperator::XorAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "^="
    }
}

# token assignment-operator:sym<or-assign> { <.or-assign> }
our class AssignmentOperator::OrAssign 
does IAssignmentOperator {

    has $.text;

    method gist(:$treemark=False) {
        "|="
    }
}

our role AssignmentExpression::Actions {

    # rule assignment-expression:sym<throw> { <throw-expression> }
    method assignment-expression:sym<throw>($/) {
        make AssignmentExpression::Throw.new(
            throw-expression => $<throw-expression>.made,
            text             => ~$/,
        )
    }

    # rule assignment-expression:sym<basic> { <logical-or-expression> <assignment-operator> <initializer-clause> }
    method assignment-expression:sym<basic>($/) {
        make AssignmentExpression::Basic.new(
            logical-or-expression => $<logical-or-expression>.made,
            assignment-operator   => $<assignment-operator>.made,
            initializer-clause    => $<initializer-clause>.made,
            text                  => ~$/,
        )
    }

    # rule assignment-expression:sym<conditional> { <conditional-expression> }
    method assignment-expression:sym<conditional>($/) {

        my $res = $<conditional-expression>.made;

        if $res.elems eq 1 {
            make $res[0]
        } else {
            make $res
        }
    }

    # token assignment-operator:sym<assign> { <.assign> }
    method assignment-operator:sym<assign>($/) {
        make AssignmentOperator::Assign.new
    }

    # token assignment-operator:sym<star-assign> { <.star-assign> }
    method assignment-operator:sym<star-assign>($/) {
        make AssignmentOperator::StarAssign.new
    }

    # token assignment-operator:sym<div-assign> { <.div-assign> }
    method assignment-operator:sym<div-assign>($/) {
        make AssignmentOperator::DivAssign.new
    }

    # token assignment-operator:sym<mod-assign> { <.mod-assign> }
    method assignment-operator:sym<mod-assign>($/) {
        make AssignmentOperator::ModAssign.new
    }

    # token assignment-operator:sym<plus-assign> { <.plus-assign> }
    method assignment-operator:sym<plus-assign>($/) {
        make AssignmentOperator::PlusAssign.new
    }

    # token assignment-operator:sym<minus-assign> { <.minus-assign> }
    method assignment-operator:sym<minus-assign>($/) {
        make AssignmentOperator::MinusAssign.new
    }

    # token assignment-operator:sym<rshift-assign> { <.right-shift-assign> }
    method assignment-operator:sym<rshift-assign>($/) {
        make AssignmentOperator::RshiftAssign.new
    }

    # token assignment-operator:sym<lshift-assign> { <.left-shift-assign> }
    method assignment-operator:sym<lshift-assign>($/) {
        make AssignmentOperator::LshiftAssign.new
    }

    # token assignment-operator:sym<and-assign> { <.and-assign> }
    method assignment-operator:sym<and-assign>($/) {
        make AssignmentOperator::AndAssign.new
    }

    # token assignment-operator:sym<xor-assign> { <.xor-assign> }
    method assignment-operator:sym<xor-assign>($/) {
        make AssignmentOperator::XorAssign.new
    }

    # token assignment-operator:sym<or-assign> { <.or-assign> }
    method assignment-operator:sym<or-assign>($/) {
        make AssignmentOperator::OrAssign.new
    }
}

our role AssignmentExpression::Rules {

    proto rule assignment-expression { * }

    rule assignment-expression:sym<throw> {  
        <throw-expression>
    }

    rule assignment-expression:sym<basic> {  
        <logical-or-expression> <assignment-operator> <initializer-clause>
    }

    rule assignment-expression:sym<conditional> {  
        <conditional-expression>
    }

    proto token assignment-operator { * }
    token assignment-operator:sym<assign>        { <assign>           } 
    token assignment-operator:sym<star-assign>   { <star-assign>       } 
    token assignment-operator:sym<div-assign>    { <div-assign>        } 
    token assignment-operator:sym<mod-assign>    { <mod-assign>        } 
    token assignment-operator:sym<plus-assign>   { <plus-assign>       } 
    token assignment-operator:sym<minus-assign>  { <minus-assign>      } 
    token assignment-operator:sym<rshift-assign> { <right-shift-assign> } 
    token assignment-operator:sym<lshift-assign> { <left-shift-assign>  } 
    token assignment-operator:sym<and-assign>    { <and-assign>        } 
    token assignment-operator:sym<xor-assign>    { <xor-assign>        } 
    token assignment-operator:sym<or-assign>     { <or-assign>         } 
}