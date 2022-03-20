# rule mem-initializer-list { 
#   <mem-initializer> 
#   <ellipsis>? 
#   [ <.comma> <mem-initializer> <ellipsis>? ]* 
# }
our class MemInitializerList { 
    has IMemInitializer @.mem-initializers is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
    has ExpressionList   $.expression-list;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule mem-initializer:sym<braced> { 
#   <meminitializerid> 
#   <braced-init-list> 
# }
our class MemInitializer::Braced does IMemInitializer {
    has IMeminitializerid $.meminitializerid is required;
    has BracedInitList   $.braced-init-list   is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule meminitializerid:sym<class-or-decl> { <class-or-decl-type> }
our class Meminitializerid::ClassOrDecl does IMeminitializerid {
    has IClassOrDeclType $.class-or-decl-type is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule meminitializerid:sym<ident> { <identifier> }
our class Meminitializerid::Ident does IMeminitializerid {
    has Identifier $.identifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}



