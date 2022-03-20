
# rule lambda-expression { 
#   <lambda-introducer> 
#   <lambda-declarator>? 
#   <compound-statement> 
# }
our class LambdaExpression { 
    has LambdaIntroducer  $.lambda-introducer is required;
    has LambdaDeclarator  $.lambda-declarator;
    has CompoundStatement $.compound-statement is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-introducer { 
#   <.left-bracket> 
#   <lambda-capture>? 
#   <.right-bracket> 
# }
our class LambdaIntroducer { 
    has ILambdaCapture $.lambda-capture;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-capture:sym<list> { <capture-list> }
our class LambdaCapture::List does ILambdaCapture {
    has CaptureList $.capture-list is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-capture:sym<def> { 
#   <capture-default> 
#   [ <comma> <capture-list> ]? 
# }
our class LambdaCapture::Def does ILambdaCapture {
    has ICaptureDefault $.capture-default is required;
    has CaptureList    $.capture-list;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture-default:sym<and> { <and_> }
our class CaptureDefault::And does ICaptureDefault { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture-default:sym<assign> { <assign> }
our class CaptureDefault::Assign does ICaptureDefault { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture-list { <capture> [ <comma> <capture> ]* <ellipsis>? } 
our class CaptureList {
    has ICapture @.captures is required;
    has Bool     $.trailing-ellipsis is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture:sym<simple> { <simple-capture> }
our class Capture::Simple does ICapture {
    has ISimpleCapture $.simple-capture is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule capture:sym<init> { <initcapture> } 
our class Capture::Init does ICapture {
    has Initcapture $.init-capture is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-capture:sym<id> { <and_>? <identifier> }
our class SimpleCapture::Id does ISimpleCapture {
    has Bool       $.has-and;
    has Identifier $.identifier is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule simple-capture:sym<this> { <this> }
our class SimpleCapture::This does ISimpleCapture { 

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule initcapture { 
#   <and_>? 
#   <identifier> 
#   <initializer> 
# }
our class Initcapture { 
    has Bool $.has-and;
    has Identifier  $.identifier  is required;
    has IInitializer $.initializer is required;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

# rule lambda-declarator { 
#   <.left-paren> 
#   <parameter-declaration-clause>? 
#   <.right-paren> 
#   <mutable>? 
#   <exception-specification>? 
#   <attribute-specifier-seq>? 
#   <trailing-return-type>? 
# }
our class LambdaDeclarator { 
    has ParameterDeclarationClause $.parameter-declaration-clause is required;
    has Bool                       $.mutable                      is required;
    has IExceptionSpecification    $.exception-specification;
    has IAttributeSpecifierSeq      $.attribute-specifier-seq;
    has TrailingReturnType         $.trailing-return-type;

    has $.text;

    method gist{
        say "need write gist!";
        ddt self;
        exit;
    }
}

