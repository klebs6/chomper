use python3-args;
use python3-class;
use python3-comment;
use python3-compound;
use python3-comprehension;
use python3-dunder-init;
use python3-dunder;
use python3-expr;
use python3-func;
use python3-lambdef;
use python3-prelude;
use python3-stmt;
use python3-suite;
use python3-varargs;

our sub get-compound-comments($/) {

    my $comments = $<COMMENT>>>.made;
    my $last     = $<COMMENT_NONEWLINE>.made;

    if $last {
        $comments.push: $last
    }

    $comments.List
}

our sub is-test-fn-name($name) {
    my $fn-name = $name.value.subst(:g, /^_/, "");
    $fn-name.starts-with("test")
}


our role Python3::NumberActions {
    method number:sym<integer>($/) { make Python3::Integer.new(value => $/.Str ) }
    method number:sym<float>($/)   { make Python3::Float.new(value => $/.Str ) }
    method number:sym<imag>($/)    { make Python3::Imaginary.new(value => $/.Str ) }
}

our role Python3::DecoratorActions {

    method compound-stmt:sym<decorated>($/) {
        my $item = $<decorated-item>.made;
        given $item {
            when Python3::Classdef {
                make Python3::DecoratedClass.new(
                    decorators => $<decorators>.made,
                    decorated  => $item
                )
            }
            when Python3::FuncDef {
                make Python3::DecoratedFunction.new(
                    decorators => $<decorators>.made,
                    decorated  => $item
                )
            }
        }
    }

    method decorators($/) {
        make $<decorator>>>.made
    }

    method at-dotted-name($/) {
        make $<dotted-name>.made
    }

    method decorator($/) {
        make Python3::Decorator.new(
            name    => $<at-dotted-name>.made,
            comment => $<COMMENT_NONEWLINE>.made // Nil,
            arglist => $<parenthesized-arglist>.made // Nil,
        )
    }

    method decorated-item:sym<class>($/) {
        make $<classdef>.made
    }

    method decorated-item:sym<func>($/) {
        make $<funcdef>.made
    }
}

our role Python3::IfStmtActions {

    method compound-stmt:sym<if>($/) {
        make Python3::If.new(
            test        => $<test>.made,
            comment     => $<COMMENT_NONEWLINE>.made // Nil,
            suite       => $<suite>.made,
            elif-suites => $<elif-suite>>>.made,
            else-suite  => $<else-suite>.made // Nil,
        )
    }

    method elif-suite($/) {
        make Python3::Elif.new(
            comments => get-compound-comments($/),
            test     => $<test>.made,
            suite    => $<suite>.made,
        )
    }
}

our role Python3::ElseActions {

    method else-suite($/) {
        my $comments = get-compound-comments($/);
        make Python3::Else.new(
            comments => $comments,
            suite    => $<suite>.made,
        )
    }
}

our role Python3::CompoundStmtActions {

    method compound-stmt:sym<while>($/) {
        my $comment = $<COMMENT_NONEWLINE>.made // Nil;
        make Python3::While.new(
            test     => $<test>.made,
            comments => $comment ?? [$comment] !! [],
            suite    => $<suite>.made,
            else     => $<else-suite>.made // Nil,
        )
    }

    method compound-stmt:sym<for>($/) {
        make Python3::For.new(
            exprlist    => $<exprlist>.made,
            testlist    => $<testlist>.made,
            comment     => $<COMMENT_NONEWLINE>.made // Nil,
            suite       => $<suite>.made,
            else        => $<else-suite>.made // Nil,
        )
    }
}

