
# rule trailing-return-type { 
#   <arrow> 
#   <trailing-type-specifier-seq> 
#   <abstract-declarator>? 
# }
our class TrailingReturnType { 
    has TrailingTypeSpecifierSeq $.trailing-type-specifier-seq is required;
    has IAbstractDeclarator      $.abstract-declarator;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-definition { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <declarator> 
#   <virtual-specifier-seq>? 
#   <function-body> 
# } #-----------------------------
our class FunctionDefinition { 
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq      $.decl-specifier-seq;
    has IDeclarator            $.declarator is required;
    has VirtualSpecifierSeq    $.virtual-specifier-seq;
    has IFunctionBody          $.function-body is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-body:sym<compound> { 
#   <constructor-initializer>? 
#   <compound-statement> 
# }
our class FunctionBody::Compound does IFunctionBody {
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement      $.compound-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-body:sym<try> { <function-try-block> }
our class FunctionBody::Try does IFunctionBody {
    has FunctionTryBlock $.function-try-block is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-body:sym<assign-default> { 
#   <assign> 
#   <default_> 
#   <semi> 
# }
our class FunctionBody::AssignDefault does IFunctionBody { 
    has IComment $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-body:sym<assign-delete> { 
#   <assign> 
#   <delete> 
#   <semi> 
# }
our class FunctionBody::AssignDelete does IFunctionBody { 
    has IComment $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-specifier:sym<inline> { <.inline> }
our class FunctionSpecifier::Inline does IFunctionSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-specifier:sym<virtual> { <.virtual> }
our class FunctionSpecifier::Virtual does IFunctionSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule function-specifier:sym<explicit> { <.explicit> }
our class FunctionSpecifier::Explicit does IFunctionSpecifier { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

