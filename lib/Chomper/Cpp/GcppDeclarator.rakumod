unit module Chomper::Cpp::GcppDeclarator;

use Data::Dump::Tree;

use Chomper::Cpp::GcppRoles;
use Chomper::Cpp::GcppParam;
use Chomper::Cpp::GcppFunction;
use Chomper::Cpp::GcppExpression;
use Chomper::Cpp::GcppPtrDeclarator;

# rule init-declarator { 
#   <declarator> 
#   <initializer>? 
# }
our class InitDeclarator does IInitDeclarator { 
    has IDeclarator  $.declarator is required;
    has IInitializer $.initializer;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.declarator.gist(:$treemark);

        if $.initializer {
            $builder ~= $.initializer.gist(:$treemark);
        }

        $builder
    }
}


# rule declarator:sym<ptr> { <pointer-declarator> }
our class Declarator::Ptr does IDeclarator {
    has PointerDeclarator $.pointer-declarator is required;

    has $.text;

    method gist(:$treemark=False) {
        $.pointer-declarator.gist(:$treemark)
    }
}

# rule declarator:sym<no-ptr> { 
#   <no-pointer-declarator> 
#   <parameters-and-qualifiers> 
#   <trailing-return-type> 
# }
our class Declarator::NoPtr does IDeclarator {
    has INoPointerDeclarator    $.no-pointer-declarator     is required;
    has ParametersAndQualifiers $.parameters-and-qualifiers is required;
    has TrailingReturnType      $.trailing-return-type      is required;

    has $.text;

    method gist(:$treemark=False) {
        $.no-pointer-declarator.gist(:$treemark)
        ~ " "
        ~ $.parameters-and-qualifiers.gist(:$treemark)
        ~ " "
        ~ $.trailing-return-type.gist(:$treemark)
    }
}

# rule declaratorid { 
#   <ellipsis>? 
#   <id-expression> 
# }
our class Declaratorid 
does INoPointerDeclaratorBase { 

    has Bool          $.has-ellipsis  is required;
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist(:$treemark=False) {

        my $builder = $.has-ellipsis ?? "..." !! "";

        $builder ~ $.id-expression.gist(:$treemark)
    }
}

# rule some-declarator:sym<basic> { 
#   <declarator> 
# }
our class SomeDeclarator::Basic does ISomeDeclarator {
    has IDeclarator $.declarator is required;

    has $.text;

    method gist(:$treemark=False) {
        $.declarator.gist(:$treemark)
    }
}

# rule some-declarator:sym<abstract> { 
#   <abstract-declarator> 
# }
our class SomeDeclarator::Abstract does ISomeDeclarator {
    has IAbstractDeclarator $.abstract-declarator is required;

    has $.text;

    method gist(:$treemark=False) {
        $.abstract-declarator.gist(:$treemark)
    }
}

our role Declarator::Actions {

    # rule init-declarator-list { <init-declarator> [ <.comma> <init-declarator> ]* }
    method init-declarator-list($/) {
        make $<init-declarator>>>.made
    }

    # rule init-declarator { <declarator> <initializer>? } 
    method init-declarator($/) {

        my $initializer = $<initializer>.made;
        my $body        = $<declarator>.made;

        if $initializer {

            make InitDeclarator.new(
                declarator  => $body,
                initializer => $initializer,
                text        => ~$/,
            )

        } else {

            make $body
        }
    }

    # rule declarator:sym<ptr> { <pointer-declarator> }
    method declarator:sym<ptr>($/) {
        make $<pointer-declarator>.made
    }

    # rule declarator:sym<no-ptr> { <no-pointer-declarator> <parameters-and-qualifiers> <trailing-return-type> }
    method declarator:sym<no-ptr>($/) {
        make Declarator::NoPtr.new(
            no-pointer-declarator     => $<no-pointer-declarator>.made,
            parameters-and-qualifiers => $<parameters-and-qualifiers>.made,
            trailing-return-type      => $<trailing-return-type>.made,
            text                      => ~$/,
        )
    }

    # rule declaratorid { <ellipsis>? <id-expression> }
    method declaratorid($/) {

        my $has-ellipsis = so $/<ellipsis>:exists;
        my $body         = $<id-expression>.made;

        if $has-ellipsis {
            make Declaratorid.new(
                has-ellipsis  => $has-ellipsis,
                id-expression => $body,
                text          => ~$/,
            )
        } else {
            make $body
        }
    }

    # rule some-declarator:sym<basic> { <declarator> }
    method some-declarator:sym<basic>($/) {
        make $<declarator>.made
    }

    # rule some-declarator:sym<abstract> { <abstract-declarator> } 
    method some-declarator:sym<abstract>($/) {
        make $<abstract-declarator>.made
    }
}

our role Declarator::Rules {

    proto rule some-declarator { * }
    rule some-declarator:sym<basic>    { <declarator> }
    rule some-declarator:sym<abstract> { <abstract-declarator> }

    rule declaratorid {
        <ellipsis>?  <id-expression>
    }
}