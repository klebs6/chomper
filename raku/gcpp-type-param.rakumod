# rule type-parameter-base:sym<basic> { 
#   [ <template> <less> <templateparameter-list> <greater> ]? 
#   <class_> 
# }
our class TypeParameterBase::Basic does ITypeParameterBase {
    has TemplateParameterList $.templateparameter-list;
    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-parameter-base:sym<typename> { 
#   <typename_> 
# }
our class TypeParameterBase::Typename does ITypeParameterBase {

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-parameter-suffix:sym<maybe-ident> { 
#   <ellipsis>? 
#   <identifier>? 
# }
our class TypeParameterSuffix::MaybeIdent does ITypeParameterSuffix {
    has Bool       $.has-ellipsis;
    has Identifier $.identifier;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-parameter-suffix:sym<assign-type-id> { 
#   <identifier>? 
#   <assign> 
#   <the-type-id>  
# }
our class TypeParameterSuffix::AssignTypeId does ITypeParameterSuffix {
    has Identifier $.identifier;
    has ITheTypeId $.the-type-id is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule type-parameter { 
#   <type-parameter-base> 
#   <type-parameter-suffix> 
# }
our class TypeParameter { 
    has ITypeParameterBase   $.type-parameter-base   is required;
    has ITypeParameterSuffix $.type-parameter-suffix is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}
