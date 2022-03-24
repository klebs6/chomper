use Data::Dump::Tree;

use gcpp-roles;
use gcpp-statement;
use gcpp-constructor;

# rule handler { 
#   <catch> 
#   <.left-paren> 
#   <exception-declaration> 
#   <.right-paren> 
#   <compound-statement> 
# }
our class Handler { 
    has IExceptionDeclaration $.exception-declaration is required;
    has $.compound-statement is required;

    has $.text;

    method gist{
        "catch(" 
        ~ $.exception-declaration.gist 
        ~ ")" 
        ~ $.compound-statement.gist
    }
}

# rule handler-seq { 
#   <handler>+ 
# }
our class HandlerSeq { 
    has Handler @.handlers is required;

    has $.text;

    method gist{
        @.handlers>>.gist.join("\n")
    }
}

# rule try-block { 
#   <try_> 
#   <compound-statement> 
#   <handler-seq> 
# }
our class TryBlock { 
    has $.compound-statement is required;
    has @.handler-seq is required;

    has $.text;

    method gist{

        my $builder = "try " ~ $.compound-statement.gist;

        for @.handler-seq {
            $builder ~= $_.gist ~ "\n";
        }

        $builder
    }
}

# rule function-try-block { 
#   <try_> 
#   <constructor-initializer>? 
#   <compound-statement> 
#   <handler-seq> 
# }
our class FunctionTryBlock { 
    has ConstructorInitializer $.constructor-initializer;
    has CompoundStatement      $.compound-statement is required;
    has                        @.handler-seq is required;

    has $.text;

    method gist{

        my $builder = "try ";

        $builder = $builder.&maybe-extend($.constructor-initializer);

        $builder ~= $.compound-statement.gist;

        for @.handler-seq {
            $builder ~= $_.gist ~ "\n";
        }

        $builder
    }
}

our role Try::Actions {

    # rule try-block { <try_> <compound-statement> <handler-seq> }
    method try-block($/) {
        make TryBlock.new(
            compound-statement => $<compound-statement>.made,
            handler-seq        => $<handler-seq>.made,
            text               => ~$/,
        )
    }

    # rule function-try-block { <try_> <constructor-initializer>? <compound-statement> <handler-seq> }
    method function-try-block($/) {
        make FunctionTryBlock.new(
            constructor-initializer => $<constructor-initializer>.made,
            compound-statement      => $<compound-statement>.made,
            handler-seq             => $<handler-seq>.made,
            text                    => ~$/,
        )
    }

    # rule handler-seq { <handler>+ }
    method handler-seq($/) {
        make $<handler>>>.made
    }

    # rule handler { <catch> <.left-paren> <exception-declaration> <.right-paren> <compound-statement> }
    method handler($/) {
        make Handler.new(
            exception-declaration => $<exception-declaration>.made,
            compound-statement    => $<compound-statement>.made,
            text                  => ~$/,
        )
    }
}

our role Try::Rules {

    rule try-block {
        <try_>
        <compound-statement>
        <handler-seq>
    }

    rule function-try-block {
        <try_>
        <constructor-initializer>?
        <compound-statement>
        <handler-seq>
    }

    rule handler-seq {
        <handler>+
    }

    rule handler {
        <catch>
        <left-paren>
        <exception-declaration>
        <right-paren>
        <compound-statement>
    }
}
