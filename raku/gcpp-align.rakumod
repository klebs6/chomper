use Data::Dump::Tree;

use gcpp-roles;

our role IAlignmentSpecifier {  }

# rule alignmentspecifierbody:sym<type-id> { <the-type-id> }
our class Alignmentspecifierbody::TypeId 
does IAlignmentspecifierbody {

    has ITheTypeId $.the-type-id is required;

    method gist{
        $.the-type-id.gist
    }
}

# rule alignmentspecifierbody:sym<const-expr> { <constant-expression> }
our class Alignmentspecifierbody::ConstExpr 
does IAlignmentspecifierbody {

    has IConstantExpression $.constant-expression is required;

    method gist{
        $.constant-expression.gist
    }
}

# rule alignmentspecifier { 
#   <alignas> 
#   <.left-paren> 
#   <alignmentspecifierbody> 
#   <ellipsis>? 
#   <.right-paren> 
# }
our class Alignmentspecifier 
does IAttributeSpecifier {

    has IAlignmentspecifierbody $.alignmentspecifierbody is required;
    has Bool                    $.has-ellipsis is required;

    method gist{

        my $builder = "alignas(" ~ $.alignmentspecifierbody.gist;

        if $.has-ellipsis {
            $builder ~= " ...";
        }

        $builder ~ ")"
    }
}

our role Align::Actions {

    # rule alignmentspecifierbody:sym<type-id> { <the-type-id> }
    method alignmentspecifierbody:sym<type-id>($/) {
        make $<the-type-id>.made
    }

    # rule alignmentspecifierbody:sym<const-expr> { <constant-expression> } 
    method alignmentspecifierbody:sym<const-expr>($/) {
        make $<constant-expression>.made
    }

    # rule alignmentspecifier { <alignas> <.left-paren> <alignmentspecifierbody> <ellipsis>? <.right-paren> }
    method alignmentspecifier($/) {
        make Alignmentspecifier.new(
            alignmentspecifierbody => $<alignmentspecifierbody>.made,
            has-ellipsis           => $<has-ellipsis>.made,
        )
    }
}

our role Align::Rules {

    proto rule alignmentspecifierbody { * }
    rule alignmentspecifierbody:sym<type-id>    { <the-type-id> }
    rule alignmentspecifierbody:sym<const-expr> { <constant-expression> }

    #--------------------
    rule alignmentspecifier {
        <alignas>
        <left-paren>
        <alignmentspecifierbody>
        <ellipsis>?
        <right-paren>
    }
}