our role Python3::TryStmtActions {

    method compound-stmt:sym<try>($/) {
        make Python3::Try.new(
            comment        => $/<COMMENT_NONEWLINE>.made // Nil,
            suite          => $<suite>.made,
            control-suite  => $<try-control-suite>.made,
        )
    }

    method try-control-suite:sym<full>($/) {
        make $<except-suite>.made
    }

    method try-control-suite:sym<finally>($/) {
        make $<finally>.made
    }

    method except-suite($/) {
        make Python3::ExceptSuite.new(
            comments  => $<COMMENT>>>.made,
            clauses   => $<except-clause>>>.made,
            else      => $<else-suite>.made // Nil,
            finally   => $<finally>.made // Nil,
        )
    }

    method except-clause($/) {
        make Python3::ExceptClause.new(
            comments       => get-compound-comments($/),
            suite          => $<suite>.made,
        )
    }

    method finally($/) {
        make Python3::Finally.new(
            comments       => [|$<COMMENT>>>.made, $<COMMENT_NONEWLINE>.made // Nil],
            suite          => $<suite>.made
        )
    }
}

our role Python3::WithStmtActions {

    method compound-stmt:sym<with>($/) {
        make Python3::With.new(
            comments   => get-compound-comments($/),
            with-items => $<with-item>>>.made,
            suite      => $<suite>.made,
        )
    }

    method with-item:sym<basic>($/) {
        make Python3::WithItemBasic.new(
            test => $<test>.made,
        )
    }

    method with-item:sym<as>($/) {
        make Python3::WithItemAs.new(
            test => $<test>.made,
            or-expr => $<expr>.made,
        )
    }
}

our role Python3::StmtActions {

    method stmt:sym<compound>($/) {
        make $<compound-stmt>.made;
    }

    method stmt:sym<simple>($/) {
        make $<simple-suite>.made;
    }

    method stmt:sym<comment>($/) {
        make $<COMMENT_NONEWLINE>.made;
    }
}

our role Python3::StringActions {

    method strings($/) {
        make Python3::Strings.new( items => $<string>>>.made )
    }

    method string:sym<long-string>($/)  { make $<long-string>.made }
    method string:sym<short-string>($/) { make $<short-string>.made }
    method string:sym<long-bytes>($/)   { make $<long-bytes>.made }
    method string:sym<short-bytes>($/)  { make $<short-bytes>.made }

    method long-string($/)  { make $<LONG_STRING>.made }
    method short-string($/) { make $<SHORT_STRING>.made }
    method long-bytes($/)   { make $<LONG_BYTES>.made }
    method short-bytes($/)  { make $<SHORT_BYTES>.made }

    method LONG_STRING:sym<single>($/)  { make $<SINGLE_QUOTED_LONG_STRING>.made  }
    method LONG_STRING:sym<double>($/)  { make $<DOUBLE_QUOTED_LONG_STRING>.made  }
    method SHORT_STRING:sym<single>($/) { make $<SINGLE_QUOTED_SHORT_STRING>.made }
    method SHORT_STRING:sym<double>($/) { make $<DOUBLE_QUOTED_SHORT_STRING>.made }
    method LONG_BYTES:sym<single>($/)   { make $<SINGLE_QUOTED_LONG_BYTES>.made   }
    method LONG_BYTES:sym<double>($/)   { make $<DOUBLE_QUOTED_LONG_BYTES>.made   }
    method SHORT_BYTES:sym<single>($/)  { make $<SINGLE_QUOTED_SHORT_BYTES>.made  }
    method SHORT_BYTES:sym<double>($/)  { make $<DOUBLE_QUOTED_SHORT_BYTES>.made  }

    #-------
    method DOUBLE_QUOTED_LONG_STRING($/) { make $<DOUBLE_QUOTED_LONG_STRING_INNER>.made }
    method SINGLE_QUOTED_LONG_STRING($/) { make $<SINGLE_QUOTED_LONG_STRING_INNER>.made }

    method DOUBLE_QUOTED_LONG_STRING_INNER($/) { make $/.Str }
    method SINGLE_QUOTED_LONG_STRING_INNER($/) { make $/.Str }

    method DOUBLE_QUOTED_SHORT_STRING($/) { make $<DOUBLE_QUOTED_SHORT_STRING_INNER>.Str }
    method SINGLE_QUOTED_SHORT_STRING($/) { make $<SINGLE_QUOTED_SHORT_STRING_INNER>.Str }

    method DOUBLE_QUOTED_SHORT_STRING_INNER($/) { make $/.Str }
    method SINGLE_QUOTED_SHORT_STRING_INNER($/) { make $/.Str }

    #-------
    method DOUBLE_QUOTED_LONG_BYTES($/) { make $<LONG_BYTES_INNER>.Str }
    method SINGLE_QUOTED_LONG_BYTES($/) { make $<LONG_BYTES_INNER>.Str }
    method LONG_BYTES_INNER($/) { make $/.Str }

    method DOUBLE_QUOTED_SHORT_BYTES($/) { make $<DOUBLE_QUOTED_SHORT_BYTES_INNER>.Str }
    method SINGLE_QUOTED_SHORT_BYTES($/) { make $<SINGLE_QUOTED_SHORT_BYTES_INNER>.Str }
    method DOUBLE_QUOTED_SHORT_BYTES_INNER($/) { make $/.Str }
    method SINGLE_QUOTED_SHORT_BYTES_INNER($/) { make $/.Str }
}

our role Python3::CompActions {

    method comp-iter:sym<for>($/) {
        make $<comp-for>.made
    }

    method comp-iter:sym<if>($/) {
        make $<comp-if>.made
    }

    method comp-for($/) {
        make Python3::CompFor.new(
            exprlist  => $<exprlist>.made,
            or-test   => $<or-test>.made,
            comp-iter => $<comp-iter>.made // Nil,
        )
    }

    method comp-if($/) {
        make Python3::CompIf.new(
            test-nocond  => $<test-nocond>.made,
            comp-iter    => $<comp-iter>.made // Nil,
        )
    }

}

our role Python3::AtomActions does Python3::StringActions {

    method atom:sym<strings>($/) { 
        make $<strings>.made 
    }

    method atom:sym<NONE>($/)    { make Python3::None.new }
    method atom:sym<true>($/)    { make Python3::True.new }
    method atom:sym<false>($/)   { make Python3::False.new }
    method atom:sym<NAME>($/)    { make $<NAME>.made }

    method atom:sym<parens>($/)  { 
        make Python3::ParensAtom.new(
            value    => $<parens-inner>.made,
            comments => $<COMMENT>>>.made,
        )
    }

    method parens-inner:sym<yield>($/) {
        make $<yield-expr>.made
    }

    method parens-inner:sym<listmaker>($/) {
        make $<listmaker>.made
    }

    method atom:sym<list>($/)  { 
        make Python3::ListAtom.new(
            value    => $<listmaker>.made,
            comments => $<COMMENT>>>.made,
        )
    }

    method test-comma-maybe-comment($/) {
        make Python3::MaybeCommentedTest.new(
            test    => $<test>.made,
            comments => $<comma-maybe-comment>.made,
        )
    }

    method listmaker:sym<testlist>($/) {
        my $final-comments = $<comma-maybe-comment>.made // Nil;

        make Python3::TestList.new(
            tests => [
                |$<test-comma-maybe-comment>>>.made,
                Python3::MaybeCommentedTest.new(
                    test => $<test>.made,
                    comment => $final-comments ?? $final-comments.List !! [],
                )
            ]
        )
    }

    method listmaker:sym<list-comp>($/) {
        make Python3::ListComp.new(
            test => $<test>.made,
            comp => $<comp-for>.made,
        )
    }

    method atom:sym<dict>($/)  { 
        make Python3::DictAtom.new(
            value    => $<dictorsetmaker>.made,
            comments => $<COMMENT>>>.made,
        )
    }

    method dictorsetmaker:sym<dict>($/) {
        make Python3::Dict.new(
            items => [
                |$<dictmaker-item-comma-maybe-comment>>>.made,
                Python3::DictMakerItem.new(
                    comments => $<comma-maybe-comment>.made // Nil, 
                    K        => $<dictmaker-item><test>[0].made,
                    V        => $<dictmaker-item><test>[1].made,
                )
            ]
        )
    }

    method dictorsetmaker:sym<dict-comp>($/) {
        make Python3::DictComp.new(
            item => $<dictmaker-item>.made,
            comp => $<comp-for>.made,
        )
    }

    method dictmaker-item($/) {
        my $comment = $<COMMENT>.made // Nil;
        make Python3::DictMakerItem.new(
            comments => $comment ?? [$comment] !! [], 
            K        => $<test>[0].made,
            V        => $<test>[1].made,
        )
    }

    method dictmaker-item-comma-maybe-comment($/) {
        make Python3::DictMakerItem.new(
            comments => [
                $<dictmaker-item><COMMENT>.made // Nil, 
                |$<comment-maybe-comment>.made
            ],
            K       => $<dictmaker-item><test>[0].made,
            V       => $<dictmaker-item><test>[1].made,
        )
    }

    method setmaker-item:sym<test>($/) {
        my $comment = $<COMMENT>.made // Nil;

        make Python3::SetMakerItem.new(
            has-stars => False,
            comments  => $comment ?? [$comment] !! [], 
            K         => $<test>.made,
        )
    }

    method setmaker-item:sym<stars-test>($/) {
        make Python3::SetMakerItem.new(
            has-stars => True,
            comments  => [$<COMMENT>.made // Nil], 
            K         => $<test>.made,
        )
    }

    method setmaker-item-comma-maybe-comment($/) {
        make Python3::SetMakerItem.new(
            comments => [
                $<setmaker-item><COMMENT>.made // Nil, 
                |$<comment-maybe-comment>.made
            ],
            K  => $<setmaker-item><test>.made,
        )
    }

    method dictorsetmaker:sym<set>($/) {
        make Python3::Set.new(
            items => [
                |$<setmaker-item-comma-maybe-comment>>>.made,
                $<setmaker-item>.made
            ]
        )
    }

    method dictorsetmaker:sym<set-with-comma-trailer>($/) {
        make Python3::Set.new(
            items => $<setmaker-item-comma-maybe-comment>>>.made,
        )
    }

    method dictorsetmaker:sym<set-comp>($/) {
        make Python3::SetComp.new(
            item => $<setmaker-item>.made,
            comp => $<comp-for>.made,
        )
    }

    method atom:sym<number>($/)  { 
        make $<number>.made
    }

    method atom:sym<ellipsis>($/)  { 
        make Python3::Ellipsis.new
    }
}

our role Python3::CommentActions {

    method comment-newline($/) {
        make $<COMMENT_NONEWLINE>.made
    }

    method comma-maybe-comment($/) {
        make $/<COMMENT>>>.made
    }

    method COMMENT_NONEWLINE($/) {
        make Python3::Comment.new(
            text => $/.Str
        )
    }

    method COMMENT($/) {
        make $<COMMENT_NONEWLINE>.made
    }
}

our role Python3::FunctionActions {

    method compound-stmt:sym<func>($/) {
        make $<funcdef>.made
    }

    method funcdef($/) {

        my $name = $<NAME>.made;

        my $key = $name.value.chomp.trim;

        my %dunder-map = %(

            __abs__           => Python3::DunderFunc::Abs,
            __add__           => Python3::DunderFunc::Add,
            __and__           => Python3::DunderFunc::And,
            __call__          => Python3::DunderFunc::Call,
            __cmp__           => Python3::DunderFunc::Cmp,
            __coerce__        => Python3::DunderFunc::Coerce,
            __complex__       => Python3::DunderFunc::Complex,
            __contains__      => Python3::DunderFunc::Contains,
            __del__           => Python3::DunderFunc::Del,
            __delattr__       => Python3::DunderFunc::Delattr,
            __delete__        => Python3::DunderFunc::Delete,
            __delitem__       => Python3::DunderFunc::Delitem,
            __delslice__      => Python3::DunderFunc::Delslice,
            __div__           => Python3::DunderFunc::Div,
            __divmod__        => Python3::DunderFunc::Divmod,
            __enter__         => Python3::DunderFunc::Enter,
            __eq__            => Python3::DunderFunc::Eq,
            __exit__          => Python3::DunderFunc::Exit,
            __float__         => Python3::DunderFunc::Float,
            __floordiv__      => Python3::DunderFunc::Floordiv,
            __ge__            => Python3::DunderFunc::Ge,
            __get__           => Python3::DunderFunc::Get,
            __getattr__       => Python3::DunderFunc::Getattr,
            __getattribute__  => Python3::DunderFunc::Getattribute,
            __getitem__       => Python3::DunderFunc::Getitem,
            __getslice__      => Python3::DunderFunc::Getslice,
            __gt__            => Python3::DunderFunc::Gt,
            __hash__          => Python3::DunderFunc::Hash,
            __hex__           => Python3::DunderFunc::Hex,
            __iadd__          => Python3::DunderFunc::Iadd,
            __iand__          => Python3::DunderFunc::Iand,
            __idiv__          => Python3::DunderFunc::Idiv,
            __idivmod__       => Python3::DunderFunc::Idivmod,
            __ifloordiv__     => Python3::DunderFunc::Ifloordiv,
            __ilshift__       => Python3::DunderFunc::Ilshift,
            __imod__          => Python3::DunderFunc::Imod,
            __imul__          => Python3::DunderFunc::Imul,
            __index__         => Python3::DunderFunc::Index,
            __init__          => Python3::DunderFunc::Init,
            __instancecheck__ => Python3::DunderFunc::Instancecheck,
            __int__           => Python3::DunderFunc::Int,
            __invert__        => Python3::DunderFunc::Invert,
            __ior__           => Python3::DunderFunc::Ior,
            __ipow__          => Python3::DunderFunc::Ipow,
            __irshift__       => Python3::DunderFunc::Irshift,
            __isub__          => Python3::DunderFunc::Isub,
            __iter__          => Python3::DunderFunc::Iter,
            __itruediv__      => Python3::DunderFunc::Itruediv,
            __ixor__          => Python3::DunderFunc::Ixor,
            __le__            => Python3::DunderFunc::Le,
            __len__           => Python3::DunderFunc::Len,
            __long__          => Python3::DunderFunc::Long,
            __lshift__        => Python3::DunderFunc::Lshift,
            __lt__            => Python3::DunderFunc::Lt,
            __metaclass__     => Python3::DunderFunc::Metaclass,
            __missing__       => Python3::DunderFunc::Missing,
            __mod__           => Python3::DunderFunc::Mod,
            __mul__           => Python3::DunderFunc::Mul,
            __ne__            => Python3::DunderFunc::Ne,
            __neg__           => Python3::DunderFunc::Neg,
            __nonzero__       => Python3::DunderFunc::Nonzero,
            __oct__           => Python3::DunderFunc::Oct,
            __or__            => Python3::DunderFunc::Or,
            __pos__           => Python3::DunderFunc::Pos,
            __pow__           => Python3::DunderFunc::Pow,
            __radd__          => Python3::DunderFunc::Radd,
            __rand__          => Python3::DunderFunc::Rand,
            __rcmp__          => Python3::DunderFunc::Rcmp,
            __rdiv__          => Python3::DunderFunc::Rdiv,
            __rdivmod__       => Python3::DunderFunc::Rdivmod,
            __repr__          => Python3::DunderFunc::Repr,
            __reversed__      => Python3::DunderFunc::Reversed,
            __rfloordiv__     => Python3::DunderFunc::Rfloordiv,
            __rlshift__       => Python3::DunderFunc::Rlshift,
            __rmod__          => Python3::DunderFunc::Rmod,
            __rmul__          => Python3::DunderFunc::Rmul,
            __ror__           => Python3::DunderFunc::Ror,
            __rpow__          => Python3::DunderFunc::Rpow,
            __rrshift__       => Python3::DunderFunc::Rrshift,
            __rshift__        => Python3::DunderFunc::Rshift,
            __rsub__          => Python3::DunderFunc::Rsub,
            __rtruediv__      => Python3::DunderFunc::Rtruediv,
            __rxor__          => Python3::DunderFunc::Rxor,
            __set__           => Python3::DunderFunc::Set,
            __setattr__       => Python3::DunderFunc::Setattr,
            __setitem__       => Python3::DunderFunc::Setitem,
            __setslice__      => Python3::DunderFunc::Setslice,
            __str__           => Python3::DunderFunc::Str,
            __sub__           => Python3::DunderFunc::Sub,
            __subclasscheck__ => Python3::DunderFunc::Subclasscheck,
            __truediv__       => Python3::DunderFunc::Truediv,
            __unicode__       => Python3::DunderFunc::Unicode,
            __xor__           => Python3::DunderFunc::Xor,
        );

        my $exists = $key (<) %dunder-map.keys;

        my $cls = $exists ?? %dunder-map{$name.value} !! Python3::FuncDef;

        make $cls.new(
            name       => $name,
            private    => $name.value.starts-with("_"),
            is-test    => is-test-fn-name($name),
            parameters => $<parameters>.made,
            test       => $<test> // Nil,
            suite      => $<suite>.made
        )
    }

    method parameters($/) {
        make $/<parenthesized-typedarglist>.made
    }

    method parenthesized-typedarglist($/) {
        make $/<typedargslist>.made // Nil
    }

    method typedargslist-kwargs($/) {
        make [ $<tfpdef>.made ]
    }

    method typedargslist:sym<full>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args>.made,
            star-args  => $<star-args>.made,
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method typedargslist:sym<just-star-args>($/) {
        make Python3::TypedArgList.new(
            basic-args => [],
            star-args  => $<star-args>.made,
            kw-args    => [],
        )
    }

    method typedargslist:sym<just-kwargs>($/) {
        make Python3::TypedArgList.new(
            basic-args => [],
            star-args  => [],
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method typedargslist:sym<just-basic>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args>.made,
            star-args  => [],
            kw-args    => [],
        )
    }

    method typedargslist:sym<basic-and-star-args>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args>.made,
            star-args  => $<star-args>.made,
            kw-args    => [],
        )
    }

    method typedargslist:sym<basic-and-kwargs>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args>.made,
            star-args  => [],
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method typedargslist:sym<star-and-kwargs>($/) {
        make Python3::TypedArgList.new(
            basic-args => [],
            star-args  => $<star-args>.made,
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method augmented-tfpdef($/) {
        make Python3::AugmentedTfpdef.new(
            tfpdef  => $<tfpdef>.made,
            default => $<test>.made // Nil,
        )
    }

    method augmented-tfpdef-comma-maybe-comment($/) {
        my $item = $<augmented-tfpdef>.made;
        $item.comments = $<COMMENT>>>.made;
        make $item
    }

    method just-basic-args($/) {
        my $final = $<augmented-tfpdef>.made;
        $final.comments = $<comment-maybe-comment>.made // [];

        make [ 
            |$<augmented-tfpdef-comma-maybe-comment>>>.made, 
            $final
        ]
    }

    method star-args($/) {

        my $first = $<tfpdef>.made // Nil;

        make do if $first {
            [ 
                Python3::AugmentedTfpdef.new(
                    tfpdef  => $first, 
                    default => Nil,
                ),
                |$<augmented-tfpdef>>>.made 
            ]

        } else {
            $<augmented-tfpdef>>>.made 
        }
    }

    method kwargs($/) {
        make $<tfpdef>.made,
    }

    method tfpdef($/) {
        make Python3::Tfpdef.new(
            name => $<NAME>.made,
            type => $<test>.made // Nil,
        )
    }
}

our role Python3::ArgListActions {

    method parenthesized-arglist($/) {
        make $<arglist>.made // Nil
    }

    method argument-comma-maybe-comment($/) {

        my $maybe-comment = $<comma-maybe-comment>.made;

        if $maybe-comment {
            make Python3::CommentedArgument.new(
                argument => $<argument>.made,
                comments => $<comma-maybe-comment>.made,
            )

        } else {
            make $<argument>.made
        }
    }

    method argument:sym<test>($/) {
        make Python3::DefaultArgument.new(
            base    => $<test>[0].made,
            default => $<test>[1].made,
        )
    }

    method argument:sym<comp-for>($/) {
        my $comp-for = $<comp-for>.made;
        if $comp-for {
            make Python3::CompForArgument.new(
                test     => $<test>.made,
                comp-for => $<comp-for>.made,
            )
        } else {
            make Python3::Argument.new(
                test => $<test>.made,
            )
        }
    }

    method arglist:sym<just-basic>($/) {
        make Python3::ArgList.new(
            basic-args => [
                |$<argument-comma-maybe-comment>>>.made,
                $<argument>.made
            ],
            star-args => [],
            kwargs    => [],
        )
    }

    method arglist:sym<just-basic-with-trailing-comment>($/) {
        make Python3::ArgList.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args => [],
            kwargs    => [],
        )
    }

    method arglist:sym<just-star-args>($/) {
        make Python3::ArgList.new(
            basic-args => [],
            star-args => [ Python3::Argument.new(test => $<test>.made) ],
            kwargs    => [],
        )
    }

    method arglist:sym<just-star-args2>($/) {
        make Python3::ArgList.new(
            basic-args => [],
            star-args => [
                $<test-comma-maybe-comment>.made, 
                |$<argument-comma-maybe-comment>>>.made,
                $<argument>.made
            ],
            kwargs    => [],
        )
    }

    method arglist:sym<just-kwargs>($/) {
        make Python3::ArgList.new(
            basic-args => [],
            star-args  => [],
            kwargs     => $<arglist-kwargs>.made,
        )
    }

    method arglist:sym<basic-and-star-arg>($/) {
        make Python3::ArgList.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [ $<star-arg>.made ],
            kwargs     => [],
        )
    }

    method arglist-kwargs($/) {
        make $<test>.made
    }

    method star-arg($/) {
        make $<test>.made
    }

    method arglist:sym<basic-and-star-arg-with-trailing-comma>($/) {
        make Python3::ArgList.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [ $<test-comma-maybe-comment>.made ],
            kwargs     => [],
        )
    }

    method arglist:sym<basic-and-star-args>($/) {
        make Python3::ArgList.new(
            basic-args => $<basic>>>.made,
            star-args  => [ 
                $<test-comma-maybe-comment>.made,
                $<star>>>.made
            ],
            kwargs     => [],
        )
    }

    method arglist:sym<basic-and-kwargs>($/) {
        make Python3::ArgList.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [],
            kwargs     => $<arglist-kwargs>.made,
        )
    }


    method arglist:sym<star-and-kwargs2>($/) {
        make Python3::ArgList.new(
            basic-args => [],
            star-args  => Python3::Argument.new(
                test => $<star-arg>.made
            ),
            kwargs     => Python3::Argument.new(
                test => $<arglist-kwargs>.made
            ),
        )
    }

    method arglist:sym<star-and-kwargs>($/) {
        make Python3::ArgList.new(
            basic-args => [],
            star-args  => [$<test-comma-maybe-comment>.made, |$<argument-comma-maybe-comment>>>.made],
            kwargs     => $<arglist-kwargs>.made,
        )
    }

    method arglist:sym<full>($/) {
        make Python3::ArgList.new(
            basic-args => $<basic>.made,
            star-args  => [$<test-comma-maybe-comment>.made, |$<star>>>.made],
            kwargs     => $<arglist-kwargs>.made,
        )
    }
}

