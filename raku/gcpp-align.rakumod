
# rule alignmentspecifierbody:sym<type-id> { <the-type-id> }
our class Alignmentspecifierbody::TypeId 
does IAlignmentspecifierbody {

    has ITheTypeId $.the-type-id is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule alignmentspecifierbody:sym<const-expr> { <constant-expression> }
our class Alignmentspecifierbody::ConstExpr 
does IAlignmentspecifierbody {

    has IConstantExpression $.constant-expression is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
