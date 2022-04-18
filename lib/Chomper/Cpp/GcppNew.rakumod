unit module Chomper::Cpp::GcppNew;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppExpression;
use Chomper::Cpp::GcppAttr;

our class NewPlacement               { ... }
our class NewTypeId                  { ... }
our class NoPointerNewDeclarator     { ... }
our class NoPointerNewDeclaratorTail { ... }
our class NewDeclarator              { ... }

package NewExpression is export {

    # rule new-expression:sym<new-type-id> { 
    #   <doublecolon>? 
    #   <new_> 
    #   <new-placement>? 
    #   <new-type-id> 
    #   <new-initializer>? 
    # }
    our class NewTypeId 
    does INewExpression {
        has NewPlacement    $.new-placement;
        has INewTypeId      $.new-type-id is required;
        has INewInitializer $.new-initializer;

        has $.text;

        method name {
            'NewExpression::NewTypeId'
        }

        method gist(:$treemark=False) {

            my $builder = "new ";

            if $.new-placement {
                $builder ~= $.new-placement.gist(:$treemark) ~ " ";
            }

            $builder ~= $.new-type-id.gist(:$treemark);

            if $.new-initializer {
                $builder ~= " (" ~ $.new-initializer.gist(:$treemark) ~ ")";
            }

            $builder
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
    our class TheTypeId does INewExpression {
        has NewPlacement    $.new-placement;
        has ITheTypeId      $.the-type-id is required;
        has INewInitializer $.new-initializer;

        has $.text;

        method name {
            'NewExpression::TheTypeId'
        }

        method gist(:$treemark=False) {

            my $builder = "new ";

            if $.new-placement {
                $builder ~= $.new-placement.gist(:$treemark);
            }

            $builder ~= "(" ~ $.the-type-id.gist(:$treemark) ~ ")";

            if $.new-initializer {
                $builder ~= " " ~ $.new-initializer.gist(:$treemark);
            }

            $builder
        }
    }
}

# rule new-placement { 
#   <.left-paren> 
#   <expression-list> 
#   <.right-paren> 
# }
class NewPlacement is export { 
    has ExpressionList $.expression-list is required;

    has $.text;

    method name {
        'NewPlacement'
    }

    method gist(:$treemark=False) {
        "(" ~ $.expression-list.gist(:$treemark) ~ ")"
    }
}

# rule new-type-id { 
#   <type-specifier-seq> 
#   <new-declarator>? 
# }
class NewTypeId does INewTypeId is export { 
    has ITypeSpecifierSeq $.type-specifier-seq is required;
    has NewDeclarator    $.new-declarator     is required;

    has $.text;

    method name {
        'NewTypeId'
    }

    method gist(:$treemark=False) {
        my $builder = $.type-specifier-seq.gist(:$treemark);

        if $.new-declarator {
            $builder ~= " " ~ $.new-declarator.gist(:$treemark);
        }

        $builder
    }
}

# rule new-declarator { 
#   <pointer-operator>* 
#   <no-pointer-new-declarator>? 
# }
class NewDeclarator is export { 
    has IPointerOperator @.pointer-operators;
    has NoPointerNewDeclarator $.no-pointer-new-declarator;

    has $.text;

    method name {
        'NewDeclarator'
    }

    method gist(:$treemark=False) {
        my $builder = @.pointer-operators>>.gist(:$treemark).join(" ");

        if $.no-pointer-new-declarator {
            $builder ~= " " ~ $.no-pointer-new-declarator.gist(:$treemark);
        }

        $builder
    }
}

# rule no-pointer-new-declarator { 
#   <.left-bracket> 
#   <expression> 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
#   <no-pointer-new-declarator-tail>* 
# }
class NoPointerNewDeclarator is export { 
    has IExpression                $.expression is required;
    has IAttributeSpecifierSeq     $.attribute-specifier-seq;
    has NoPointerNewDeclaratorTail @.no-pointer-new-declarator-tail;

    has $.text;

    method name {
        'NoPointerNewDeclarator'
    }

    method gist(:$treemark=False) {

        my $builder = "[" ~ $.expression.gist(:$treemark) ~ "]";

        if $.attribute-specifier-seq  {
            $builder ~= " " ~ $.attribute-specifier-seq.gist(:$treemark);
        }

        $builder ~ @.no-pointer-new-declarator-tail>>.gist(:$treemark).join(" ")
    }
}

# rule no-pointer-new-declarator-tail { 
#   <.left-bracket> 
#   <constant-expression> 
#   <.right-bracket> 
#   <attribute-specifier-seq>? 
# }
class NoPointerNewDeclaratorTail is export {
    has IConstantExpression    $.constant-expression is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;

    has $.text;

    method name {
        'NoPointerNewDeclaratorTail'
    }

    method gist(:$treemark=False) {
        my $builder = "[" ~ $.constant-expression.gist(:$treemark) ~ "]";

        if $.attribute-specifier-seq {
            $builder ~= " " ~ $.attribute-specifier-seq.gist(:$treemark);
        }

        $builder
    }
}

package NewInitializer is export {

    # rule new-initializer:sym<expr-list> { 
    #   <.left-paren> 
    #   <expression-list>? 
    #   <.right-paren> 
    # }
    our class ExprList does INewInitializer {
        has ExpressionList $.expression-list;

        has $.text;

        method name {
            'NewInitializer::ExprList'
        }

        method gist(:$treemark=False) {

            my $builder = "(";

            if $.expression-list {
                $builder ~= $.expression-list.gist(:$treemark);
            }

            $builder ~= ")";

            $builder
        }
    }

    # rule new-initializer:sym<braced> { 
    #   <braced-init-list> 
    # }
    our class Braced does INewInitializer {
        has BracedInitList $.braced-init-list is required;

        has $.text;

        method name {
            'NewInitializer::Braced'
        }

        method gist(:$treemark=False) {
            $.braced-init-list.gist(:$treemark)
        }
    }
}

package NewExpressionGrammar is export {

    our role Actions {

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
                text            => ~$/,
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
                text            => ~$/,
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
                    text               => ~$/,
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
                    text                      => ~$/,
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
                text                           => ~$/,
            )
        }

        # rule no-pointer-new-declarator-tail { <.left-bracket> <constant-expression> <.right-bracket> <attribute-specifier-seq>? } 
        method no-pointer-new-declarator-tail($/) {
            make NoPointerNewDeclaratorTail.new(
                constant-expression     => $<constant-expression>.made,
                attribute-specifier-seq => $<attribute-specifier-seq>.made,
                text                    => ~$/,
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

    our role Rules {

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

        rule new-initializer:sym<expr-list> { 
            <left-paren> 
            <expression-list>?  
            <right-paren> 
        }

        rule new-initializer:sym<braced> { 
            <braced-init-list> 
        }
    }
}
