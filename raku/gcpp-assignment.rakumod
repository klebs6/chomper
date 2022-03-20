
# rule assignment-expression:sym<throw> { <throw-expression> }
our class AssignmentExpression::Throw 
does IAssignmentExpression {

    has ThrowExpression $.throw-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule assignment-expression:sym<conditional> { 
#   <conditional-expression> 
# }
our class AssignmentExpression::Conditional 
does IAssignmentExpression {

    has IConditionalExpression $.conditional-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<assign> { <.assign> }
our class AssignmentOperator::Assign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<star-assign> { <.star-assign> }
our class AssignmentOperator::StarAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<div-assign> { <.div-assign> }
our class AssignmentOperator::DivAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<mod-assign> { <.mod-assign> }
our class AssignmentOperator::ModAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<plus-assign> { <.plus-assign> }
our class AssignmentOperator::PlusAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<minus-assign> { <.minus-assign> }
our class AssignmentOperator::MinusAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<rshift-assign> { <.right-shift-assign> }
our class AssignmentOperator::RshiftAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<lshift-assign> { <.left-shift-assign> }
our class AssignmentOperator::LshiftAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<and-assign> { <.and-assign> }
our class AssignmentOperator::AndAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<xor-assign> { <.xor-assign> }
our class AssignmentOperator::XorAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# token assignment-operator:sym<or-assign> { <.or-assign> }
our class AssignmentOperator::OrAssign 
does IAssignmentOperator {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
