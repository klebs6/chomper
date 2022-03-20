
# rule init-declarator { 
#   <declarator> 
#   <initializer>? 
# }
our class InitDeclarator does IInitDeclarator { 
    has IDeclarator  $.declarator is required;
    has IInitializer $.initializer;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}


# rule declarator:sym<ptr> { <pointer-declarator> }
our class Declarator::Ptr does IDeclarator {
    has PointerDeclarator $.pointer-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule declaratorid { 
#   <ellipsis>? 
#   <id-expression> 
# }
our class Declaratorid 
does INoPointerDeclaratorBase { 

    has Bool         $.has-ellipsis  is required;
    has IIdExpression $.id-expression is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule some-declarator:sym<basic> { 
#   <declarator> 
# }
our class SomeDeclarator::Basic does ISomeDeclarator {
    has IDeclarator $.declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule some-declarator:sym<abstract> { 
#   <abstract-declarator> 
# }
our class SomeDeclarator::Abstract does ISomeDeclarator {
    has IAbstractDeclarator $.abstract-declarator is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
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
                initializer => Initializer.new(value => $initializer),
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
