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

    method funcdef($/) {
        make {
            function => {
                name       => $<NAME>.made,
                private    => $<NAME>.made.starts-with("_"),
                parameters => $<parameters>.made // Nil,
                test       => $<test> // Nil,
                suite      => $<suite>.made
            }
        }
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
        make "expr-augassign"
    }

    method small-stmt:sym<expr-equals>($/) {
        make "expr-equals"
    }

    method small-stmt:sym<return>($/) {
        make "return"
    }

    method small-stmt:sym<raise>($/) {
        make "raise"
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
        make "yield"
    }

    method small-stmt:sym<import-from>($/) {
        make PythonImportSkipMe.new
    }

    method small-stmt:sym<global>($/) {
        make "global"
    }

    method small-stmt:sym<del>($/) {
        make "del"
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
        make "or-test"
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
