use util;
use typemap;
use type-info;
use textwidth;

sub switch-brackets($tree is rw, $nextL = "[", $nextR = "]") {
    $tree ~~ s:g/\{/$nextL/;
    $tree ~~ s:g/\}/$nextR/;
    $tree.chomp.trim
}

sub extract-ptr-type(TypeAux $aux) {
    $aux.as-cast()
}

class BracedArrayLiteral {

    has Match $.tree;

    method gist {
        my $rt = self.format-tree-for-rust($.tree);
        switch-brackets($rt)
    }

    method format-tree-leaf-for-rust($tree) {

        my @values = $tree<default-value>.List;

        my $has-caster = False;

        my @parsed = do for @values {
            if $_<identifier-cast-as-uarg>:exists {

                $has-caster = True;

                my $arg = $_<identifier-cast-as-uarg>;
                my $id  = $arg<identifier>.Str;
                my TypeAux   $aux = get-type-aux($arg<unnamed-arg>);
                my TypeInfo  $info = populate-typeinfo($arg<unnamed-arg><type>);

                my $ptr-type = extract-ptr-type($aux);
                "&$id as {$ptr-type.trim} {$info.vectorized-rtype}"

            } else {
                if $_ ~~ "NULL" {
                    "0 /*NULL*/"
                } else {
                    $_.Str
                }
            }
        };

        if $has-caster {
            my $body = @parsed.join(",\n").chomp.trim;

            qq:to/END/
            \{
            {$body.indent(4)}
            \}
            END
        } else {
            $tree.Str
        }
    }

    method format-tree-leaf-list-for-rust($tree) {

    }

    method format-tree-leaf-list-list-for-rust($tree) {

    }

    method format-tree-for-rust($tree) {
        #tree should have already been validated

        if $tree<braced-array-literal-leaf>:exists {
            self.format-tree-leaf-for-rust($tree<braced-array-literal-leaf>)

        } elsif $tree<braced-array-literal-leaf-list>:exists {
            self.format-tree-leaf-list-for-rust($tree<braced-array-literal-leaf>)

        } elsif $tree<braced-array-literal-leaf-list-list>:exists {
            self.format-tree-leaf-list-list-for-rust($tree<braced-array-literal-leaf>)

        } else {
            die;
        }
    }

    sub validate-extracted-tree($t) {

        sub is-leaf-member($x) {
            $x ~~ Num | Str
        }

        sub is-leaf($a) {

            if $a ~~ Array | List {
                return is-leaf-member($a.List[0]);
            }

            return False;
        }

        sub get-fingerprint($t) {
            die "bad input: $t" if is-leaf-member($t);

            if is-leaf($t) {
                return $t.List.elems;
            }
            do for $t.List {
                get-fingerprint($_)
            }
        }

        my $fp = get-fingerprint($t);

        if not $fp.List.elems eq 1 {

            my $head = $fp.List[0];

            for $fp.List {
                if not $_ eqv $head {
                    return False;

                }

            }
        }
        return True;
    }

    sub test-tree-validator {
        use Test;

        my $t0 = 1;

        my $t1 = [1,2,3];

        my $t2 = [[1,2,3],[2,3,4]];

        my $t3 = [
            [[1,2,3],[2,3,4]],
            [[1,2,3],[2,3,4]]
        ];

        my $e0 = [
            [[1,2,3,4],[2,3,4]],
            [[1,2,3],[2,3,4]]
        ];

        my $e1 = [
            [[1,2,3],[2,3,4], [3,5,6]],
            [[1,2,3],[2,3,4]]
        ];

        my $e2 = [
            [[1,2,3,4],[2,3,4], [3,5,6]],
            [[1,2,3],[2,3,4]]
        ];

        ok validate-extracted-tree($t1);
        ok validate-extracted-tree($t2);
        ok validate-extracted-tree($t3);

        nok validate-extracted-tree($e0);
        nok validate-extracted-tree($e1);
        nok validate-extracted-tree($e2);
    }

    method validate-tree(Match $tree) {
        #each node needs to have the same number
        #of subnodes
        #
        #each leaf needs to have the same 
        #number of array items

        sub extract-leaf($leaf) {
            $leaf<default-value>.List>>.Str;
        }

        sub extract-leaf-list($ll) {
            my @arr = [];
            for $ll<braced-array-literal-leaf>.List -> $leaf {
                @arr.push: extract-leaf($leaf);
            }
            @arr
        }

        sub extract-tree($tree) {

            my @arr = [];

            if $tree<braced-array-literal-leaf>:exists {
                @arr.push: extract-leaf($tree<braced-array-literal-leaf>);
            } elsif $tree<braced-array-literal-leaf-list>:exists {
                my @ll = $tree<braced-array-literal-leaf-list><braced-array-literal-leaf>.List;
                for @ll -> $leaf {
                    @arr.push: extract-leaf($leaf);
                }
            } elsif $tree<braced-array-literal-leaf-list-list>:exists {
                my @lll = $tree<braced-array-literal-leaf-list-list><braced-array-literal-leaf-list>.List;
                
                for @lll -> $ll {
                    @arr.push: extract-leaf-list($ll);
                }
            } else {
                die;
            }

            @arr
        }

        my $extracted = extract-tree($tree);

        validate-extracted-tree($extracted);
    }

    submethod BUILD(Match :$match) {
        die if not 
        $match<braced-array-literal-tree>:exists;

        my $tree = $match<braced-array-literal-tree>;

        die "invalid array" if not self.validate-tree($tree);

        $!tree = $tree;
    }

}

our sub translate-static-const-rhs(Match $static_const) {

    my $rhs = $static_const<static_const_rhs>;

    if $rhs<braced-array-literal>:exists {
        BracedArrayLiteral.new(
            match => $rhs<braced-array-literal>
        ).gist

    } else {
        $rhs.Str
    }
}

our sub translate-static-const($submatch, $body, $rclass) {

    my @items = [];

    for $submatch<static_const> {

        my Bool $has-array-specifier = $_<array-specifier>:exists;

        my $type     = $_<type>.Str;
        my $name     = $_<name>.Str;
        my $rhs      = translate-static-const-rhs($_);
        my $comment  = $_<line-comment>:exists ?? "// {$_<line-comment><line-comment-text>.Str}" !! "";

        my TypeInfo $info = populate-typeinfo($type);
        my TypeAux  $aux  = get-type-aux($_);
        my $rtype = get-augmented-rust-type($info, $aux);

        #my $rtype = %*typemap{$type};

        my $rust = qq:to/END/.chomp.trim;
        pub const {$name}: $rtype = {$rhs}; {$comment.chomp.trim}
        END
        @items.push: $rust;
    }
    @items.join("\n\n").chomp.trim
}
