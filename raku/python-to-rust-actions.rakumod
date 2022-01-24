use python3-function-to-rust-stub;

our class Continue {}
our class PythonImportSkipMe {}
our class Break {}
our class Pass {}

our class TernaryOperator {
    has $.A    is required;
    has $.cond is required;
    has $.B    is required;
}

sub get-compound-comments($/) {
    [|$<COMMENT>>>.made, $<COMMENT_NONEWLINE>.made // Nil]
}

our sub is-test-fn-name($name is rw) {
    $name = $name.subst(:g, /^_/, "");
    $name.starts-with("test")
}

our role DeeperPython3ToRustActions {

}

our role Python3ToRustActions {

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

    method comment-newline($/) {
        make $<COMMENT_NONEWLINE>.made
    }

    method file-input-item:sym<stmt>($/) {
        make $<stmt>.made;
    }

    #----------------------------------
    method stmt:sym<compound>($/) {
        make $<compound-stmt>.made;
    }

    method stmt:sym<simple>($/) {
        make $<simple-suite>.made;
    }

    method stmt:sym<comment>($/) {
        make $<COMMENT_NONEWLINE>.made;
    }

    method compound-stmt:sym<decorated>($/) {
        make {
            decorators => $/<decorators>.made,
            decorated  => $/<decorated-item>.made
        }
    }

    method decorators($/) {
        make $<decorator>>>.made
    }

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

    method else-suite($/) {
        make {
            else => {
                comments => get-compound-comments($/),
                suite    => $<suite>.made,
            }
        }
    }

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

    method compound-stmt:sym<func>($/) {
        make $<funcdef>.made
    }


    #------------------------------------
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
            augmented-tfpdef => {
                tfpdef => $<tfpdef>.made,
                test   => $<test>.made // Nil,
            }
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

    method comma-maybe-comment($/) {
        make $/<COMMENT>>>.made
    }

    method NAME($/) {
        make $/.Str
    }

    method compound-stmt:sym<class>($/) {
        make $<classdef>.made
    }

    method classdef($/) {
        make {
            class => {
                name    => $<NAME>.made,
                arglist => $/<parenthesized-arglist><arglist> // Nil,
                comment => $<COMMENT_NONEWLINE>.made // Nil,
                suite   => $<suite>.made,
            }
        }
    }

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
    method COMMENT_NONEWLINE($/) {
        make { comment => $/.Str }
    }

    method COMMENT($/) {
        make $<COMMENT_NONEWLINE>.made
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
            power => {
                augmented-atom => $<augmented-atom>.made,
                factor-stack   => $<factor>>>.made,
            }
        }
    }

    method augmented-atom($/) {
        make {
            augmented-atom => {
                atom     => $<atom>.made,
                trailers => $<trailer>>>.made,
            }
        }
    }

    method atom($/) {
        make {
            atom => $/
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
