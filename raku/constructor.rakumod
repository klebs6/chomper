use util;
use snake-case;

our class ConstructorHeader {

    our class FieldInitializer {

        has $.field-name is required;
        has $.initializer is required;

        our sub mock-empty {
            ()
        }

        our sub mock {
            (
                FieldInitializer.new(
                    field-name  => "data",
                    initializer => "0",
                ),
                FieldInitializer.new(
                    field-name  => "rows",
                    initializer => "5",
                ),
            )
        }
        method gist {
            "$!field-name\($!initializer\)"
        }
    }

    has @.template-args;
    has $.function-name;
    has @.function-args-list;
    has @.option-defaults-initlist;
    has @.comments-list;
    has FieldInitializer @.field-initializers;

    our sub mock {
        #we expect this sort of output in this order
        ConstructorHeader.new(
            template-args            => ('Scl', 'T'),
            function-name            => 'MyClass',
            function-args-list       => ('x: i32', 'y: i16'),
            option-defaults-initlist => (),
            comments-list            => ('//here is a comment'),
            field-initializers       => FieldInitializer::mock(),
        )
    }
}

our sub get-rctor-field-initializers(Match $header) {

    #ConstructorHeader::FieldInitializer::mock()

    my $match = $header<constructor-initializers>;

    if $match {
        do for $match<constructor-initializer>.List {
            ConstructorHeader::FieldInitializer.new(
                field-name  => snake-case($_<field-name>.Str),
                initializer => $_<field-body>,
            )
        }
    } else {
        ConstructorHeader::FieldInitializer::mock-empty()
    }
}

our sub translate-ctor($submatch, $body, $user_rclass) {

    my $parsed = ConstructorHeader.new(
        template-args            => get-template-args($submatch) // (),
        function-name            => get-rctor-function-name($submatch),
        function-args-list       => get-rfunction-args-list($submatch<parenthesized-args>),
        option-defaults-initlist => get-option-defaults-initlist($submatch<parenthesized-args>),
        comments-list            => get-rcomments-list($submatch),
        field-initializers       => get-rctor-field-initializers($submatch),
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
