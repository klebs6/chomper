use Data::Dump::Tree;

use gcpp-roles;
use gcpp-attr;

# rule using-declaration-prefix:sym<nested> { 
#   [ <typename_>? <nested-name-specifier> ] 
# }
our class UsingDeclarationPrefix::Nested does IUsingDeclarationPrefix {
    has Bool $.has-typename is required;
    has INestedNameSpecifier $.nested-name-specifier is required;

    has $.text;

    method gist(:$treemark=False) {
        if $.has-typename {
            $.nested-name-specifier.gist(:$treemark)
        } else {
            "typename " ~ $.nested-name-specifier.gist(:$treemark)
        }
    }
}

# rule using-declaration-prefix:sym<base> { 
#   <doublecolon> 
# }
our class UsingDeclarationPrefix::Base does IUsingDeclarationPrefix {

    has $.text;

    method gist(:$treemark=False) {
        "::"
    }
}

# rule using-declaration { 
#   <using> 
#   <using-declaration-prefix> 
#   <unqualified-id> 
#   <semi> 
# }
our class UsingDeclaration { 
    has IComment                $.comment;
    has IUsingDeclarationPrefix $.using-declaration-prefix is required;
    has IUnqualifiedId          $.unqualified-id is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = "";

        if $.comment {
            $builder ~= $.comment.gist(:$treemark) ~ "\n";
        }

        $builder 
        ~ "using " 
        ~ $.using-declaration-prefix.gist(:$treemark) 
        ~ " " 
        ~ $.unqualified-id.gist(:$treemark) 
        ~ ";"
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

    method gist(:$treemark=False) {

        my $builder = "";

        my $a = $.attribute-specifier-seq;

        if $a {
            $builder ~= $a.gist(:$treemark) ~ "\n";
        }

        $builder ~= "using namespace ";

        my $b = $.nested-name-specifier;

        if $b {
            $builder ~= $b.gist(:$treemark);
        }

        $builder ~ $.namespace-name.gist(:$treemark) ~ ";"
    }
}

our role UsingDirective::Actions {

    # rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
    method using-declaration-prefix:sym<nested>($/) {
        make UsingDeclarationPrefix::Nested.new(
            nested-name-specifier => $<nested-name-specifier>.made,
            text                  => ~$/,
        )
    }

    # rule using-declaration-prefix:sym<base> { <doublecolon> } 
    method using-declaration-prefix:sym<base>($/) {
        make UsingDeclarationPrefix::Base.new
    }

    # rule using-declaration { <using> <using-declaration-prefix> <unqualified-id> <semi> }
    method using-declaration($/) {
        make UsingDeclaration.new(
            comment                  => $<semi>.made,
            using-declaration-prefix => $<using-declaration-prefix>.made,
            unqualified-id           => $<unqualified-id>.made,
            text                     => ~$/,
        )
    }

    # rule using-directive { <attribute-specifier-seq>? <using> <namespace> <nested-name-specifier>? <namespace-name> <semi> }
    method using-directive($/) {
        make UsingDirective.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            nested-name-specifier   => $<nested-name-specifier>.made,
            namespace-name          => $<namespace-name>.made,
            text                    => ~$/,
        )
    }
}

our role UsingDirective::Rules {

    proto rule using-declaration-prefix { * }
    rule using-declaration-prefix:sym<nested> { [ <typename_>? <nested-name-specifier> ] }
    rule using-declaration-prefix:sym<base>   { <doublecolon> }

    rule using-declaration {
        <using>
        <using-declaration-prefix>
        <unqualified-id>
        <semi>
    }

    rule using-directive {
        <attribute-specifier-seq>?
        <using>
        <namespace>
        <nested-name-specifier>?
        <namespace-name>
        <semi>
    }
}
