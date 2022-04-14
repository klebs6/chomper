use python3-prelude;
use python3-args;

our class Python3::Decorator {
    has Python3::DottedName $.name is required;
    has Python3::Comment    $.comment;
    has Python3::ArgList    $.arglist;

=begin comment

@pytest.mark.parametrize('size', [(6, 5), (5, 5)])
@pytest.mark.parametrize('dtype', REAL_DTYPES)
@pytest.mark.parametrize('joba', range(6))  # 'C', 'E', 'F', 'G', 'A', 'R'
@pytest.mark.parametrize('jobu', range(4))  # 'U', 'F', 'W', 'N'
@pytest.mark.parametrize 
@pytest.mark.parametrize('jobr', [0, 1])
def test_gejsv_general(size, dtype, joba, jobu, jobv, jobr, jobp):
    pass

=end comment

    method maybe-parse-args {
        if $.arglist {
            $.arglist.format-for-decorator()
        } else {
            ""
        }
    }

    method to-rust-attr-with-single-level($name0) {
        qq:to/END/
        #[{$name0}{self.maybe-parse-args()}] {$.comment ?? "//" ~ $.comment.text !! "" }
        END
    }

    method to-rust-attr-with-double-level($name0, $name1) {
        qq:to/END/
        #[{$name0}({$name1}{self.maybe-parse-args()})] {$.comment ?? "//" ~ $.comment.text !! "" }
        END
    }

    method to-rust-attr-with-triple-level($name0, $name1, $name2) {
        qq:to/END/
        #[{$name0}({$name1}( {$.comment ?? "//" ~ $.comment.text !! "" }
            {$name2}{self.maybe-parse-args()}
        ))]
        END
    }

    method to-rust-attr-with-quadruple-level($name0, $name1, $name2, $name3) {
        qq:to/END/
        #[{$name0}({$name1}( {$.comment ?? "//" ~ $.comment.text !! "" }
            {$name2}(
                {$name3}{self.maybe-parse-args()}
            )
        ))]
        END
    }

    method to-rust-attr-with-quintuple-level($name0, $name1, $name2, $name3, $name4) {
        qq:to/END/
        #[{$name0}({$name1}( {$.comment ?? "//" ~ $.comment.text !! "" }
            {$name2}(
                {$name3}({$name4}{self.maybe-parse-args()})
            )
        ))]
        END
    }

    method to-rust-attr {
        my @name-stack = $.name.names>>.value;
        do given @name-stack.elems {
            when 0 {
                die "some error: name-stack empty";
            }
            when 1 {
                self.to-rust-attr-with-single-level(|@name-stack)
            }
            when 2 {
                self.to-rust-attr-with-double-level(|@name-stack)
            }
            when 3 {
                self.to-rust-attr-with-triple-level(|@name-stack)
            }
            when 4 {
                self.to-rust-attr-with-quadruple-level(|@name-stack)
            }
            when 5 {
                self.to-rust-attr-with-quintuple-level(|@name-stack)
            }
            when 6 {
                die "decorator unhandled";
            }
        }.chomp
    }
}
