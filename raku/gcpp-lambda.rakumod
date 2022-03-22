use Data::Dump::Tree;

use gcpp-roles;
use gcpp-statement;
use gcpp-ident;
use gcpp-param;
use gcpp-attr;
use gcpp-function;

our class LambdaDeclarator { ... }
our class CaptureList { ... }
our class Initcapture { ... }

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

our role LambdaExpression::Actions {

    # rule lambda-expression { 
    #   <lambda-introducer> 
    #   <lambda-declarator>? 
    #   <compound-statement> 
    # }
    method lambda-expression($/) {
        make LambdaExpression.new(
            lambda-introducer  => $<lambda-introducer>.made,
            lambda-declarator  => $<lambda-declarator>.made,
            compound-statement => $<compound-statement>.made,
        )
    }

    # rule lambda-introducer { <.left-bracket> <lambda-capture>? <.right-bracket> } 
    method lambda-introducer($/) {
        make LambdaIntroducer.new(
            lambda-capture => $<lambda-capture>.made
        )
    }

    # rule lambda-capture:sym<list> { <capture-list> }
    method lambda-capture:sym<list>($/) {
        make LambdaCapture::List.new(
            capture-list => $<capture-list>.made
        )
    }

    # rule lambda-capture:sym<def> { <capture-default> [ <.comma> <capture-list> ]? } 
    method lambda-capture:sym<def>($/) {

        my $body = $<capture-default>.made;
        my $tail = $<capture-list>.made;

        if $tail {
            make LambdaCapture::Def.new(
                capture-default => $body,
                capture-list    => $tail,
            )

        } else {
            make $body
        }
    }

    # rule capture-default:sym<and> { <and_> }
    method capture-default:sym<and>($/) {
        make CaptureDefault::And.new
    }

    # rule capture-default:sym<assign> { <assign> } 
    method capture-default:sym<assign>($/) {
        make CaptureDefault::Assign.new
    }

    # rule capture-list { <capture> [ <.comma> <capture> ]* <ellipsis>? } 
    method capture-list($/) {

        my @captures     = $<capture>>>.made;
        my $has-ellipsis = so $/<ellipsis>:exists;

        if @captures.elems gt 1 or $has-ellipsis {
            make CaptureList.new(
                captures          => @captures,
                trailing-ellipsis => $has-ellipsis,
            )
        } else {
            make @captures[0]
        }
    }

    # rule capture:sym<simple> { <simple-capture> }
    method capture:sym<simple>($/) {
        make Capture::Simple.new(
            simple-capture => $<simple-capture>.made,
        )
    }

    # rule capture:sym<init> { <initcapture> } 
    method capture:sym<init>($/) {
        make Capture::Init.new(
            init-capture => $<init-capture>.made,
        )
    }

    # rule simple-capture:sym<id> { <and_>? <identifier> }
    method simple-capture:sym<id>($/) {

        my $id      = $<identifier>.made;
        my $has-and = so $/<and_>:exists;

        if $has-and {
            make SimpleCapture::Id.new(
                has-and_   => True,
                identifier => $id,
            )
        } else {
            make SimpleCapture::Id.new(
                has-and_   => False,
                identifier => $id,
            )
        }
    }

    # rule simple-capture:sym<this> { <this> } 
    method simple-capture:sym<this>($/) {
        make SimpleCapture::This.new
    }

    # rule initcapture { <and_>? <identifier> <initializer> } 
    method initcapture($/) {
        make Initcapture.new(
            has-and     => $<has-and>.made,
            identifier  => $<identifier>.made,
            initializer => $<initializer>.made,
        )
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
    method lambda-declarator($/) {
        make LambdaDeclarator.new(
            parameter-declaration-clause => $<parameter-declaration-clause>.made,
            mutable                      => $<mutable>.made,
            exception-specification      => $<exception-specification>.made,
            attribute-specifier-seq      => $<attribute-specifier-seq>.made,
            trailing-return-type         => $<trailing-return-type>.made,
        )
    }
}

our role LambdaExpression::Rules {

    rule lambda-expression {
        <lambda-introducer> <lambda-declarator>?  <compound-statement>
    }

    rule lambda-introducer {
        <left-bracket> <lambda-capture>?  <right-bracket>
    }

    #-------------------------------
    proto rule lambda-capture { * }
    rule lambda-capture:sym<list> { <capture-list> }
    rule lambda-capture:sym<def>  { <capture-default> [ <comma> <capture-list> ]? }

    #-------------------------------
    proto rule capture-default { * }
    rule capture-default:sym<and>    { <and_> }
    rule capture-default:sym<assign> { <assign> }

    #-------------------------------
    rule capture-list {
        <capture> [ <comma> <capture> ]* <ellipsis>?
    }

    #-------------------------------
    proto rule capture { * }
    rule capture:sym<simple> { <simple-capture> }
    rule capture:sym<init>   { <initcapture> }

    #-------------------------------
    proto rule simple-capture { * }
    rule simple-capture:sym<id>   { <and_>? <identifier> }
    rule simple-capture:sym<this> { <this> }

    #-------------------------------
    rule initcapture {
        <and_>?  <identifier> <initializer>
    }

    #-------------------------------
    rule lambda-declarator {
        <left-paren>
        <parameter-declaration-clause>?
        <right-paren>
        <mutable>?
        <exception-specification>?
        <attribute-specifier-seq>?
        <trailing-return-type>?
    }
}
