use python3-comment;
use python3-compound;
use python3-decorator;
use python3-suite;
use pyrust;
use snake-case;

our role Python3::IFuncDef {     }
our class Python3::FuncDef { ... } # fwd declare

our class Python3::FuncDef 
does Python3::ICompoundStmt 
does Python3::IFuncDef
{

    has Python3::Name  $.name is required;
    has Bool           $.private is required;
    has Bool           $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required is rw;
    has Python3::ITest $.test;

    method get-rust-scaffold(:$python-decorators) {

        my $comment        = self.rust-comment-from-suite();
        my $parsed-comment = parse-python-doc-comment($comment);
        my $return-value   = maybe-extract-return-value($parsed-comment);
        my $rust-comment   = as-rust-comment($parsed-comment,backup => $comment);

        my $optional-initializers = $.parameters ?? $.parameters.optional-initializers() !! "";
        my $body                  = $.suite.text;
        my $rust-args             = $.parameters ?? $.parameters.convert-to-rust() !! "";

        my @rust-attrs            = $python-decorators.List>>.to-rust-attr;

        create-rust-function(
            comment => $rust-comment // "",
            python => True,
            :$.private,
            :@rust-attrs,
            :$.is-test,
            name => snake-case($.name.value),
            :$return-value,
            :$rust-args,
            :$optional-initializers,
            :$body
        )
    }

    method rust-comment-from-suite {
        extract-rust-comment-from-suite($.suite)
    }
}

our class Python3::DecoratedFunction does Python3::ICompoundStmt  {
    has Python3::Decorator @.decorators is required;
    has Python3::IFuncDef  $.decorated  is required;

    method get-rust-scaffold {
        $.decorated.get-rust-scaffold(python-decorators => @.decorators)
    }
}

#---------------------------------
our sub toplevel-python-functions(Python3::Suite $suite) {

    given $suite  {
        when Python3::SimpleSuite {
            []
        }
        when Python3::StmtSuite {
            $suite.stmts.List.grep({
                so [
                    $_.stmt ~~ Python3::IFuncDef,
                    $_.stmt ~~ Python3::DecoratedFunction,
                ].any
            }).map: {
                $_.stmt 
            }
        }
        default {
            die "TODO";
        }
    }
}

our sub toplevel-standard-python-functions(Python3::Suite $suite) {

    given $suite {
        when Python3::SimpleSuite {
            []
        }
        when Python3::StmtSuite {
            $suite.stmts.List.grep({ 
                given $_.stmt {
                    when Python3::FuncDef {
                        so !$_.is-test()
                    }
                    when Python3::DecoratedFunction {
                        so !$_.decorated.is-test()
                    }
                    default {
                        False
                    }
                }
            }).map: { $_.stmt }
        }
        default {
            die "TODO";
        }
    }
}

our sub toplevel-python-test-functions(Python3::Suite $suite) {

    given $suite {
        when Python3::SimpleSuite {
            []
        }
        when Python3::StmtSuite {
            $suite.stmts.List.grep({ 
                given $_.stmt {
                    when Python3::FuncDef {
                        so $_.is-test()
                    }
                    default {
                        False
                    }
                }
            }).map: { $_.stmt }
        }
        default {
            die "TODO";
        }
    }
}
