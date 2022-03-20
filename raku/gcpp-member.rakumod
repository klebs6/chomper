
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

our role Member::Actions {

    # rule member-specification-base:sym<decl> { <memberdeclaration> }
    method member-specification-base:sym<decl>($/) {
        make $<memberdeclaration>.made
    }

    # rule member-specification-base:sym<access> { <access-specifier> <colon> }
    method member-specification-base:sym<access>($/) {
        make MemberSpecificationBase::Access.new(
            access-specifier => $<access-specifier>.made,
        )
    }

    # rule member-specification { <member-specification-base>+ } 
    method member-specification($/) {
        make $<member-specification-base>>>.made
    }

    # rule memberdeclaration:sym<basic> { 
    #   <attribute-specifier-seq>? 
    #   <decl-specifier-seq>? 
    #   <member-declarator-list>? 
    #   <semi> 
    # }
    method memberdeclaration:sym<basic>($/) {
        make Memberdeclaration::Basic.new(
            comment                 => $<semi>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            decl-specifier-seq      => $<decl-specifier-seq>.made,
            member-declarator-list  => $<member-declarator-list>.made,
        )
    }

    # rule memberdeclaration:sym<func> { <function-definition> }
    method memberdeclaration:sym<func>($/) {
        make $<function-definition>.made
    }

    # rule memberdeclaration:sym<using> { <using-declaration> }
    method memberdeclaration:sym<using>($/) {
        make $<using-declaration>.made
    }

    # rule memberdeclaration:sym<static-assert> { <static-assert-declaration> }
    method memberdeclaration:sym<static-assert>($/) {
        make $<static-assert-declaration>.made
    }

    # rule memberdeclaration:sym<template> { <template-declaration> }
    method memberdeclaration:sym<template>($/) {
        make $<template-declaration>.made
    }

    # rule memberdeclaration:sym<alias> { <alias-declaration> }
    method memberdeclaration:sym<alias>($/) {
        make $<alias-declaration>.made
    }

    # rule memberdeclaration:sym<empty> { <empty-declaration> } 
    method memberdeclaration:sym<empty>($/) {
        make Memberdeclaration::Empty.new
    }

    # rule member-declarator-list { <member-declarator> [ <.comma> <member-declarator> ]* } 
    method member-declarator-list($/) {
        make $<member-declarator>>>.made
    }

    # rule member-declarator:sym<virt> { <declarator> <virtual-specifier-seq>? <pure-specifier>? }
    method member-declarator:sym<virt>($/) {

        my $base = $<declarator>.made;
        my $t0   = $<virtual-specifier-seq>.made;
        my $t1   = $<pure-specifier>.made;

        if $t0 or $t1 {
            make MemberDeclarator::Virt.new(
                declarator            => $base,
                virtual-specifier-seq => $t0,
                pure-specifier        => $t1,
            )
        } else {
            make $base
        }
    }

    # rule member-declarator:sym<brace-or-eq> { <declarator> <brace-or-equal-initializer>? }
    method member-declarator:sym<brace-or-eq>($/) {
        my $body = $<declarator>.made;
        my $tail = $<brace-or-equal-initializer>.made;

        if $tail {
            make MemberDeclarator::BraceOrEq.new(
                declarator                 => $body,
                brace-or-equal-initializer => $tail,
            )
        } else {
            make $body
        }
    }

    # rule member-declarator:sym<ident> { <identifier>? <attribute-specifier-seq>? <colon> <constant-expression> } 
    method member-declarator:sym<ident>($/) {
        make MemberDeclarator::Ident.new(
            identifier              => $<identifier>.made,
            attribute-specifier-seq => $<attribute-specifier-seq>.made,
            constant-expression     => $<constant-expression>.made,
        )
    }
}