our role Python3::ClassdefActions {

    method compound-stmt:sym<class>($/) {
        make $<classdef>.made
    }

    method classdef($/) {
        make Python3::Classdef.new(
            name    => $<NAME>.made,
            arglist => $<parenthesized-arglist>.made // Nil,
            comment => $<COMMENT_NONEWLINE>.made      // Nil,
            suite   => $<suite>.made,
        )
    }
}

our role Python3::VarArgsListActions {

    method vfpdef-maybe-test($/) {
        make Python3::VfpDef.new(
            name => $<vfpdef>.made.name,
            test => $<test>.made // Nil,
        )
    }

    method varargslist-basic($/) {
        make $<vfpdef-maybe-test>>>.made
    }

    method varargslist-star-args($/) {
        make [
            $<vfpdef>.made // Nil,
            |$<vfpdef-maybe-test>>>.made
        ]
    }

    method varargslist-kwargs($/) {
        make $<vfpdef>.made
    }

    method vfpdef($/) {
        make Python3::VfpDef.new(
            name => $<NAME>.made,
        )
    }

    method varargslist:sym<full>($/) {
        make Python3::VarArgsList.new(
            basic     => $<varargslist-basic>.made,
            star-args => $<varargslist-star-args>.made,
            kwargs    => $<varargslist-kwargs>.made,
        )
    }

    method varargslist:sym<just-basic>($/) {
        make Python3::VarArgsList.new(
            basic     => $<varargslist-basic>.made,
        )
    }

    method varargslist:sym<just-star-args>($/) {
        make Python3::VarArgsList.new(
            star-args => $<varargslist-star-args>.made,
        )
    }

    method varargslist:sym<just-kwargs>($/) {
        make Python3::VarArgsList.new(
            kwargs    => $<varargslist-kwargs>.made,
        )
    }

    method varargslist:sym<basic-and-star-args>($/) {
        make Python3::VarArgsList.new(
            basic     => $<varargslist-basic>.made,
            star-args => $<varargslist-star-args>.made,
        )
    }

    method varargslist:sym<basic-and-kwargs>($/) {
        make Python3::VarArgsList.new(
            basic     => $<varargslist-basic>.made,
            kwargs    => $<varargslist-kwargs>.made,
        )
    }

    method varargslist:sym<star-and-kwargs>($/) {
        make Python3::VarArgsList.new(
            star-args => $<varargslist-star-args>.made,
            kwargs    => $<varargslist-kwargs>.made,
        )
    }
}

