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

    method count( --> Int) {
        [+] [
            @.basic-args,
            @.star-args,
            @.kwargs,
        ].map: {.elems}
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
        do for @.basic-args {

            if $_.default {
                my $default = self.default-get-str($_.default);
                my $name    = $_.tfpdef.name.value;

                "let {$_.as-rust(:%typemap, force-not-default => True)} = {$name}.unwrap_or($default);"
            }
        }
    }

    method count( --> Int ) {
        [+] [
            @.basic-args,
            @.star-args,
            @.kw-args,
        ].map: {.elems}
    }
}
