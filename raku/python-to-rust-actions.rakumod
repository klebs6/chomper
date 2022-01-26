use python3-function-to-rust-stub;
use python-to-rust-util;

our role Python3::NumberActions {
    method number:sym<integer>($/) { make $/.Str }
    method number:sym<float>($/)   { make $/.Str }
    method number:sym<imag>($/)    { make $/.Str }
}

our role Python3::DecoratorActions {

    method compound-stmt:sym<decorated>($/) {
        make {
            decorators => $/<decorators>.made,
            decorated  => $/<decorated-item>.made
        }
    }

    method decorators($/) {
        make $<decorator>>>.made
    }
}

our role Python3::IfStmtActions {

    method compound-stmt:sym<if>($/) {
        make {
            if => {
                test        => $<test>.made,
                comment     => $<COMMENT_NONEWLINE>.made // Nil,
                suite       => $<suite>.made,
                elif-suites => $<elif-suite>>>.made,
                else-suite  => $<else-suite>.made // Nil,
            }
        }
    }

    method elif-suite($/) {
        make {
            elif => {
                comments => get-compound-comments($/),
                test     => $<test>.made,
                suite    => $<suite>.made,
            }
        }
    }
}

our role Python3::ElseActions {

    method else-suite($/) {
        make {
            else => {
                comments => get-compound-comments($/),
                suite    => $<suite>.made,
            }
        }
    }
}

