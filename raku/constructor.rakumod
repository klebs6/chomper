use util;
use typemap;
use snake-case;

our class ConstructorFieldInitializer {

    has $.field-name is required;
    has $.initializer is required;

    our sub mock-empty {
        ()
    }

    our sub mock {
        (
            ConstructorFieldInitializer.new(
                field-name  => "data",
                initializer => "0",
            ),
            ConstructorFieldInitializer.new(
                field-name  => "rows",
                initializer => "5",
            ),
        )
    }
    method gist {
        "$!field-name\($!initializer\)"
    }
}

our class DefaultConstructor {
    has $.function-name;
    has @.comments;
    has ConstructorFieldInitializer @.field-initializers;

    our sub mock {
        #we expect this sort of output in this order
        DefaultConstructor.new(
            comments => ('//here is a comment'), 
            field-initializers => ConstructorFieldInitializer::mock(),
        )
    }
}

our class ConstructorHeader {

    has @.template-args;
    has $.function-name;
    has @.function-args-list;
    has @.option-defaults-initlist;
    has @.comments-list;
    has ConstructorFieldInitializer @.field-initializers;

    our sub mock {
        #we expect this sort of output in this order
        ConstructorHeader.new(
            template-args            => ('Scl', 'T'),
            function-name            => 'MyClass',
            function-args-list       => ('x: i32', 'y: i16'),
            option-defaults-initlist => (),
            comments-list            => ('//here is a comment'),
            field-initializers       => ConstructorFieldInitializer::mock(),
        )
    }
}

our sub get-ctor-field-initializers(Match $header) {

    #ConstructorFieldInitializer::mock()

    my $match = $header<constructor-initializers>;

    if $match {
        do for $match<constructor-initializer>.List {
            ConstructorFieldInitializer.new(
                field-name  => snake-case($_<field-name>.Str),
                initializer => $_<field-body>,
            )
        }
    } else {
        ConstructorFieldInitializer::mock-empty()
    }
}

#--------------------------------------------
our sub translate-default-ctor($submatch, $body, $user_rclass) {

    my $parsed = DefaultConstructor.new(

        comments           => 
        get-rcomments-list($submatch),

        field-initializers => 
        get-ctor-field-initializers($submatch),

        function-name            => 
        $submatch<type>.Str,
    );

    my $rcomment  = format-rust-comments($parsed.comments);

    my $rclass = 
    $parsed.function-name ?? 
    $parsed.function-name !!
    $user_rclass;

    qq:to/END/;
    impl Default for $rclass \{
        $rcomment
        fn default() -> Self \{
            todo!();
            /*
            {$parsed.field-initializers ?? ":" ~ $parsed.field-initializers>>.gist.join(",") !! ""}
            {$body.trim.chop.indent(4)}
            */
        \}
    \}
    END
}

#--------------------------------------------
our sub translate-ctor($submatch, $body, $user_rclass) {

    my $parsed = ConstructorHeader.new(
        template-args            => 
        get-template-args($submatch) // (),

        function-name            => 
        get-rctor-function-name($submatch),

        function-args-list       => 
        get-rfunction-args-list($submatch<parenthesized-args>),

        option-defaults-initlist => 
        get-option-defaults-initlist($submatch<parenthesized-args>),

        comments-list            => 
        get-rcomments-list($submatch),

        field-initializers       => 
        get-ctor-field-initializers($submatch),
    );

    my $rcomment       = format-rust-comments($parsed.comments-list);
    my $rfunction-args = format-rust-function-args($parsed.function-args-list);
    my $optionals      = format-option-defaults-initlist($parsed.option-defaults-initlist).chomp.trim;

    my $rclass = 
    $parsed.function-name ?? 
    $parsed.function-name !!
    $user_rclass;

    if $parsed.template-args {

        qq:to/END/;
        impl $rclass \{
            $rcomment
            pub fn new<{$parsed.template-args.join(",")}>({$rfunction-args}) -> Self \{
            {$optionals}
                todo!();
                /*
                {$parsed.field-initializers ?? ":" ~ $parsed.field-initializers>>.gist.join(",") !! ""}
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END

    } else {

        qq:to/END/;
        impl $rclass \{
            $rcomment
            pub fn new({$rfunction-args}) -> Self \{
            {$optionals}
                todo!();
                /*
                {$parsed.field-initializers ?? ":" ~ $parsed.field-initializers>>.gist.join(",") !! ""}
                {$body.trim.chomp.indent(4)}
                */
            \}
        \}
        END
    }
}
