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
our class MemInitializerList { 
    has IMemInitializer @.mem-initializers is required;
    has $.text;

    method gist(:$treemark=False) {
        @.mem-initializers>>.gist(:$treemark).join(", ")
    }
}

# rule mem-initializer:sym<expr-list> { 
#   <meminitializerid> 
#   <.left-paren> 
#   <expression-list>? 
#   <.right-paren> 
# }
our class MemInitializer::ExprList does IMemInitializer {
    has IMeminitializerid $.meminitializerid is required;
    has ExpressionList    $.expression-list;
    has $.text;

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
our class MemInitializer::Braced does IMemInitializer {
    has IMeminitializerid $.meminitializerid is required;
    has BracedInitList    $.braced-init-list is required;
    has $.text;

    method gist(:$treemark=False) {
        $.meminitializerid.gist(:$treemark) ~ " " ~ $.braced-init-list.gist(:$treemark)
    }
}


# rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has IClassOrDeclType $.class-or-decl-type is required;
    has $.text;

    method gist(:$treemark=False) {
        $.class-or-decl-type.gist(:$treemark)
    }
}

# rule meminitializerid:sym<ident> { <identifier> }
our class Meminitializerid::Ident does IMeminitializerid {
    has Identifier $.identifier is required;
    has $.text;

    method gist(:$treemark=False) {
        $.identifier.gist(:$treemark)
    }
}

our role MemInitializer::Actions {

    # rule mem-initializer-list { <mem-initializer> <ellipsis>? [ <.comma> <mem-initializer> <ellipsis>? ]* } 
    method mem-initializer-list($/) {
        make $<mem-initializer>>>.made;
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

our role MemInitializer::Rules {

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