our role Python3::CompoundStmtActions {

    method compound-stmt:sym<while>($/) {
        make {
            while => {
                test     => $<test>.made,
                comments => [$<COMMENT_NONEWLINE>.made // Nil],
                suite    => $<suite>.made,
                else-suite => $<else-suite>.made // Nil,
            }
        }
    }

    method compound-stmt:sym<for>($/) {
        make {
            for => {
                exprlist    => $<exprlist>.made,
                testlist    => $<testlist>.made,
                comment     => $<COMMENT_NONEWLINE>.made // Nil,
                suite       => $<suite>.made,
                else-suite  => $<else-suite>.made // Nil,
            }
        }
    }
}

our role Python3::TryStmtActions {

    method compound-stmt:sym<try>($/) {
        make { 
            try-block => {
                comment        => $/<COMMENT_NONEWLINE>.made // Nil,
                suite          => $<suite>.made,
                |$<try-control-suite>.made,
            } 
        }
    }

    method try-control-suite:sym<full>($/) {
        make $<try-block-except-suite>.made
    }

    method try-control-suite:sym<finally>($/) {
        make {
            finally => $<finally-suite>.made
        }
    }

    method try-block-except-suite($/) {
        make {
            comments       => $<COMMENT>>>.made,
            except-clauses => $<except-clause-suite>>>.made,
            else           => $<else-suite>.made // Nil,
            finally        => $<finally-suite>.made // Nil,
        }
    }

    method except-clause-suite($/) {
        make {
            comments       => get-compound-comments($/),
            suite          => $<suite>.made,
        }
    }

    method finally-suite($/) {
        make {
            comments       => [|$<COMMENT>>>.made, $<COMMENT_NONEWLINE>.made // Nil],
            suite          => $<suite>.made
        }
    }
}

our role Python3::WithStmtActions {

    method compound-stmt:sym<with>($/) {
        make {
            with => {
                comments   => get-compound-comments($/),
                with-items => $<with-item>>>.made,
                suite      => $<suite>.made,
            }
        }
    }

    method with-item:sym<basic>($/) {
        make {
            with-item-basic => {
                test => $<test>.made,
            }
        }
    }

    method with-item:sym<as>($/) {
        make {
            with-item-as => {
                test => $<test>.made,
                expr => $<expr>.made,
            }
        }
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
        make $<string>>>.made
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
    method DOUBLE_QUOTED_LONG_STRING($/) { make $<DOUBLE_QUOTED_LONG_STRING_BODY>.made }
    method SINGLE_QUOTED_LONG_STRING($/) { make $<SINGLE_QUOTED_LONG_STRING_BODY>.made }

    method DOUBLE_QUOTED_LONG_STRING_BODY($/) { make $/.Str }
    method SINGLE_QUOTED_LONG_STRING_BODY($/) { make $/.Str }

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

our role Python3::AtomActions does Python3::StringActions {

    method atom:sym<strings>($/) { 
        make $<strings>.made 
    }

    method atom:sym<NONE>($/)    { make "NONE" }
    method atom:sym<true>($/)    { make True }
    method atom:sym<false>($/)   { make False }
    method atom:sym<NAME>($/)    { make $<NAME>.made }

    method atom:sym<parens>($/)  { 
        make {
            parens   => $<parens-atom>.made,
            comments => $<COMMENT>>>.made,
        }
    }

    method parens-atom($/) {
        make "parens-atom"
    }

    method atom:sym<list>($/)  { 
        make {
            testlist_comp  => $<testlist_comp>.made,
            comments       => $<COMMENT>>>.made,
        }
    }

    method atom:sym<dict>($/)  { 
        make {
            dictorsetmaker => $<dictorsetmaker>.made,
            comments       => $<COMMENT>>>.made,
        }
    }

    method atom:sym<number>($/)  { 
        make $<number>.made
    }

    method atom:sym<ellipsis>($/)  { 
        make Ellipsis.new
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
        make { comment => $/.Str }
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
=begin comment
        make python3-function-to-rust-stub(
            name       => $name,
            private    => $name.starts-with("_"),
            is-test    => is-test-fn-name($name),
            parameters => $<parameters>.made,
            test       => $<test> // Nil,
            suite      => $<suite>.Str
        )
=end comment
        make {
            funcdef => {
                name       => $name,
                private    => $name.starts-with("_"),
                is-test    => is-test-fn-name($name),
                parameters => $<parameters>.made,
                test       => $<test> // Nil,
                suite      => $<suite>.Str
            }
        }
    }

    method parameters($/) {
        make $/<parenthesized-typedarglist>.made
    }

    method parenthesized-typedarglist($/) {
        make $/<typedargslist>.made
    }

    method typedargslist:sym<full>($/) {
        make { 
            typedargslist => {
                basic-args => $<just-basic-args-with-trailing-comment>.made,
                star-args  => $<star-args>.made,
                kw-args    => $<kw-args>.made,
            }
        }
    }

    method typedargslist:sym<just-star-args>($/) {
        make { 
            typedargslist => {
                star-args  => $<star-args>.made,
            }
        }
    }

    method typedargslist:sym<just-kwargs>($/) {
        make { 
            typedargslist => {
                kw-args    => $<kw-args>.made,
            }
        }
    }

    method typedargslist:sym<just-basic>($/) {
        make { 
            typedargslist => {
                basic-args => $<just-basic-args>.made,
            }
        }
    }

    method typedargslist:sym<basic-and-star-args>($/) {
        make { 
            typedargslist => {
                basic-args => $<just-basic-args-with-trailing-comment>.made,
                star-args  => $<star-args>.made,
            }
        }
    }

    method typedargslist:sym<basic-and-kwargs>($/) {
        make { 
            typedargslist => {
                basic-args => $<just-basic-args-with-trailing-comment>.made,
                kw-args    => $<kw-args>.made,
            }
        }
    }

    method typedargslist:sym<star-and-kwargs>($/) {
        make { 
            typedargslist => {
                star-args  => $<star-args>.made,
                kw-args    => $<kw-args>.made,
            }
        }
    }

    method augmented-tfpdef($/) {
        make {
            augmented-tfpdef => $<tfpdef>.made,
            test             => $<test>.made // Nil,
        }
    }

    method augmented-tfpdef-comma-maybe-comment($/) {
        make {
            comment => $<COMMENT>>>.made,
            |$<augmented-tfpdef>.made,
        }
    }

    method just-basic-args($/) {
        make {
            args => [ |$<augmented-tfpdef-comma-maybe-comment>>>.made, $<augmented-tfpdef>.made ],
        }
    }

    method just-basic-args-with-trailing-comment($/) {
        make {
            args => [ |$<augmented-tfpdef-comma-maybe-comment>>>.made ],
        }
    }

    method star-args($/) {
        make {
            star-args => [$<tfpdef>.made // Nil, |$<augmented-tfpdef>>>.made ],
        }
    }

    method kwargs($/) {
        make {
            kwargs => $<tfpdef>.made,
        }
    }

    method tfpdef($/) {
        make {
            tfpdef => {
                name => $<NAME>.made,
                test => $<test>.made // Nil,
            }
        }
    }
}

our role Python3::ArglistActions {

    method parenthesized-arglist($/) {
        make $/<arglist>.made // Nil
    }

    method arglist:sym<just-basic>($/) {
        make { 
            basic-args => [
                |$<argument-comma-maybe-comment>>>.made,
                $<argument>.made
            ] 
        }
    }

    method arglist:sym<just-basic-with-trailing-comment>($/) {
        make { 
            basic-args => $<argument-comma-maybe-comment>>>.made
        }
    }

    method arglist:sym<just-star-args>($/) {
        make { 
            star-args => [ $<test>.made ] 
        }
    }

    method arglist:sym<just-star-args2>($/) {
        make {
            star-args => [
                $<test-comma-maybe-comment>.made, 
                |$<argument-comma-maybe-comment>>>.made,
                $<argument>.made
            ],
        }
    }

    method arglist:sym<just-kwargs>($/) {
        make {
            kwargs => $<test>.made,
        }
    }

    method arglist:sym<basic-and-star-arg>($/) {
        make {
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [ $<test>.made ],
        }
    }

    method arglist:sym<basic-and-star-arg-with-trailing-comma>($/) {
        make {
            basic-args => $<argument-comma-maybe-comment>>>.made,
            star-args  => [ $<test-comma-maybe-comment>.made ],
        }
    }

    method arglist:sym<basic-and-star-args>($/) {
        make {
            basic-args => $<basic>>>.made,
            star-args  => [ 
                $<test-comma-maybe-comment>.made,
                $<star>>>.made
            ],
        }
    }

    method arglist:sym<basic-and-kwargs>($/) {
        make {
            basic-args => $<argument-comma-maybe-comment>>>.made,
            kwargs     => $<test>.made,
        }
    }

    method arglist:sym<star-and-kwargs>($/) {
        make {
            star-args => [$<test-comma-maybe-comment>.made, |$<argument-comma-maybe-comment>>>.made],
            kwargs    => $<test>.made,
        }
    }

    method arglist:sym<full>($/) {
        make {
            basic-args => $<basic>.made,
            star-args  => [$<test-comma-maybe-comment>.made, |$<star>>>.made],
            kwargs     => $<test>.made,
        }
    }
}

our role Python3::ClassdefActions {

    method compound-stmt:sym<class>($/) {
        make $<classdef>.made
    }

    method classdef($/) {
        make {
            class => {
                name    => $<NAME>.made,
                arglist => $/<parenthesized-arglist>.made // Nil,
                comment => $<COMMENT_NONEWLINE>.made // Nil,
                suite   => $<suite>.made,
            }
        }
    }
}

our role Python3::ToRustActions 
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
does Python3::ArglistActions 
does Python3::StringActions 
{
    method TOP ($/) {
        make $<file-input>.made
    }

    #----------------------------------
    method file-input($/) {
        make $<file-input-item>>>.made
    }

    method file-input-item:sym<comment-newline>($/) {
        make $<comment-newline>.made;
    }

    method file-input-item:sym<stmt>($/) {
        make $<stmt>.made;
    }

    #----------------------------------
    method NAME($/) {
        make $/.Str
    }

    #-----------------------------------
    method suite:sym<simple>($/) {
        make $/<simple-suite>.made
    }

    method suite:sym<stmt>($/) {
        make $/<stmt-suite>.made
    }

    method stmt-suite($/) {
        make $/<stmt-maybe-comments>>>.made
    }

    method stmt-maybe-comments($/) {
        make {
            stmt     => $<stmt>.made,
            comments => $<COMMENT>>>.made,
        }
    }

    method simple-suite($/) {
        make {
            simple-stmt => {
                list    => $<simple-stmt>.made,
                comment => $<COMMENT>.made // Nil
            }
        }
    }

    method simple-stmt($/) {
        make $/<small-stmt>>>.made
    }

    method small-stmt:sym<expr-augassign>($/) {
        make {
            expr-augassign => {
                lhs  => $<testlist-star-expr>.made,
                op   => $<augassign>.made,
                rhs  => $<expr-augassign-rhs>.made,
            }
        }
    }

    method augassign($/) {
        make $/.Str
    }

    method small-stmt:sym<expr-equals>($/) {
        make {
            expr-equals => {
                lhs       => $<testlist-star-expr>.made,
                rhs-stack => $<expr-equals-rhs>>>.made,
            }
        }
    }

    method expr-equals-rhs:sym<yield>($/) {
        make $<yield-expr>.made
    }

    method expr-equals-rhs:sym<testlist-star-expr>($/) {
        make $<testlist-star-expr>.made
    }

    method yield-expr($/) {
        make {
            yield-expr => {
                arg => $<yield-arg>.made // Nil,
            }
        }
    }

    method yield-arg:sym<from>($/) {
        make {
            yield-arg-from => $<test>.made,
        }
    }

    method yield-arg:sym<testlist>($/) {
        make {
            yield-arg-testlist => $<testlist>.made,
        }
    }

    method testlist-star-expr($/) {
        make {
            testlist-star-expr => {
                test-or-star-exprs => $<test-or-star-expr>>>.made,
            }
        }
    }

    method test-or-star-expr:sym<test>($/) {
        make $<test>.made
    }

    method test-or-star-expr:sym<star-expr>($/) {
        make $<star-expr>.made
    }

    method small-stmt:sym<return>($/) {
        make {
            return => {
                testlist => $<testlist>.made // Nil,
            }
        }
    }

    method small-stmt:sym<raise>($/) {
        make {
            raise => {
                clause => $/<raise-clause>.made // Nil,
            }
        }
    }

    method raise-clause($/) {
        make {
            raise-clause => {
                test => $/<test>[0].made,
                from => $/<test>[1].made // Nil,
            }
        }
    }

    method small-stmt:sym<import-name>($/) {
        make PythonImportSkipMe.new
    }

    method small-stmt:sym<nonlocal>($/) {
        make {
            nonlocal => {
                names => $/<NAME>>>.made,
            }
        }
    }

    method small-stmt:sym<assert>($/) {
        make {
            assert => {
                tests => $/<test>>>.made,
            }
        }
    }

    method small-stmt:sym<pass>($/) {
        make Pass.new
    }

    method small-stmt:sym<break>($/) {
        make Break.new
    }

    method small-stmt:sym<continue>($/) {
        make Continue.new
    }

    method small-stmt:sym<yield>($/) {
        make $<yield-expr>.made
    }

    method small-stmt:sym<import-from>($/) {
        make PythonImportSkipMe.new
    }

    method small-stmt:sym<global>($/) {
        make {
            global => {
                names => $<NAME>>>.made
            }
        }
    }

    method small-stmt:sym<del>($/) {
        make {
            del => {
                exprlist => $<exprlist>.made
            }
        }
    }

    method exprlist($/) {
        make {
            exprs => $<star-expr>>>.made
        }
    }

    #----------------------------------
    method test:sym<basic>($/) {
        make $<or-test>.made
    }

    method or-test($/) {
        make {
            or-test => {
                operands => $<and-test>>>.made,
                comments => $<COMMENT>>>.made,
            }
        }
    }

    method and-test($/) {
        make {
            and-test => {
                operands => $<not-test>>>.made,
                comments => $<COMMENT>>>.made,
            }
        }
    }

    method not-test($/) {
        make {
            not-test => {
                not-count  => $/<NOT>.List.elems,
                comparison => $<comparison>.made,
            }
        }
    }

    method comparison($/) {
        make {
            comparison => {
                star-exprs => $/<star-expr>>>.made,
                comp-ops   => $/<comp-op>>>.made,
            }
        }
    }

    method star-expr($/) {
        make {
            has-star => $/<STAR>:exists,
            expr     => $<expr>.made,
        }
    }

    method expr($/) {
        make {
            expr => {
                operands => $/<xor-expr>>>.made,
            }
        }
    }

    method xor-expr($/) {
        make {
            xor-expr => {
                operands => $/<and-expr>>>.made,
            }
        }
    }

    method and-expr($/) {
        make {
            and-expr => {
                operands => $/<shift-expr>>>.made,
            }
        }
    }

    method shift-expr($/) {
        make {
            shift-expr => {
                lhs   => $/<arith-expr>.made,
                stack => $/<shift-arith-expr>>>.made,
            }
        }
    }

    method shift-arith-expr:sym<left>($/) {
        make {
            left-shift => {
                arith-expr => $<arith-expr>.made,
            }
        }
    }

    method shift-arith-expr:sym<right>($/) {
        make {
            right-shift => {
                arith-expr => $<arith-expr>.made,
            }
        }
    }

    method arith-expr($/) {
        make {
            arith-expr => {
                lhs   => $/<term>.made,
                stack => $/<plus-minus-term>>>.made,
            }
        }
    }

    method plus-minus-term:sym<plus>($/) {
        make {
            plus-term => $<term>.made,
            comments  => $<COMMENT>>>.made,
        }
    }

    method plus-minus-term:sym<minus>($/) {
        make {
            minus-term => $<term>.made,
            comments   => $<COMMENT>>>.made,
        }
    }

    method term($/) {
        make {
            term => {
                base  => $<factor>.made,
                stack => $<term-delimited-factor>>>.made,
            }
        }
    }

    method term-delimited-factor($/) {
        make {
            comments => $<COMMENT>>>.made,
            delim    => $<term-delim>.Str,
            factor   => $<factor>.made,
        }
    }

    method factor($/) {
        make {
            factor => {
                delim-stack => $<factor-delim>>>.Str,
                power       => $<power>.made,
            }
        }
    }

    method power($/) {
        make {
            augmented-atom => $<augmented-atom>.made,
            factor-stack   => $<factor>>>.made,
        }
    }

    method augmented-atom($/) {
        make {
            atom     => $<atom>.made,
            trailers => $<trailer>>>.made,
        }
    }

    method trailer($/) {
        make {
            trailer => $/
        }
    }

    method comp-op($/) {
        make $/.Str
    }

    method test:sym<lambdef>($/) {
        make $<lambdef>.made
    }

    method lambdef($/) {
        make "lambdef"
    }

    method test:sym<ternary>($/) {
        make TernaryOperator.new(
            A    => $/<or-test>[0].made,
            cond => $/<or-test>[1].made,
            B    => $/<test>.made,
        )
    }
}
