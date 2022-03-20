
# rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
our class UsingDeclarationPrefix::Nested does IUsingDeclarationPrefix {
    has INestedNameSpecifier $.nested-name-specifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule using-declaration-prefix:sym<base> { <doublecolon> } #--------------------
our class UsingDeclarationPrefix::Base does IUsingDeclarationPrefix {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule using-declaration { <using> <using-declaration-prefix> <unqualified-id> <semi> }
our class UsingDeclaration { 
    has IComment                $.comment;
    has IUsingDeclarationPrefix $.using-declaration-prefix is required;
    has IUnqualifiedId          $.unqualified-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule using-directive { 
#   <attribute-specifier-seq>? 
#   <using> 
#   <namespace> 
#   <nested-name-specifier>? 
#   <namespace-name> 
#   <semi> 
# }
our class UsingDirective { 
    has IComment                $.comment;
    has IAttributeSpecifierSeq  $.attribute-specifier-seq;
    has INestedNameSpecifier    $.nested-name-specifier;
    has INamespaceName          $.namespace-name is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
