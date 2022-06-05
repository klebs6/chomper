unit module Chomper::Cpp::GcppMemInitializer;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppExpression;
use Chomper::Cpp::GcppIdent;

# rule mem-initializer-list { 
#   <mem-initializer> 
#   <ellipsis>? 
#   [ <.comma> <mem-initializer> <ellipsis>? ]* 
# }
class MemInitializerList is export { 
    has IMemInitializer @.mem-initializers is required;
    has $.text;

    method name {
        'MemInitializerList'
    }

    method gist(:$treemark=False) {
        @.mem-initializers>>.gist(:$treemark).join(", ")
    }
}

package MemInitializer is export {

    # rule mem-initializer:sym<expr-list> { 
    #   <meminitializerid> 
    #   <.left-paren> 
    #   <expression-list>? 
    #   <.right-paren> 
    # }
    our class ExprList does IMemInitializer {
        has IMemInitializerId $.meminitializerid is required;
        has ExpressionList    $.expression-list;
        has $.text;

        method name {
            'MemInitializer::ExprList'
        }

        method gist(:$treemark=False) {
            my $builder = $.meminitializerid.gist(:$treemark);

            $builder ~= "(";

            if $.expression-list {
                $builder ~= $.expression-list.gist(:$treemark);
            }

            $builder ~= ")"
        }
    }

    # rule mem-initializer:sym<braced> { 
    #   <meminitializerid> 
    #   <braced-init-list> 
    # }
    our class Braced does IMemInitializer {
        has IMemInitializerId $.meminitializerid is required;
        has BracedInitList    $.braced-init-list is required;
        has $.text;

        method name {
            'MemInitializer::Braced'
        }

        method gist(:$treemark=False) {
            $.meminitializerid.gist(:$treemark) ~ " " ~ $.braced-init-list.gist(:$treemark)
        }
    }
}


package MemInitializerId is export {

    # rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
    our class ClassOrDecl does IMemInitializerId {
        has IClassOrDeclType $.class-or-decl-type is required;
        has $.text;

        method name {
            'MemInitializerId::ClassOrDecl'
        }

        method gist(:$treemark=False) {
            $.class-or-decl-type.gist(:$treemark)
        }
    }

    # rule meminitializerid:sym<ident> { <identifier> }
    our class Ident does IMemInitializerId {
        has Identifier $.identifier is required;
        has $.text;

        method name {
            'MemInitializerId::Ident'
        }

        method gist(:$treemark=False) {
            $.identifier.gist(:$treemark)
        }
    }
}

package MemInitializerGrammar is export {

    our role Actions {

        # rule mem-initializer-list { <mem-initializer> <ellipsis>? [ <.comma> <mem-initializer> <ellipsis>? ]* } 
        method mem-initializer-list($/) {
            make MemInitializerList.new(
                mem-initializers => $<mem-initializer>>>.made
            )
        }

        # rule mem-initializer:sym<expr-list> { <meminitializerid> <.left-paren> <expression-list>? <.right-paren> }
        method mem-initializer:sym<expr-list>($/) {
            make MemInitializer::ExprList.new(
                meminitializerid => $<meminitializerid>.made,
                expression-list  => $<expression-list>.made,
            )
        }

        # rule mem-initializer:sym<braced> { <meminitializerid> <braced-init-list> } 
        method mem-initializer:sym<braced>($/) {
            make MemInitializer::Braced.new(
                meminitializerid => $<meminitializerid>.made,
                braced-init-list => $<braced-init-list>.made,
            )
        }

        # rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
        method meminitializerid:sym<class-or-decl>($/) {
            make $<class-or-decl-type>.made
        }

        # rule meminitializerid:sym<ident> { <identifier> }
        method meminitializerid:sym<ident>($/) {
            make $<identifier>.made
        }
    }

    our role Rules {

        rule mem-initializer-list {
            <mem-initializer>
            <ellipsis>?
            [ <comma> <mem-initializer> <ellipsis>? ]*
        }

        proto rule mem-initializer { * }

        rule mem-initializer:sym<expr-list> {
            <meminitializerid>
            <left-paren> 
            <expression-list>?  
            <right-paren>
        }

        rule mem-initializer:sym<braced> {
            <meminitializerid>
            <braced-init-list>
        }

        proto rule meminitializerid { * }
        rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
        rule meminitializerid:sym<ident>         { <identifier> }
    }
}
