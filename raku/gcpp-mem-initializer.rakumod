use Data::Dump::Tree;

use gcpp-roles;
use gcpp-expression;
use gcpp-ident;

# rule mem-initializer-list { 
#   <mem-initializer> 
#   <ellipsis>? 
#   [ <.comma> <mem-initializer> <ellipsis>? ]* 
# }
our class MemInitializerList { 
    has IMemInitializer @.mem-initializers is required;
    has $.text;

    method gist{
        @.mem-initializers>>.gist.join(", ")
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

    method gist{
        my $builder = $.meminitializerid.gist;

        $builder ~= "(";

        if $.expression-list {
            $builder ~= $.expression-list.gist;
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

    method gist{
        $.meminitializerid.gist ~ " " ~ $.braced-init-list.gist
    }
}


# rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has IClassOrDeclType $.class-or-decl-type is required;
    has $.text;

    method gist{
        $.class-or-decl-type.gist
    }
}

# rule meminitializerid:sym<ident> { <identifier> }
our class Meminitializerid::Ident does IMeminitializerid {
    has Identifier $.identifier is required;
    has $.text;

    method gist{
        $.identifier.gist
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