our role Python3::FileInputActions {

    method file-input($/) {
        make $<file-input-item>>>.made
    }

    method file-input-item:sym<comment-newline>($/) {
        make $<comment-newline>.made;
    }

    method file-input-item:sym<stmt>($/) {
        make $<stmt>.made;
    }
}

our role Python3::SmallStmtActions {

    method expr-augassign-rhs:sym<yield>($/) {
        make $<yield>.made
    }

    method expr-augassign-rhs:sym<testlist>($/) {
        make $<testlist>.made
    }

    method testlist($/) {
        make Python3::TestList.new(
            tests => $<test>>>.made
        )
    }

    method small-stmt:sym<expr-augassign>($/) {
        make Python3::ExprAugAssign.new(
            lhs  => $<testlist-star-expr>.made,
            op   => $<augassign>.made,
            rhs  => $<expr-augassign-rhs>.made,
            text => $/.Str,
        )
    }

    method small-stmt:sym<expr-equals>($/) {
        my $rhs = $<expr-equals-rhs>>>.made;
        make Python3::ExprEquals.new(
            lhs       => $<testlist-star-expr>.made,
            rhs-stack => $rhs,
            text      => $/.Str,
        )
    }

    method small-stmt:sym<return>($/) {
        make Python3::Return.new(
            testlist => $<testlist>.made // Nil,
            text     => $/.Str,
        )
    }

    method small-stmt:sym<raise>($/) {
        make Python3::Raise.new(
            clause => $<raise-clause>.made // Nil,
            text   => $/.Str,
        )
    }


    method small-stmt:sym<import-name>($/) {
        make Python3::ImportName.new(
            names => $<dotted-as-names>.made,
            text  => $/.Str,
        )
    }

    method small-stmt:sym<nonlocal>($/) {
        make Python3::Nonlocal.new(
            names => $/<NAME>>>.made,
            text  => $/.Str,
        )
    }

    method small-stmt:sym<assert>($/) {
        make Python3::Assert.new(
            tests => $/<test>>>.made,
            text  => $/.Str,
        )
    }

    method small-stmt:sym<pass>($/) {
        make Python3::Pass.new
    }

    method small-stmt:sym<break>($/) {
        make Python3::Break.new
    }

    method small-stmt:sym<continue>($/) {
        make Python3::Continue.new
    }

    method small-stmt:sym<yield>($/) {
        make Python3::Yield.new(
            expr => $<yield-expr>.made,
            text => $/.Str,
        )
    }

    method small-stmt:sym<import-from>($/) {
        make $<import-from>.made
    }

    method small-stmt:sym<global>($/) {
        make Python3::Global.new(
            names => $<NAME>>>.made,
            text  => $/.Str,
        )
    }

    method small-stmt:sym<del>($/) {
        make Python3::Del.new(
            exprs => $<exprlist>.made,
            text  => $/.Str,
        )
    }
}

