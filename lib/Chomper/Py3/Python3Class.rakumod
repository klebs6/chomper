use snake-case;
use avoid-keywords;
use python3-comment;
use doxy-comment;
use pyrust;
use formatting;
use case;
use wrap-body-todo;
use indent-rust-named-type-list;
use python3-suite;
use python3-compound;
use python3-func;
use python3-lambdef;
use python3-dunder;

our class Python3::Classdef 
does Python3::ICompoundStmt
{
    has Python3::Name    $.name is required;
    has Python3::Suite   $.suite is required is rw;
    has Python3::ArgList $.arglist;
    has Python3::Comment $.comment;

    method rust-struct-name {
        $.name.value
    }

    method rust-comment-from-suite {
        extract-rust-comment-from-suite(
            $.suite, 
            extra => self.toplevel-rust-comment()
        )
    }

    method rust-toplevel-comments {
        my (
        $toplevel-assignments, 
        $misc-class-stmts,
        $toplevel-comments) = self.toplevel-stmts();

        do for $toplevel-comments.List {
            $_.text.subst(/^'#'/,"") ~ "\n"
        }.join("\n")
    }

    method toplevel-rust-comment {

        if $.comment {
            qq:to/END/
                Note: comment on python class: {$.comment.text}
            END
        } else {
            ""
        }
    }

    method rust-struct-args {
    
        if $.arglist {
            my $count = $.arglist.count();

            #we may need to handle this case in
            #future, but not now
            die if not $.arglist.basic-args.elems eq $count;

            my $idx = 0;
            my @rust-struct-args;

            for $.arglist.basic-args -> $basic-arg {

                given $basic-arg {

                    when Python3::Argument {
                        my $name = $_.test.operands[0].value;
                        @rust-struct-args.push: "base{$idx++}: $name";
                    }
                    when Python3::DefaultArgument {
                        my $name    = $_.base.operands[0].value;
                        my $default = $_.default.operands[0].value;
                        @rust-struct-args.push: "base{$idx++}: $name /*default = $default*/";
                    }

                    default {
                        say $basic-arg.WHAT;
                        die "need to handle these eventually";
                    }
                }
            }

            @rust-struct-args

        } else {
            []
        }
    }

    method rust-struct-members-from-python-funcdefs {
        my @members = do-rust-struct-members-from-python-funcdefs(self);
        @members
    }

    method rust-module-members( --> Array ) {
        #basically want anything in the class body
        #which is not a function

        my @test-scaffolds = 
        self.rust-test-scaffolds(); 

        [ |@test-scaffolds ]
    }

    method rust-module {
        my @module-members = self.rust-module-members();
        if @module-members.elems {
            qq:to/END/
            pub mod {self.rust-struct-name-as-module()} \{
            {@module-members.join("\n").indent(4)}
            \}
            END
        }
    }

    method python-class-functions {
        toplevel-standard-python-functions($.suite)
    }

    method python-test-functions {
        toplevel-python-test-functions($.suite)
    }

    method python-class-special-functions {
        toplevel-dunder-functions($.suite)
    }

    method rust-function-scaffolds {

        do for self.python-class-functions().List 
        -> $py-func {
            given $py-func {
                when Python3::FuncDef {
                    $py-func.get-rust-scaffold(python-decorators => [])
                }
                when Python3::DecoratedFunction {
                    $py-func.get-rust-scaffold(python-decorators => [])
                }
            }
        }
    }

    method rust-test-scaffolds {

        do for self.python-test-functions().List 
        -> $py-func {
            $py-func.get-rust-scaffold(python-decorators => [])
        }
    }

    method rust-special-functions {

        do for self.python-class-special-functions().List 
        -> $py-func {
            $py-func.translate-special-function-to-rust($.name.value)
        }
    }

    method toplevel-stmts {

        my @toplevel-assignments;
        my @misc-class-stmts;
        my @toplevel-comments;

        do if $.suite ~~ Python3::StmtSuite {
            @toplevel-comments = $.suite.comments;

            #this will ignore Classdef and
            #Funcdef, just taking SimpleSuite
            do for $.suite.stmts.List -> $stmt-with-comments {

                my @comments = $stmt-with-comments.comments;

                if @comments.elems {
                    my $body = @comments>>.text.subst(/^'#'/,"").join("\n");
                    my $comment  = "/*" ~ $body ~ "*/";
                    @toplevel-assignments.push: $comment;
                }

                my $stmt     = $stmt-with-comments.stmt;

                given $stmt {
                    when Python3::SimpleSuite {
                        my $small-stmt = $_.stmts[0];
                        if $small-stmt ~~ Python3::ExprEquals {
                            @toplevel-assignments.push: $small-stmt;
                        } else {
                            unless $stmt ~~ Python3::Pass {
                                @misc-class-stmts.push: $small-stmt;
                            }
                        }
                    }
                    when Python3::Comment {
                        @toplevel-assignments.push: $_;
                    }
                }
            }
        }

        (@toplevel-assignments, @misc-class-stmts, @toplevel-comments)
    }

    method rust-static-members {

        my (
        $toplevel-assignments, 
        $misc-class-stmts,
        $toplevel-comments) = 
        self.toplevel-stmts();

        my @lines;

        multi sub process(Python3::ExprEquals $x) {
            $x.text
        }

        multi sub process(Python3::Comment $x) {
            $x.text
        }

        for $toplevel-assignments.List {
            my $text = process($_);
            @lines.push: $text;
        }

        my $text = @lines.join("\n").indent(4);

        if $toplevel-assignments.List.elems {
            qq:to/END/.chomp
            lazy_static!\{

                /*
            $text
                */
            \}
            END
        }
    }

    method misc-class-stmts {
        my (
        $toplevel-assignments, 
        $misc-class-stmts,
        $toplevel-comments) = self.toplevel-stmts();

        if $misc-class-stmts.List.elems {
            create-rust-function(
                python                => True,
                comment               => "//this was toplevel code in the python class",
                is-test               => False,
                private               => False,
                name                  => "class_single_initialization",
                rust-args             => "",
                optional-initializers => "",
                body                  => $misc-class-stmts.List.map({ .text }).join("\n")
            )
        }
    }

    method translate-to-rust {

        my $comment                = self.rust-comment-from-suite();
        my $parsed-comment         = parse-python-doc-comment($comment);
        my $rust-comment           = as-rust-comment($parsed-comment, backup => $comment);

        if so !$rust-comment {
            $rust-comment = "//---------------------------";
        }

        my $rust-struct-name = snake-to-camel(self.rust-struct-name());

        my @rust-struct-args = [
            |self.rust-struct-args(),
            |self.rust-struct-members-from-python-funcdefs(),
        ];

        my @rust-member-function-scaffolds = self.rust-function-scaffolds();

        my @rust-impls = [
            |@rust-member-function-scaffolds,
        ];

        my @rust-special-functions = self.rust-special-functions();

        my @rust-test-scaffolds    = self.rust-test-scaffolds();

        my @rust-static-members    = [
            |self.rust-static-members(),
        ];

        my @rust-misc-class-stmts  = [
            |self.misc-class-stmts(),
        ];

        #---------------------
        my Bool $need-impl-block = @rust-impls.elems gt 0;

        my Bool $need-specials   = @rust-special-functions.elems gt 0;

        my Bool $need-struct-def = so [
            @rust-struct-args.elems       gt 0,
            @rust-special-functions.elems gt 0,
            $need-impl-block,
        ].any;

        my Bool $need-module = so [
            @rust-test-scaffolds.elems   gt 0,
            @rust-static-members.elems   gt 0,
            @rust-misc-class-stmts.elems gt 0,
        ].any;

        if not so [$need-module, $need-struct-def].any {
            $need-struct-def = True;
        }

        my Bool $attach-comment-to-module = !$need-struct-def && $need-module;

        my Bool $solo-test-module = so [
            $need-module,
            !$need-impl-block,
            !$need-specials,
            !$need-struct-def,
            @rust-test-scaffolds.elems gt 0,
        ].all;

        if $need-impl-block {
            die if not $need-struct-def;
        }

        #-----------------------------
        my $struct-def = !$need-struct-def ?? "" !!
        create-rust-struct-def(
            comment     => $need-struct-def ?? $rust-comment !! Nil,
            struct-name => $rust-struct-name,
            struct-args => @rust-struct-args,
        );

        my $module = !$need-module ?? "" !!
        create-rust-module(
            comment          => $attach-comment-to-module ?? $rust-comment !! Nil,
            struct-name      => $rust-struct-name,
            test-scaffolds   => @rust-test-scaffolds,
            misc-class-stmts => @rust-misc-class-stmts,
            static-members   => @rust-static-members,
            :$solo-test-module,
        );

        my $special-functions = !$need-specials ?? "" !!
        create-rust-specials(
            struct-name  => $rust-struct-name,
            stmts        => @rust-special-functions,
        );

        my $impl-block = !$need-impl-block ?? "" !!
        create-rust-impl-block(
            struct-name => $rust-struct-name,
            impls       => @rust-impls,
        );

        #---------------------
        my $result = qq:to/END/.chomp;
        $struct-def
        $module
        $special-functions
        $impl-block
        END

        collapse-double-newlines($result)
    }
}

