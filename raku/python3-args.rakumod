use python3-prelude;
use pyrust;
use avoid-keywords;
use python3-comprehension;
use indent-rust-named-type-list;

our role Python3::IArgument {}

our class Python3::CommentedArgument does Python3::IArgument {
    has Python3::IArgument $.argument is required;
    has Python3::Comment   @.comments;
}

our class Python3::Argument does Python3::IArgument {
    has Python3::ITest $.test;
}

our class Python3::DefaultArgument does Python3::IArgument {
    has Python3::ITest $.base;
    has Python3::ITest $.default;
}

our class Python3::CompForArgument does Python3::IArgument {
    has Python3::ITest    $.test;
    has Python3::CompFor $.comp-for;
}

our class Python3::ArgList does Python3::ITrailer {
    has Python3::IArgument @.basic-args;
    has Python3::IArgument @.star-args;
    has Python3::IArgument @.kwargs;
    has Str $.text;

    method count( --> Int) {
        [+] [
            @.basic-args,
            @.star-args,
            @.kwargs,
        ].map: {.elems}
    }

    method format-for-decorator {

        sub is-single-string($x) {
            if $x ~~ Python3::Strings {
                so $x.items.elems eq 1
            } else {
                False
            }
        }

        multi sub get-as-str(Python3::Strings $arg)    { $arg.items>>.join("\n") }
        multi sub get-as-str(Python3::ListAtom $arg)   { $arg.text }
        multi sub get-as-str(Python3::ParensAtom $arg) { $arg.text }
        multi sub get-as-str(Python3::Name $arg)       { $arg.value }
        multi sub get-as-str(Python3::True $arg)       { "True" }
        multi sub get-as-str(Python3::False $arg)      { "False" }

        multi sub get-as-str(Python3::OrExpr $arg) { 
            $arg.text
        }

        multi sub double-quoted(Python3::Strings $arg) {
            "\"{$arg.items[0]}\""
        }

        multi sub double-quoted(Python3::ListAtom $arg) {
            "\"{$arg.text}\""
        }

        multi sub double-quoted(Python3::ParensAtom $arg) {
            "\"{$arg.text}\""
        }

        multi sub double-quoted(Python3::AugmentedAtom $arg) {
            "\"{$arg.text}\""
        }

        multi sub double-quoted(Python3::Name $arg) {
            "\"{$arg.value}\""
        }

        multi sub remove-quotes(Python3::Strings $arg) {
            {$arg.items[0]}
        }

        multi sub walk(Python3::IAtom $arg, &fn) {
            &fn($arg)
        }

        multi sub walk(Python3::AugmentedAtom $arg, &fn) {
            &fn($arg)
        }

        multi sub walk(Python3::OrExpr $arg, &fn) {
            walk($arg.operands[0], &fn)
        }

        multi sub walk(Python3::IArgument $arg, &fn) {
            given $arg {
                when Python3::CommentedArgument {
                    walk($arg.argument, &fn)
                }
                when Python3::Argument {
                    walk($arg.test, &fn)
                }
                when Python3::DefaultArgument {
                    walk($arg.base, &fn)
                }
                when Python3::Strings {
                    walk($arg, &fn)
                }
                default {
                    False
                }
            }
        }

        sub maybe-get-default(Python3::IArgument $arg) {

            given $arg {
                when Python3::DefaultArgument {
                    get-as-str($_.default)
                }
                default {
                    Nil
                }
            }
        }

        if @.star-args.elems or @.kwargs.elems {
            die "decorator arglist has unexpected items! possibly rethink this function";
        }

        given @.basic-args.elems {
            when 0 {
                ""
            }
            when 1 {
                my $tag = walk(@.basic-args[0], &double-quoted);
                "= $tag"
            }
            when 2 {
                if walk(@.basic-args[0], &is-single-string) {
                    my $tag    = walk(@.basic-args[0], &remove-quotes);
                    my $target = walk(@.basic-args[1], &double-quoted);
                    "($tag = $target)"
                } else {
                    "(" ~ do for @.basic-args {
                        my $default     = maybe-get-default($_);
                        my $default-tag = $default ?? " = $default" !! "";
                        my $tag         = walk($_, &get-as-str);
                        "$tag$default-tag"
                    }.join(", ") ~ ")"
                }
            }
            when 3 {
                die "impl-me3";
            }
            when 4 {
                die "impl-me4";
            }
            default {
                die "decorator args: handle this case";
            }
        }
    }
}