our role Python3::SuiteActions {

    method suite:sym<simple>($/) {
        make $/<simple-suite>.made
    }

    method suite:sym<stmt>($/) {
        make $/<stmt-suite>.made
    }

    method stmt-suite($/) {
        make Python3::StmtSuite.new(
            stmts => $/<stmt-maybe-comments>>>.made,
            text  => $/.Str,
        )
    }

    method simple-suite($/) {
        make Python3::SimpleSuite.new(
            stmts   => $<simple-stmt>.made,
            comment => $<COMMENT>.made // Nil,
            text    => $/.Str,
        )
    }
}

our role Python3::ToRustActions 
does Python3::FileInputActions 
does Python3::SmallStmtActions 
does Python3::SuiteActions 
does Python3::NumberActions 
does Python3::DecoratorActions 
does Python3::IfStmtActions 
does Python3::ElseActions 
does Python3::CompoundStmtActions 
does Python3::TryStmtActions 
does Python3::WithStmtActions 
does Python3::StmtActions 
does Python3::AtomActions 
does Python3::CommentActions 
does Python3::FunctionActions 
does Python3::ClassdefActions 
does Python3::CompActions 
does Python3::ArgListActions 
does Python3::StringActions 
does Python3::VarArgsListActions 
{
    method TOP ($/) {
        make $<file-input>.made
    }

    method NAME($/) {
        make Python3::Name.new(value => $/.Str)
    }

    method stmt-maybe-comments($/) {
        make Python3::StmtWithComments.new(
            stmt     => $<stmt>.made,
            comments => $<COMMENT>>>.made,
            text     => $/.Str,
        )
    }

    method simple-stmt($/) {
        make $/<small-stmt>>>.made
    }

    method augassign($/) {
        make $/.Str
    }

    method expr-equals-rhs:sym<yield>($/) {
        make $<yield-expr>.made
    }

    method expr-equals-rhs:sym<testlist-star-expr>($/) {
        make $<testlist-star-expr>.made
    }

    method yield-expr($/) {
        make Python3::YieldExpr.new(
            arg => $<yield-arg>.made // Nil,
        )
    }

    method yield-arg:sym<from>($/) {
        make Python3::YieldArg.new(
            from => $<test>.made,
        )
    }

    method yield-arg:sym<testlist>($/) {
        make Python3::YieldArg.new(
            testlist => $<testlist>.made,
        )
    }

    method testlist-star-expr($/) {
        if $/<test-or-star-expr>.List.elems gt 1 {
            make Python3::TestListStarExpr.new(
                test-or-star-exprs => $<test-or-star-expr>>>.made,
            )
        } else {
            make $<test-or-star-expr>[0].made
        }
    }

    method test-or-star-expr:sym<test>($/) {
        make $<test>.made
    }

    method test-or-star-expr:sym<star-expr>($/) {
        make $<star-expr>.made
    }


    method raise-clause($/) {
        my $tests = $<test>>>.made;
        make Python3::RaiseClause.new(
            test => $tests[0],
            from => $tests[1] // Nil,
        )
    }

    method dotted-as-names($/) {
        make $<dotted-as-name>>>.made
    }

    method dotted-as-name($/) {
        make Python3::DottedAsName.new(
            name => $<dotted-name>.made,
            as   => $<NAME>.made // Nil,
        )
    }

    method dotted-name($/) {
        make Python3::DottedName.new(
            names => $<NAME>>>.made
        )
    }


    method import-from($/) {
        make Python3::ImportFrom.new(
            src    => $<import-from-src>.made,
            target => $<import-from-target>.made,
            text   => $/.Str,
        )
    }

    method import-from-src($/) {
        make Python3::ImportFromSrc.new(
            dot-stack => $<import-dots>>>.made,
            name      => $<dotted-name>.made // Nil,
        )
    }

    method import-dots:sym<dot>($/) {
        make Python3::ImportDots.new(
            plural => False,
        )
    }

    method import-dots:sym<dots>($/) {
        make Python3::ImportDots.new(
            plural => True,
        )
    }

    method import-from-target:sym<*>($/) {
        make Python3::ImportFromTarget.new(
            glob => True,
        )
    }

    method import-from-target:sym<parenthesized-import-as-names>($/) {
        make Python3::ImportFromTarget.new(
            glob    => False,
            comment => $<parenthesized-import-as-names><COMMENT_NONEWLINE>.made // Nil,
            names   => $<parenthesized-import-as-names><import-as-names>>>.made // Nil,
        )
    }

    method import-from-target:sym<import-as-names>($/) {
        make Python3::ImportFromTarget.new(
            glob    => False,
            comment => Nil,
            names   => $<import-as-names>>>.made // Nil,
        )
    }

    method import-as-names($/) {
        make $<import-as-name>>>.made
    }

    method import-as-name($/) {
        make Python3::ImportAsName.new(
            name => $<NAME>[0].made,
            as   => $<NAME>[1] ?? $<NAME>[1].made !! Nil,
        )
    }

    method exprlist($/) {
        make Python3::ExprList.new(
            items => $<star-expr>>>.made
        )
    }

    #----------------------------------
    method test:sym<basic>($/) {
        make $<or-test>.made
    }

    method or-test($/) {
        if $/<and-test>.List.elems gt 1 {
            make Python3::OrTest.new(
                operands => $<and-test>>>.made,
            )
        } else {
            make $<and-test>[0].made
        }
    }

    method and-test($/) {
        if $/<not-test>.List.elems gt 1 {
            make Python3::AndTest.new(
                operands => $<not-test>>>.made,
            )
        } else {
            make $<not-test>[0].made
        }
    }

    method not-test($/) {

        my $not-count = $/<NOT>.List.elems;

        if $not-count gt 0 {
            make Python3::NotTest.new(
                not-count  => $not-count,
                comparison => $<comparison>.made,
            )

        } else {
            make $<comparison>.made
        }
    }

    method comparison-operand($/) {
        make Python3::ComparisonOperand.new(
            comp-op   => $<comp-op>.made,
            star-expr => $<star-expr>.made,
        )
    }

    method comparison($/) {

        if $/<comparison-operand>.List.elems gt 0 {
            make Python3::Comparison.new(
                base     => $<star-expr>.made,
                operands => $<comparison-operand>>>.made,
            )
        } else {
            make $<star-expr>.made
        }

    }

    method star-expr($/) {
        if $/<STAR>.List.elems {
            make Python3::StarExpr.new(
                stars    => $/<STAR>.List.elems,
                or-expr  => $<or-expr>.made,
            )
        } else {
            make $<or-expr>.made
        }
    }

    method or-expr($/) {
        make Python3::OrExpr.new(
            operands => $<xor-expr>>>.made,
        )
    }

    method xor-expr($/) {
        my $ops = $<and-expr>>>.made;

        if $ops.elems gt 1 {
            make Python3::XorExpr.new(
                operands => $ops,
            )
        } else {
            make $ops[0]
        }
    }

    method and-expr($/) {
        my $ops = $<shift-expr>>>.made;

        if $ops.elems gt 1 {
            make Python3::AndExpr.new(
                operands => $ops.List,
            )
        } else {
            make $ops[0]
        }
    }

    method shift-expr($/) {

        my $ops = $<shift-operand>>>.made;

        if $ops.List.elems gt 0 {
            make Python3::ShiftExpr.new(
                lhs      => $/<arith-expr>.made,
                operands => $ops,
            )
        } else {
            make $<arith-expr>.made
        }
    }

    method shift-operand:sym<left>($/) {
        make Python3::LeftShiftOperand.new(
            expr => $<arith-expr>.made,
        )
    }

    method shift-operand:sym<right>($/) {
        make Python3::RightShiftOperand.new(
            expr => $<arith-expr>.made,
        )
    }

    method arith-expr($/) {
        if $/<arith-operand>.List.elems gt 0 {
            make Python3::ArithExpr.new(
                lhs      => $/<term>.made,
                operands => $/<arith-operand>>>.made,
            )
        } else {
            make $<term>.made
        }
    }

    method arith-operand:sym<plus>($/) {
        make Python3::PlusOperand.new(
            term      => $<term>.made,
        )
    }

    method arith-operand:sym<minus>($/) {
        make Python3::MinusOperand.new(
            term     => $<term>.made,
        )
    }

    method term($/) {
        if $/<term-operand>.List.elems gt 0 {
            make Python3::Term.new(
                lhs      => $<factor>.made,
                operands => $<term-operand>>>.made,
            )
        } else {
            make $<factor>.made
        }
    }

    method term-operand:sym<*>($/) {
        make Python3::StarOperand.new( factor => $<factor>.made )
    }

    method term-operand:sym</>($/) {
        make Python3::DivOperand.new( factor => $<factor>.made )
    }

    method term-operand:sym<%>($/) {
        make Python3::ModOperand.new( factor => $<factor>.made )
    }

    method term-operand:sym<//>($/) {
        make Python3::DoubleDivOperand.new( factor => $<factor>.made )
    }

    method term-operand:sym<@>($/) {
        make Python3::AtOperand.new( factor => $<factor>.made )
    }

    #--------------------------
    method factor:sym<prefix+>($/) {
        make Python3::PlusFactor.new( factor => $<factor>.made)
    }

    method factor:sym<prefix->($/) {
        make Python3::MinusFactor.new( factor => $<factor>.made)
    }

    method factor:sym<prefix~>($/) {
        make Python3::TildeFactor.new( factor => $<factor>.made)
    }

    method factor:sym<power>($/) {
        make $<power>.made
    }

    method power($/) {
        if $<factor>.made {
            make Python3::Power.new(
                base  => $<augmented-atom>.made,
                power => $<factor>.made,
            )
        } else {
            make $<augmented-atom>.made
        }
    }

    method augmented-atom($/) {
        if $/<trailer>.List.elems gt 0 {
            make Python3::AugmentedAtom.new(
                atom     => $<atom>.made,
                trailers => $<trailer>>>.made,
            )
        } else {
            make $<atom>.made
        }
    }

    method trailer:sym<dot-name>($/) {
        make Python3::DotName.new(
            name => $<NAME>.made
        )
    }

    method trailer:sym<subscriptlist>($/) {
        make $<subscriptlist>.made
    }

    method subscriptlist($/) {
        make Python3::SubscriptList.new(
            items => $<subscript>>>.made
        )
    }

    method subscript:sym<test>($/) {
        make $<test>.made
    }

    method subscript:sym<slice>($/) {
        make Python3::Slice.new(
            test0    => $<test>>>.made[0] // Nil,
            test1    => $<test>>>.made[1] // Nil,
            slice-op => $<slice-op>.made  // Nil,
        )
    }

    method slice-op($/) {
        make Python3::SliceOp.new(
            test => $<test>.made // Nil,
        )
    }

    method trailer:sym<arglist>($/) {
        make $<parenthesized-arglist>.made
    }

    method comp-op($/) {
        make Python3::CompOp.new(
            op => $/.Str
        )
    }

    method test:sym<lambdef>($/) {
        make $<lambdef>.made
    }

    method lambdef($/) {
        make Python3::Lambdef.new(
            varargslist => $<varargslist>.made // Nil,
            test        => $<test>.made,
        )
    }

    method test:sym<ternary>($/) {
        make Python3::TernaryOperator.new(
            A    => $/<or-test>[0].made,
            cond => $/<or-test>[1].made,
            B    => $/<test>.made,
        )
    }
}
