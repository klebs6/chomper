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

our role TypeParameter::Actions {

    # rule type-parameter-base:sym<basic> { [ <template> <less> <templateparameter-list> <greater> ]? <class_> }
    method type-parameter-base:sym<basic>($/) {
        make TypeParameterBase::Basic.new(
            templateparameter-list => $<templateparameter-list>.made,
        )
    }

    # rule type-parameter-base:sym<typename> { <typename_> } 
    method type-parameter-base:sym<typename>($/) {
        make TypeParameterBase::Typename.new
    }

    # rule type-parameter-suffix:sym<maybe-ident> { <ellipsis>? <identifier>? }
    method type-parameter-suffix:sym<maybe-ident>($/) {

        my $base         = $<identifier>.made;
        my $has-ellipsis = $<has-ellipsis>.made;

        if $has-ellipsis {
            make TypeParameterSuffix::MaybeIdent.new(
                has-ellipsis => $has-ellipsis,
                identifier   => $base,
            )
        } else {
            make $base
        }
    }

    # rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> } 
    method type-parameter-suffix:sym<assign-type-id>($/) {
        make TypeParameterSuffix::AssignTypeId.new(
            identifier  => $<identifier>.made,
            the-type-id => $<the-type-id>.made,
        )
    }

    # rule type-parameter { <type-parameter-base> <type-parameter-suffix> }
    method type-parameter($/) {
        make TypeParameter.new(
            type-parameter-base   => $<type-parameter-base>.made,
            type-parameter-suffix => $<type-parameter-suffix>.made,
        )
    }
}