#-------------------------------------------
our class Python3::Tfpdef {
    has Python3::Name  $.name is required;
    has Python3::ITest $.type;

    method as-rust-name-type(:%typemap, :$default, Bool :$star, Bool :$kw ) {

        my $rust-name = avoid-keywords($.name.value);

        my $mapped-type = %typemap{$rust-name} // Nil;

        if $star {
            return [
                $rust-name,
                "&\[&PyObj\]"
            ];
        }

        if $kw {
            return [
                $rust-name,
                "HashMap<&str,PyObj>"
            ];
        }

        my $type = do if so $.type {

            convert-type-to-rust($.type)

        } else {

            $default 
            ?? pymodel-to-rust-type($default)
            !! 'PyObj'

        };

        #TODO: do we want the mapped-type to
        #override all? which precedence is best?
        if $mapped-type {
            $type = $mapped-type;
        }

        [
            $rust-name,
            $type
        ]
    }

    method as-rust(
        :%typemap, 
        :$default = Nil, 
        :$force-not-default, 
        :$star = False, 
        :$kw = False) {

        my ($name, $type) = self.as-rust-name-type(:%typemap, :$default, :$star, :$kw);
        $default && !$force-not-default
        ??  "$name: Option<$type>"
        !!  "$name: $type"
    }
}

our class Python3::AugmentedTfpdef {

    has Python3::Tfpdef  $.tfpdef is required;
    has Python3::ITest   $.default is required;
    has Python3::Comment @.comments;

    method is-self( --> Bool ) {
        $.tfpdef.name.value eq "self"
    }

    method as-rust( 
        :%typemap, 
        :$no-self           = False, 
        :$force-not-default = False, 
        :$star              = False, 
        :$kw                = False ) 
    {
        if self.is-self() {
            unless :$no-self {
                "&mut self"
            }
        } else {
            $.default
            ?? $.tfpdef.as-rust(:%typemap, :$.default, :$force-not-default, :$star, :$kw)
            !! $.tfpdef.as-rust(:%typemap, default => Nil, :$force-not-default, :$star, :$kw)
        }
    }
}

our class Python3::TypedArgList {
    has Python3::AugmentedTfpdef @.basic-args;
    has Python3::AugmentedTfpdef @.star-args;
    has Python3::Tfpdef          @.kw-args;

    method is-first-parameter-self( --> Bool ) {
        @.basic-args[0].is-self();
    }

    method convert-to-rust(Bool :$no-self = False, :%typemap) {

        my @rust-args = [
            |do for @.basic-args { $_.as-rust(:%typemap, :$no-self) }
            |do for @.star-args  { $_.as-rust(:%typemap, star => True) }
            |do for @.kw-args    { $_.as-rust(:%typemap, kw   => True) }
        ];
        indent-rust-named-type-list(@rust-args)
    }

    method default-get-str($default) {
        my $op0 = $default.operands[0];

        given $op0 {
            when Python3::Strings {
                $op0.items.join("\n")
            }
            default {
                $op0.value
            }
        }
    }

    method optional-initializers(:%typemap) {
        my @result;

        for @.basic-args {

            if $_.default {
                my $default = self.default-get-str($_.default);
                my $name    = $_.tfpdef.name.value;

                @result.push: "let {$_.as-rust(:%typemap, force-not-default => True)} = {$name}.unwrap_or($default);";
            }
        }
        rust-let-statements-align-type(@result).join("\n")
    }

    method count( --> Int ) {
        [+] [
            @.basic-args,
            @.star-args,
            @.kw-args,
        ].map: {.elems}
    }
}
