use python3-translate;
use python3-model;

our sub get-compound-comments($/) {

    my $comments = $<COMMENT>>>.made;
    my $last     = $<COMMENT_NONEWLINE>.made;

    if $last {
        $comments.push: $last
    }

    $comments
}

our sub is-test-fn-name($name) {
    my $fn-name = $name.subst(:g, /^_/, "");
    $fn-name.starts-with("test")
}


our role Python3::NumberActions {
    method number:sym<integer>($/) { make Python3::Integer.new(value => $/.Int } }
    method number:sym<float>($/)   { make Python3::Float.new(value => $/.Num ) }
    method number:sym<imag>($/)    { make Python3::Imaginary.new(value => $/.Complex ) }
}

our role Python3::DecoratorActions {

    method compound-stmt:sym<decorated>($/) {
        make Python3::Decorated.new(
            decorators => $/<decorators>.made,
            decorated  => $/<decorated-item>.made
        )
    }

    method decorators($/) {
        make $<decorator>>>.made
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
        make Python3::While.new(
            test     => $<test>.made,
            comments => [$<COMMENT_NONEWLINE>.made // Nil],
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
            expr => $<expr>.made,
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

    method LONG_STRING:sym<SINGLE_QUOTED>($/)  { make $<SINGLE_QUOTED_LONG_STRING>.made  }
    method LONG_STRING:sym<DOUBLE_QUOTED>($/)  { make $<DOUBLE_QUOTED_LONG_STRING>.made  }
    method SHORT_STRING:sym<SINGLE_QUOTED>($/) { make $<SINGLE_QUOTED_SHORT_STRING>.made }
    method SHORT_STRING:sym<DOUBLE_QUOTED>($/) { make $<DOUBLE_QUOTED_SHORT_STRING>.made }
    method LONG_BYTES:sym<SINGLE_QUOTED>($/)   { make $<SINGLE_QUOTED_LONG_BYTES>.made   }
    method LONG_BYTES:sym<DOUBLE_QUOTED>($/)   { make $<DOUBLE_QUOTED_LONG_BYTES>.made   }
    method SHORT_BYTES:sym<SINGLE_QUOTED>($/)  { make $<SINGLE_QUOTED_SHORT_BYTES>.made  }
    method SHORT_BYTES:sym<DOUBLE_QUOTED>($/)  { make $<DOUBLE_QUOTED_SHORT_BYTES>.made  }

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
            test    => $<test>.made
            comment => $<comma-maybe-comment>.made
        )
    }

    method listmaker:sym<testlist>($/) {
        make Python3::TestList.new(
            tests => [
                |$<test-comma-maybe-comment>>>.made,
                $<test>.made
            ]
        )
    }

    method listmaker:sym<testlist-with-trailing-comma>($/) {
        make Python3::TestList.new(
            tests => $<test-comma-maybe-comment>>>.made,
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
                $<dictmaker-item>.made
            ]
        )
    }

    method dictorsetmaker:sym<dict-with-comma-trailer>($/) {
        make Python3::Dict.new(
            items => $<dictmaker-item-comma-maybe-comment>>>.made,
        )
    }

    method dictorsetmaker:sym<dict-comp>($/) {
        make Python3::DictComp.new(
            item => $<dictmaker-item>.made,
            comp => $<comp-for>.made,
        )
    }

    method dictmaker-item($/) {
        make Python3::DictMakerItem.new(
            comments => [$<COMMENT>.made // Nil], 
            K       => $<test>[0].made,
            V       => $<test>[1].made,
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
        make Python3::SetmakerItem.new(
            has-stars => False,
            comments  => [$<COMMENT>.made // Nil], 
            K         => $<test>.made,
        )
    }

    method setmaker-item:sym<stars-test>($/) {
        make Python3::SetmakerItem.new(
            has-stars => True,
            comments  => [$<COMMENT>.made // Nil], 
            K         => $<test>.made,
        )
    }

    method setmaker-item-comma-maybe-comment($/) {
        make Python3::SetmakerItem.new(
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

        make Python3::Funcdef.new(
            name       => $name,
            private    => $name.starts-with("_"),
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
        make $/<typedargslist>.made
    }

    method typedargslist:sym<full>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args-with-trailing-comment>.made,
            star-args  => $<star-args>.made,
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method typedargslist:sym<just-star-args>($/) {
        make Python3::TypedArgList.new(
            star-args  => $<star-args>.made,
        )
    }

    method typedargslist:sym<just-kwargs>($/) {
        make Python3::TypedArgList.new(
            kw-args    => $<typeargslist-kwargs>.made,
        )
    }

    method typedargslist:sym<just-basic>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args>.made,
        )
    }

    method typedargslist:sym<basic-and-star-args>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args-with-trailing-comment>.made,
            star-args  => $<star-args>.made,
        )
    }

    method typedargslist:sym<basic-and-kwargs>($/) {
        make Python3::TypedArgList.new(
            basic-args => $<just-basic-args-with-trailing-comment>.made,
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method typedargslist:sym<star-and-kwargs>($/) {
        make Python3::TypedArgList.new(
            star-args  => $<star-args>.made,
            kw-args    => $<typedargslist-kwargs>.made,
        )
    }

    method augmented-tfpdef($/) {
        make Python3::AugmentedTfpdef.new(
            augmented-tfpdef => $<tfpdef>.made,
            test             => $<test>.made // Nil,
        )
    }

    method augmented-tfpdef-comma-maybe-comment($/) {
        my $item = $<augmented-tfpdef>.made;
        $item.comments = $<COMMENT>>>.made;
        make $item
    }

    method just-basic-args($/) {
        make [ 
            |$<augmented-tfpdef-comma-maybe-comment>>>.made, 
            $<augmented-tfpdef>.made 
        ]
    }

    method just-basic-args-with-trailing-comment($/) {
        make $<augmented-tfpdef-comma-maybe-comment>>>.made 
    }

    method star-args($/) {
        make [ $<tfpdef>.made // Nil, |$<augmented-tfpdef>>>.made ]
    }

    method kwargs($/) {
        make $<tfpdef>.made,
    }

    method tfpdef($/) {
        make Python3::Tfpdef.new(
            name => $<NAME>.made,
            test => $<test>.made // Nil,
        )
    }
}

our role Python3::ArglistActions {

    method parenthesized-arglist($/) {
        make $<arglist>.made // Nil
    }

    method arglist:sym<just-basic>($/) {
        make Python3::Arglist.new(
            basic-args => [
                |$<argument-comma-maybe-comment>>>.made,
                $<argument>.made
            ] 
        )
    }

    method arglist:sym<just-basic-with-trailing-comment>($/) {
        make Python3::Arglist.new(
            basic-args => $<argument-comma-maybe-comment>>>.made
        )
    }

    method arglist:sym<just-star-args>($/) {
        make Python3::Arglist.new(
            star-args => [ $<test>.made ] 
        )
    }

    method arglist:sym<just-star-args2>($/) {
        make Python3::Arglist.new(
            star-args => [
                $<test-comma-maybe-comment>.made, 
                |$<argument-comma-maybe-comment>>>.made,
                $<argument>.made
            ],
        )
    }

    method arglist:sym<just-kwargs>($/) {
        make Python3::Arglist.new(
            kwargs => $<arglist-kwargs>.made,
        )
    }

    method arglist:sym<basic-and-star-arg>($/) {
        make Python3::Arglist.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [ $<star-arg>.made ],
        )
    }

    method arglist-kwargs($/) {
        make $<test>.made
    }

    method star-arg($/) {
        make $<test>.made
    }

    method arglist:sym<basic-and-star-arg-with-trailing-comma>($/) {
        make Python3::Arglist.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [ $<test-comma-maybe-comment>.made ],
        )
    }

    method arglist:sym<basic-and-star-args>($/) {
        make Python3::Arglist.new(
            basic-args => $<basic>>>.made,
            star-args  => [ 
                $<test-comma-maybe-comment>.made,
                $<star>>>.made
            ],
        )
    }

    method arglist:sym<basic-and-kwargs>($/) {
        make Python3::Arglist.new(
            basic-args => $<argument-comma-maybe-comment>>>.made,
            kwargs     => $<arglist-kwargs>.made,
        )
    }

    method arglist:sym<star-and-kwargs>($/) {
        make Python3::Arglist.new(
            star-args => [$<test-comma-maybe-comment>.made, |$<argument-comma-maybe-comment>>>.made],
            kwargs    => $<arglist-kwargs>.made,
        )
    }

    method arglist:sym<full>($/) {
        make Python3::Arglist.new(
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
            arglist => $/<parenthesized-arglist>.made // Nil,
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

    method small-stmt:sym<expr-augassign>($/) {
        make Python3::ExprAugAssign.new(
            lhs  => $<testlist-star-expr>.made,
            op   => $<augassign>.made,
            rhs  => $<expr-augassign-rhs>.made,
        )
    }

    method small-stmt:sym<expr-equals>($/) {
        make Python3::ExprEquals.new(
            lhs       => $<testlist-star-expr>.made,
            rhs-stack => $<expr-equals-rhs>>>.made,
        )
    }

    method small-stmt:sym<return>($/) {
        make Python3::Return.new(
            testlist => $<testlist>.made // Nil,
        )
    }

    method small-stmt:sym<raise>($/) {
        make Python3::Raise.new(
            clause => $/<raise-clause>.made // Nil,
        )
    }


    method small-stmt:sym<import-name>($/) {
        make Python3::ImportName.new(
            names => $<dotted-as-names>.made
        )
    }

    method small-stmt:sym<nonlocal>($/) {
        make Python3::Nonlocal.new(
            names => $/<NAME>>>.made,
        )
    }

    method small-stmt:sym<assert>($/) {
        make Python3::Assert.new(
            tests => $/<test>>>.made,
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
        make $<yield-expr>.made
    }

    method small-stmt:sym<import-from>($/) {
        make $<import-from>.made
    }

    method small-stmt:sym<global>($/) {
        make Python3::Global.new(
            names => $<NAME>>>.made
        )
    }

    method small-stmt:sym<del>($/) {
        make Python3::Del.new(
            exprs => $<exprlist>.made,
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
            stmts => $/<stmt-maybe-comments>>>.made
        )
    }
    method simple-suite($/) {
        make Python3::SimpleSuite.new(
            stmts   => $<simple-stmt>.made,
            comment => $<COMMENT>.made // Nil,
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
does Python3::ArglistActions 
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
        make Python3::TestlistStarExpr.new(
            test-or-star-exprs => $<test-or-star-expr>>>.made,
        )
    }

    method test-or-star-expr:sym<test>($/) {
        make $<test>.made
    }

    method test-or-star-expr:sym<star-expr>($/) {
        make $<star-expr>.made
    }


    method raise-clause($/) {
        make Python3::RaiseClause.new(
            test => $/<test>[0].made,
            from => $/<test>[1].made // Nil,
        )
    }

    method dotted-as-names($/) {
        make $<dotted-as-name>>>.made
    }

    method dotted-as-name($/) {
        make Python3::DottedAsName.new(
            name => $<dotted_name>.made,
            as   => $<NAME>.made // Nil,
        )
    }

    method dotted_name($/) {
        make Python3::DottedName.new(
            names => $<NAME>>>.made
        )
    }


    method import-from($/) {
        make Python3::ImportFrom.new(
            src    => $<import-from-src>.made,
            target => $<import-from-target>.made,
        )
    }

    method import-from-src($/) {
        make Python3::ImportFromSrc.new(
            dot-stack => $<import-dots>>>.made,
            name      => $<dotted_name>.made // Nil,
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
        make $<star-expr>>>.made
    }

    #----------------------------------
    method test:sym<basic>($/) {
        make Python3::BasicTest.new(
            or-test => $<or-test>.made
        )
    }

    method or-test($/) {
        make Python3::OrTest.new(
            operands => $<and-test>>>.made,
            comments => $<COMMENT>>>.made,
        )
    }

    method and-test($/) {
        make Python3::AndTest.new(
            operands => $<not-test>>>.made,
            comments => $<COMMENT>>>.made,
        )
    }

    method not-test($/) {
        make Python3::NotTest.new(
            not-count  => $/<NOT>.List.elems,
            comparison => $<comparison>.made,
        )
    }

    method comparison($/) {
        make Python3::Comparison.new(
            star-exprs => $/<star-expr>>>.made,
            comp-ops   => $/<comp-op>>>.made,
        )
    }

    method star-expr($/) {
        make Python3::StarExpr.new(
            has-star => $/<STAR>:exists,
            expr     => $<expr>.made,
        )
    }

    method expr($/) {
        make Python3::Expr.new(
            operands => $/<xor-expr>>>.made,
        )
    }

    method xor-expr($/) {
        make Python3::XorExpr.new(
            operands => $/<and-expr>>>.made,
        )
    }

    method and-expr($/) {
        make Python3::AndExpr.new(
            operands => $/<shift-expr>>>.made,
        )
    }

    method shift-expr($/) {
        make Python3::ShiftExpr.new(
            lhs   => $/<arith-expr>.made,
            stack => $/<shift-arith-expr>>>.made,
        )
    }

    method shift-arith-expr:sym<left>($/) {
        make Python3::LeftShiftExpr.new(
            arith-expr => $<arith-expr>.made,
        )
    }

    method shift-arith-expr:sym<right>($/) {
        make Python3::RightShiftExpr.new(
            arith-expr => $<arith-expr>.made,
        )
    }

    method arith-expr($/) {
        make Python3::ArithExpr.new(
            lhs   => $/<term>.made,
            stack => $/<plus-minus-term>>>.made,
        )
    }

    method plus-minus-term:sym<plus>($/) {
        make Python3::PlusTerm.new(
            term      => $<term>.made,
            comments  => $<COMMENT>>>.made,
        )
    }

    method plus-minus-term:sym<minus>($/) {
        make Python3::MinusTerm.new(
            term     => $<term>.made,
            comments => $<COMMENT>>>.made,
        )
    }

    method term($/) {
        make Python3::Term.new(
            base  => $<factor>.made,
            stack => $<term-delimited-factor>>>.made,
        )
    }

    method term-delimited-factor($/) {
        make Python3::TermDelimitedFactor.new(
            comments => $<COMMENT>>>.made,
            delim    => $<term-delim>.Str,
            factor   => $<factor>.made,
        )
    }

    method factor($/) {
        make Python3::Factor.new(
            delim-stack => $<factor-delim>>>.Str,
            power       => $<power>.made,
        )
    }

    method power($/) {
        make Python3::Power.new(
            augmented-atom => $<augmented-atom>.made,
            factor-stack   => $<factor>>>.made,
        )
    }

    method augmented-atom($/) {
        make Python3::AugmentedAtom.new(
            atom     => $<atom>.made,
            trailers => $<trailer>>>.made,
        )
    }

    method trailer($/) {
        make Python3::Trailer.new(
            trailer => $/
        )
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
