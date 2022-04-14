use Data::Dump::Tree;

use gcpp-roles;
use gcpp-ident;

# rule templateparameter-list { 
#   <template-parameter> 
#   [ <.comma> <template-parameter> ]* 
# }
our class TemplateParameterList { 
    has ITemplateParameter @.template-parameters is required;
    has $.text;

    method gist(:$treemark=False) {
        @.template-parameters>>.gist(:$treemark).join(", ")
    }
}

# rule type-parameter-base:sym<basic> { 
#   [ <template> <less> <templateparameter-list> <greater> ]? 
#   <class_> 
# }
our class TypeParameterBase::Basic does ITypeParameterBase {
    has TemplateParameterList $.templateparameter-list;
    has $.text;

    method gist(:$treemark=False) {

        if $.templateparameter-list {
            "template<" ~ $.templateparameter-list.gist(:$treemark) ~ "> " ~ "class"
        } else {
            "class"
        }
    }
}

# rule type-parameter-base:sym<typename> { 
#   <typename_> 
# }
our class TypeParameterBase::Typename does ITypeParameterBase {

    has $.text;

    method gist(:$treemark=False) {
        "typename"
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

    method gist(:$treemark=False) {

        my $builder = "";

        if $.has-ellipsis {
            $builder ~= "...";
        }

        if $.identifier {
            $builder ~= $.identifier.gist(:$treemark);
        }

        $builder
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

    method gist(:$treemark=False) {
        my $builder = "";

        if $.identifer {
            $builder ~= $.identifier.gist(:$treemark) ~ " ";
        }

        $builder ~ " = " ~ $.the-type-id.gist(:$treemark)
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

    method gist(:$treemark=False) {
        $.type-parameter-base.gist(:$treemark) ~ $.type-parameter-suffix.gist(:$treemark)
    }
}

our role TypeParameter::Actions {

    # rule type-parameter-base:sym<basic> { [ <template> <less> <templateparameter-list> <greater> ]? <class_> }
    method type-parameter-base:sym<basic>($/) {
        make TypeParameterBase::Basic.new(
            templateparameter-list => $<templateparameter-list>.made,
            text                   => ~$/,
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
                text         => ~$/,
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
            text        => ~$/,
        )
    }

    # rule type-parameter { <type-parameter-base> <type-parameter-suffix> }
    method type-parameter($/) {
        make TypeParameter.new(
            type-parameter-base   => $<type-parameter-base>.made,
            type-parameter-suffix => $<type-parameter-suffix>.made,
            text                  => ~$/,
        )
    }
}

our role TypeParameter::Rules {

    proto rule type-parameter-base { * }

    rule type-parameter-base:sym<basic> {
       [ <template> <less> <templateparameter-list> <greater> ]? 
       <class_>
    }

    rule type-parameter-base:sym<typename> {
       <typename_>
    }

    proto rule type-parameter-suffix { * }
    rule type-parameter-suffix:sym<maybe-ident>    { <ellipsis>? <identifier>? }
    rule type-parameter-suffix:sym<assign-type-id> { <identifier>? <assign> <the-type-id> }

    rule type-parameter {
        <type-parameter-base>
        <type-parameter-suffix>
    }
}
