use python3-stmt;
use python3-prelude;

our role Python3::Suite { }

our class Python3::SimpleSuite 
does Python3::Suite 
does Python3::IStmt  {
    has Python3::ISmallStmt @.stmts is required;
    has Python3::Comment    @.comments;
    has Str $.text is required is rw;

    method recalculate-text {  
        $.text = @.stmts>>.text.join("\n")
    }
}

our class Python3::StmtSuite does Python3::Suite  {
    has Python3::Comment          @.comments;
    has Python3::StmtWithComments @.stmts is required;
    has Str $.text is required is rw;

    method recalculate-text {  
        $.text = @.stmts>>.text.join("")
    }
}

#---------------------------------------
#TODO: might need to be more robust
our sub extract-rust-comment-from-suite($suite is rw, :$extra = "") {

    my $first-stmt = $suite.stmts[0].stmt;

    if $first-stmt ~~ Python3::SimpleSuite {

        my $comments = $first-stmt.comments>>.text>>.subst(/^'#'/,"")>>.indent(8).join("\n");
        $first-stmt = $first-stmt.stmts[0];

        if $first-stmt ~~ Python3::ExprEquals {

            my $lhs = $first-stmt.lhs;

            if $lhs ~~ Python3::IOrExpr {

                my $first-lhs-operand = $lhs.operands[0];
                if $first-lhs-operand ~~ Python3::Strings {
                    my $text = $first-lhs-operand.items.join("\n");
                    $suite.stmts = $suite.stmts[1..*];
                    $suite.recalculate-text();

                    return qq:to/END/.chomp;
                    $text
                    $extra
                    $comments
                    END
                } 
            }
        } 
    }

    ""
}
