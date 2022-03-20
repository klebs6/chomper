
# rule member-specification-base:sym<decl> { 
#   <memberdeclaration> 
# }
our class MemberSpecificationBase::Decl does IMemberSpecificationBase {
    has IMemberdeclaration $.memberdeclaration is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule member-specification-base:sym<access> { 
#   <access-specifier> 
#   <colon> 
# }
our class MemberSpecificationBase::Access does IMemberSpecificationBase {
    has IAccessSpecifier $.access-specifier is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule member-specification { 
#   <member-specification-base>+ 
# }
our class MemberSpecification { 
    has IMemberSpecificationBase @.member-specification-bases is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<basic> { 
#   <attribute-specifier-seq>? 
#   <decl-specifier-seq>? 
#   <member-declarator-list>? 
#   <semi> 
# }
our class Memberdeclaration::Basic does IMemberdeclaration {
    has IComment               $.comment;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IDeclSpecifierSeq       $.decl-specifier-seq;
    has MemberDeclaratorList   $.member-declarator-list;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<func> { 
#   <function-definition> 
# }
our class Memberdeclaration::Func does IMemberdeclaration {
    has FunctionDefinition $.function-definition is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<using> { 
#   <using-declaration> 
# }
our class Memberdeclaration::Using does IMemberdeclaration {
    has UsingDeclaration $.using-declaration is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<static-assert> { 
#   <static-assert-declaration> 
# }
our class Memberdeclaration::StaticAssert does IMemberdeclaration {
    has StaticAssertDeclaration $.static-assert-declaration is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<template> { 
#   <template-declaration> 
# }
our class Memberdeclaration::Template does IMemberdeclaration {
    has TemplateDeclaration $.template-declaration is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<alias> { 
#   <alias-declaration> 
# }
our class Memberdeclaration::Alias does IMemberdeclaration {
    has AliasDeclaration $.alias-declaration is required;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule memberdeclaration:sym<empty> { 
#   <empty-declaration> 
# }
our class Memberdeclaration::Empty does IMemberdeclaration { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule member-declarator-list { 
#   <member-declarator> 
#   [ <.comma> <member-declarator> ]* 
# }
our class MemberDeclaratorList { 
    has IMemberDeclarator @.member-declarators is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule member-declarator:sym<virt> { 
#   <declarator> 
#   <virtual-specifier-seq>? 
#   <pure-specifier>? 
# }
our class MemberDeclarator::Virt does IMemberDeclarator {
    has IDeclarator         $.declarator is required;
    has VirtualSpecifierSeq $.virtual-specifier-seq;
    has PureSpecifier       $.pure-specifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule member-declarator:sym<brace-or-eq> { 
#   <declarator> 
#   <brace-or-equal-initializer>? 
# }
our class MemberDeclarator::BraceOrEq does IMemberDeclarator {
    has IDeclarator              $.declarator is required;
    has IBraceOrEqualInitializer $.brace-or-equal-initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule member-declarator:sym<ident> { 
#   <identifier>? 
#   <attribute-specifier-seq>? 
#   <colon> 
#   <constant-expression> 
# }
our class MemberDeclarator::Ident does IMemberDeclarator {
    has Identifier             $.identifier;
    has IAttributeSpecifierSeq $.attribute-specifier-seq;
    has IConstantExpression    $.constant-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