our class Python3::DecoratedClass does Python3::ICompoundStmt  {
    has Python3::Decorator @.decorators is required;
    has Python3::Classdef  $.decorated  is required;
}

our sub do-rust-struct-members-from-python-funcdefs(Python3::Classdef $self) {

    my @funcdefs = [
        |toplevel-python-functions($self.suite),
        |$self.python-class-special-functions(),
        |$self.python-test-functions(),
    ];

    my $seen = SetHash.new;
    my @struct-members;

    sub get-member-name($augmented-atom) {
        avoid-keywords($augmented-atom.trailers[0].name.value)
    }


    sub infer-rust-type($rhs) {
        if $rhs ~~ Python3::Lambdef {
            lambda-to-rust-type($rhs)

        } else {
            pymodel-to-rust-type($rhs.operands[0])

        }
    }

    sub process-self-atom($atom, $rhs) {
        my $name      = get-member-name($atom);
        my $rust-type = infer-rust-type($rhs);

        if $name !(elem) $seen {
            $seen.set($name);
            @struct-members.push: "$name: $rust-type";
        }
    }

    multi sub handle(Python3::ISmallStmt $stmt) {
        given $stmt {

            #perhaps these two cases can be abstracted
            when Python3::ExprEquals {

                my $expr-equals = $_;

                sub do-thing($lhs) {

                    if $lhs.operands.elems eq 1 {
                        my $op0 = $lhs.operands[0];
                        my $rhs = $expr-equals.rhs-stack[0];
                        if $rhs {
                            given $op0 {
                                when Python3::AugmentedAtom {
                                    given $_.atom {
                                        when Python3::Name {
                                            if $_.value ~~ "self" {
                                                process-self-atom($op0, $rhs[0]);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                my $lhs = $expr-equals.lhs;

                given $lhs {
                    when Python3::TestListStarExpr {
                        for $_.test-or-star-exprs  -> $lhs {
                            do-thing($lhs)
                        }
                    }
                    default {
                        do-thing($lhs)
                    }
                }
            }
            when Python3::ExprAugAssign {
                my $op0 = $_.lhs.operands[0];
                my $rhs = $_.rhs;
                given $op0 {
                    when Python3::AugmentedAtom {
                        given $_.atom {
                            when Python3::Name {
                                if $_.value ~~ "self" {
                                    process-self-atom($op0, $rhs.tests[0]);
                                }
                            }
                        }
                    }
                }
            }
            default {
                #do nothing
            }
        }
    }

    #----------------------[compound]
    multi sub handle(Python3::With $stmt) {
        handle($stmt.suite);
    }

    multi sub handle(Python3::While $stmt) {

        handle($stmt.suite);

        so $stmt.else and handle($stmt.else.suite);
    }

    multi sub handle(Python3::For $stmt) {

        handle($stmt.suite);

        if $stmt.else {
            handle($_.else.suite);
        }
    }

    multi sub handle(Python3::Try $stmt) {

        handle($stmt.suite);

        given $stmt.control-suite {
            when Python3::ExceptSuite {
                for $_.clauses {
                    handle($_.suite);
                }
                so $_.else and handle($_.else.suite);
                so $_.finally and handle($_.finally.suite);
            }
            when Python3::Finally {
                handle($_.suite);
            }
        }
    }

    multi sub handle(Python3::If $stmt) {

        handle($stmt.suite);

        for $stmt.elif-suites {
            handle($_.suite);
        }

        so $stmt.else-suite and handle($stmt.else-suite.suite);
    }

    multi sub handle(Python3::FuncDef $stmt) {
        handle($stmt.suite);
    }

    multi sub handle(Python3::DecoratedFunction $stmt) {
        handle($stmt.decorated.suite);
    }

    multi sub handle(Python3::Classdef $stmt) {
        handle($stmt.suite);
    }

    multi sub handle(Python3::SimpleSuite $stmt) {
        for $stmt.stmts -> $child {
            handle($child);
        }
    }

    multi sub handle(Python3::StmtWithComments $stmt) {
        handle($stmt.stmt);
    }

    multi sub handle(Python3::Comment $stmt) { }

    multi sub handle(Python3::StmtSuite $stmt) {
        for $stmt.stmts -> $child {
            handle($child);
        }
    }

    for @funcdefs.List -> $funcdef {
        given $funcdef {
            when Python3::DecoratedFunction {
                for $funcdef.decorated.suite.stmts -> $stmt {
                    handle($stmt);
                }
            }
            when Python3::FuncDef {
                for $funcdef.suite.stmts -> $stmt {
                    handle($stmt);
                }
            }
        }
    }

    @struct-members
}
