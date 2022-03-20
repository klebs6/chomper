# rule declarationseq { 
#   <declaration>+ 
# }
our class Declarationseq { 
    has IDeclaration @.declarations is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule alias-declaration { 
#   <.using> 
#   <identifier> 
#   <attribute-specifier-seq>? 
#   <.assign> 
#   <the-type-id> 
#   <.semi> 
# } #---------------------------
our class AliasDeclaration { 
    has IComment               $.comment;
    has Identifier             $.identifier is required;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has ITheTypeId             $.the-type-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule simple-declaration:sym<basic> { 
#   <decl-specifier-seq>? 
#   <init-declarator-list>? 
#   <.semi> 
# }
our class SimpleDeclaration::Basic 
does IDeclarationStatement 
does ISimpleDeclaration {

    has IComment           $.comment;
    has IDeclSpecifierSeq   $.decl-specifier-seq;
    has IInitDeclarator     @.init-declarator-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-declaration:sym<init-list> { 
#   <attribute-specifier-seq> 
#   <decl-specifier-seq>? 
#   <init-declarator-list> 
#   <.semi> 
# }
our class SimpleDeclaration::InitList 
does ISimpleDeclaration {

    has IComment            $.comment;
    has IAttributeSpecifier @.attribute-specifiers is required;
    has IDeclSpecifierSeq   $.decl-specifier-seq;
    has IInitDeclarator     @.init-declarator-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule static-assert-declaration { 
#   <.static_assert> 
#   <.left-paren> 
#   <constant-expression> 
#   <.comma> 
#   <string-literal> 
#   <.right-paren> 
#   <.semi> 
# }
our class StaticAssertDeclaration { 
    has IComment            $.comment;
    has IConstantExpression $.constant-expression is required;
    has StringLiteral       $.string-literal is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule empty-declaration { <.semi> }
our class EmptyDeclaration { 
    has IComment           $.comment;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
