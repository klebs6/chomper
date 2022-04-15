unit module Chomper::Cpp::GcppPtrMember;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

our class PointerMemberExpression     { ... }
our class PointerMemberExpressionTail { ... }

# rule pointer-member-operator:sym<dot> { 
#   <dot-star> 
# }
our class PointerMemberOperator::Dot does IPointerMemberOperator {

    has $.text;

    method gist(:$treemark=False) {
        ".*"
    }
}

# rule pointer-member-operator:sym<arrow> { 
#   <arrow-star> 
# }
our class PointerMemberOperator::Arrow does IPointerMemberOperator { 

    has $.text;

    method gist(:$treemark=False) {
        "->*"
    }
}

# rule pointer-member-expression { 
#   <cast-expression> 
#   <pointer-member-expression-tail>* 
# }
our class PointerMemberExpression does IPointerMemberExpression { 
    has ICastExpression             $.cast-expression is required;
    has PointerMemberExpressionTail @.pointer-member-expression-tail;

    has $.text;

    method gist(:$treemark=False) {
        $.cast-expression.gist(:$treemark) 
        ~ @.pointer-member-expression-tail>>.gist(:$treemark).join(" ")
    }
}

# rule pointer-member-expression-tail { 
#   <pointer-member-operator> 
#   <cast-expression> 
# }
our class PointerMemberExpressionTail { 
    has IPointerMemberOperator $.pointer-member-operator is required;
    has ICastExpression        $.cast-expression is required;

    has $.text;

    method gist(:$treemark=False) {
        $.pointer-member-operator.gist(:$treemark) ~ " " ~ $.cast-expression.gist(:$treemark)
    }
}

our role PointerMember::Actions {

    # rule pointer-member-operator:sym<dot> { <dot-star> }
    method pointer-member-operator:sym<dot>($/) {
        make PointerMemberOperator::Dot.new
    }

    # rule pointer-member-operator:sym<arrow> { <arrow-star> }
    method pointer-member-operator:sym<arrow>($/) {
        make PointerMemberOperator::Arrow.new
    }

    # rule pointer-member-expression { 
    #   <cast-expression> 
    #   <pointer-member-expression-tail>* 
    # }
    method pointer-member-expression($/) {

        my $base = $<cast-expression>.made;
        my @tail = $<pointer-member-expression-tail>>>.made;

        if @tail.elems gt 0 {
            make PointerMemberExpression.new(
                cast-expression                => $base,
                pointer-member-expression-tail => @tail,
                text                           => ~$/,
            )

        } else {
            make $base

        }
    }

    # rule pointer-member-expression-tail { 
    #   <pointer-member-operator> 
    #   <cast-expression> 
    # }
    method pointer-member-expression-tail($/) {
        make PointerMemberExpressionTail.new(
            pointer-member-operator => $<pointer-member-operator>.made,
            cast-expression         => $<cast-expression>.made,
            text                    => ~$/,
        )
    }
}

our role PointerMember::Rules {

    proto rule pointer-member-operator { * }
    rule pointer-member-operator:sym<dot>   { <dot-star> }
    rule pointer-member-operator:sym<arrow> { <arrow-star> }

    rule pointer-member-expression {
        <cast-expression>
        <pointer-member-expression-tail>*
    }

    rule pointer-member-expression-tail {
        <pointer-member-operator>
        <cast-expression>
    }
}