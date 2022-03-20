
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

