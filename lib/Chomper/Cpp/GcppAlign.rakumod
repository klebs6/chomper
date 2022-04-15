unit module Chomper::Cpp::GcppAlign;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;

our role IAlignmentSpecifier is export {  }

# rule alignmentspecifierbody:sym<type-id> { <the-type-id> }
class Alignmentspecifierbody::TypeId 
does IAlignmentspecifierbody is export {

    has ITheTypeId $.the-type-id is required;

    method gist(:$treemark=False) {
        $.the-type-id.gist(:$treemark)
    }
}

# rule alignmentspecifierbody:sym<const-expr> { <constant-expression> }
class Alignmentspecifierbody::ConstExpr 
does IAlignmentspecifierbody is export {

    has IConstantExpression $.constant-expression is required;

    method gist(:$treemark=False) {
        $.constant-expression.gist(:$treemark)
    }
}

# rule alignmentspecifier { 
#   <alignas> 
#   <.left-paren> 
#   <alignmentspecifierbody> 
#   <ellipsis>? 
#   <.right-paren> 
# }
class Alignmentspecifier 
does IAttributeSpecifier is export {

    has IAlignmentspecifierbody $.alignmentspecifierbody is required;
    has Bool                    $.has-ellipsis is required;

    method gist(:$treemark=False) {

        my $builder = "alignas(" ~ $.alignmentspecifierbody.gist(:$treemark);

        if $.has-ellipsis {
            $builder ~= " ...";
        }

        $builder ~ ")"
    }
}

package AlignGrammar is export {

    our role Actions {

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
                text                   => ~$/,
            )
        }
    }

    our role Rules {

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
}
