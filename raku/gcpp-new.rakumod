use Data::Dump::Tree;

use gcpp-roles;
use gcpp-expression;
use gcpp-attr;

our class NewPlacement               { ... }
our class NewTypeId                  { ... }
our class NoPointerNewDeclarator     { ... }
our class NoPointerNewDeclaratorTail { ... }
our class NewDeclarator              { ... }

# rule new-expression:sym<new-type-id> { 
#   <doublecolon>? 
#   <new_> 
#   <new-placement>? 
#   <new-type-id> 
#   <new-initializer>? 
# }
our class NewExpression::NewTypeId does INewExpression {
    has NewPlacement   $.new-placement;
    has NewTypeId      $.new-type-id is required;
    has INewInitializer $.new-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-expression:sym<the-type-id> { 
#   <doublecolon>? 
#   <new_> 
#   <new-placement>? 
#   <.left-paren> 
#   <the-type-id> 
#   <.right-paren> 
#   <new-initializer>? 
# }
our class NewExpression::TheTypeId does INewExpression {
    has NewPlacement    $.new-placement;
    has ITheTypeId      $.the-type-id is required;
    has INewInitializer $.new-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-placement { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# }
our class NewPlacement { 
    has ExpressionList $.expression-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-type-id { 
#   <type-specifier-seq> 
#   <new-declarator>? 
# }
our class NewTypeId { 
    has ITypeSpecifierSeq $.type-specifier-seq is required;
    has NewDeclarator    $.new-declarator     is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-declarator { 
#   <pointer-operator>* 
#   <no-pointer-new-declarator>? 
# }
our class NewDeclarator { 
    has IPointerOperator @.pointer-operators;
    has NoPointerNewDeclarator $.no-pointer-new-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-new-declarator { 
#   <.left-bracket> 
#   <expression> 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
#   <no-pointer-new-declarator-tail>* 
# }
our class NoPointerNewDeclarator { 
    has IExpression                $.expression is required;
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has NoPointerNewDeclaratorTail @.no-pointer-new-declarator-tail;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule no-pointer-new-declarator-tail { 
#   <.left-bracket> 
#   <constant-expression> 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
our class NoPointerNewDeclaratorTail {
    has IConstantExpression    $.constant-expression is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule new-initializer:sym<expr-list> { 
#   <.left-paren> 
#   <expression-list>? 
#   <.right-paren> 
# }
our class NewInitializer::ExprList does INewInitializer {
    has ExpressionList $.expression-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule new-initializer:sym<braced> { 
#   <braced-init-list> 
# }
our class NewInitializer::Braced does INewInitializer {
    has BracedInitList $.braced-init-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

our role NewExpression::Actions {

    # rule new-expression:sym<new-type-id> { 
    #   <doublecolon>? 
    #   <new_> 
    #   <new-placement>? 
    #   <new-type-id> 
    #   <new-initializer>? 
    # }
    method new-expression:sym<new-type-id>($/) {
        make NewExpression::NewTypeId.new(
            new-placement   => $<new-placement>.made,
            new-type-id     => $<new-type-id>.made,
            new-initializer => $<new-initializer>.made,
        )
    }

    # rule new-expression:sym<the-type-id> { 
    #   <doublecolon>? 
    #   <new_> 
    #   <new-placement>? 
    #   <.left-paren> 
    #   <the-type-id> 
    #   <.right-paren> 
    #   <new-initializer>? 
    # }
    method new-expression:sym<the-type-id>($/) {
        make NewExpression::TheTypeId.new(
            new-placement   => $<new-placement>.made,
            the-type-id     => $<the-type-id>.made,
            new-initializer => $<new-initializer>.made,
        )
    }

    # rule new-placement { <.left-paren> <expression-list> <.right-paren> }
    method new-placement($/) {
        make $<expression-list>.made
    }

    # rule new-type-id { <type-specifier-seq> <new-declarator>? }
    method new-type-id($/) {

        my $base           = $<type-specifier-seq>.made;
        my $new-declarator = $<new-declarator>.made;

        if $new-declarator {
            make NewTypeId.new(
                type-specifier-seq => $base,
                new-declarator     => $new-declarator,
            )
        } else {
            make $base
        }
    }

    # rule new-declarator { 
    #   <pointer-operator>* 
    #   <no-pointer-new-declarator>? 
    # }
    method new-declarator($/) {
        my $base = $<no-pointer-new-declarator>.made;
        my @ops  = $<pointer-operator>>>.made;

        if @ops.elems gt 0 {
            make NewDeclarator.new(
                pointer-operators         => @ops,
                no-pointer-new-declarator => $base,
            )
        } else {
            make $base
        }
    }

    # rule no-pointer-new-declarator { <.left-bracket> <expression> <.right-bracket> <attribute-specifier-seq>? <no-pointer-new-declarator-tail>* }
    method no-pointer-new-declarator($/) {
        make NoPointerNewDeclarator.new(
            expression                     => $<expression>.made,
            attribute-specifier-seq        => $<attribute-specifier-seq>.made,
            no-pointer-new-declarator-tail => $<no-pointer-new-declarator-tail>>>.made,
        )
    }

    # rule no-pointer-new-declarator-tail { <.left-bracket> <constant-expression> <.right-bracket> <attribute-specifier-seq>? } 
    method no-pointer-new-declarator-tail($/) {
        make NoPointerNewDeclaratorTail.new(
            constant-expression     => $<constant-expression>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
        )
    }

    # rule new-initializer:sym<expr-list> { <.left-paren> <expression-list>? <.right-paren> }
    method new-initializer:sym<expr-list>($/) {
        make $<expression-list>.made;
    }

    # rule new-initializer:sym<braced> { <braced-init-list> } 
    method new-initializer:sym<braced>($/) {
        make $<braced-init-list>.made
    }
}

our role NewExpression::Rules {

    proto rule new-expression { * }

    rule new-expression:sym<new-type-id> {
        <doublecolon>?
        <new_>
        <new-placement>?
        <new-type-id>
        <new-initializer>?
    }

    rule new-expression:sym<the-type-id> {
        <doublecolon>?
        <new_>
        <new-placement>?
        <left-paren> 
        <the-type-id> 
        <right-paren>
        <new-initializer>?
    }

    rule new-placement {
        <left-paren>
        <expression-list>
        <right-paren>
    }

    rule new-type-id {
        <type-specifier-seq> <new-declarator>?
    }

    rule new-declarator {
        <pointer-operator>* 
        <no-pointer-new-declarator>?
    }

    proto rule new-initializer { * }
    rule new-initializer:sym<expr-list> { <left-paren> <expression-list>?  <right-paren> }
    rule new-initializer:sym<braced>    { <braced-init-list> }
}
