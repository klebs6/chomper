use snake-case;
use case;
use wrap-body-todo;
use indent-rust-named-type-list;

our sub collapse-double-newlines($text) {
    $text.subst(:g, "\n\n","\n")
}

our sub convert-type-to-rust($type) {

    my %typemap = %(
        float => "f32",
    );

    %typemap{$type} // $type
}

our sub create-function(
    Str :$comment,
    Bool :$private,
    Str  :$name,
    Str  :$rust-args,
    :$optional-initializers,
    Str  :$body) {
    qq:to/END/

    {$comment}
    {$private ?? "" !! "pub"} fn {$name}($rust-args) \{
        {$optional-initializers}
        {wrap-body-todo($body, python => True)}
    \}
    END
}

our role Python3::IFuncDef    {  }

our class Python3::FuncDef        { ... } # fwd declare
our role Python3::IDunderFunc     { ... } # fwd declare
our class Python3::Tfpdef          { ... } # fwd declare
our class Python3::AugmentedTfpdef { ... } # fwd declare

#----------------
our role Python3::ISubscript      
{ }

our role Python3::ITestListStarExpr  {}

our role Python3::ITestOrStarExpr 
does Python3::ITestListStarExpr
{ }

our role Python3::IArgument {}

our role Python3::ITest
does Python3::ISubscript
does Python3::ITestOrStarExpr { }

our role Python3::ITestNoCond     
{ }


our role Python3::IDecoratedItem  
{ }

our role Python3::IArithOperand   
{ }

our role Python3::ITermOperand    
{ }

our role Python3::IDictOrSet      
{ }

our role Python3::IParensInner    
{ }

our role Python3::IListMaker
does Python3::IParensInner { }

our role Python3::IStmt           
{ }

our role Python3::ISmallStmt
does Python3::IStmt { }

our role Python3::ICompoundStmt
does Python3::IStmt { }

our role Python3::ITrailer        
{ }

our role Python3::ShiftOperand    
{ }

our role Python3::CompIter        
{ }

our role Python3::Suite           
{ 
    method toplevel-standard-python-functions { ... }
    method toplevel-python-test-functions { ... }
    method toplevel-dunder-functions { ... }
    method toplevel-python-functions { ... }
}

our role Python3::TryControlSuite 
{ }

our role Python3::WithItem        
{ }

our role Python3::IOrTest 
does Python3::ITest 
does Python3::ITestNoCond { }

our role Python3::IAndTest 
does Python3::IOrTest {}

our role Python3::INotTest 
does Python3::IAndTest {}

our role Python3::IComparison 
does Python3::INotTest {}

our role Python3::IStarExpr 
does Python3::IComparison {}

our role Python3::IOrExpr         
does Python3::IStarExpr
{ }

our role Python3::IXorExpr
does Python3::IOrExpr { }

our role Python3::IAndExpr
does Python3::IXorExpr { }

our role Python3::IShiftExpr
does Python3::IAndExpr { }

our role Python3::IArithExpr
does Python3::IShiftExpr { }

our role Python3::ITerm
does Python3::IArithExpr { }

our role Python3::IFactor
does Python3::ITerm { }

our role Python3::IPower
does Python3::IFactor { }

our role Python3::IAugmentedAtom
does Python3::IPower { }

our role Python3::IAtom
does Python3::IAugmentedAtom { }


#-----------------------------
our class Python3::Comment  {
    has Str $.text is required;
}

our class Python3::Strings   does Python3::IAtom  { has Str @.items is required; }
our class Python3::Name      does Python3::IAtom  { has Str $.value is required; }
our class Python3::Ellipsis  does Python3::IAtom  {}
our class Python3::False     does Python3::IAtom  { has Str $.value = "false" }
our class Python3::True      does Python3::IAtom  { has Str $.value = "true" }
our class Python3::None      does Python3::IAtom  { has Str $.value = "None" }
our class Python3::Integer   does Python3::IAtom  { has Str $.value is required; }
our class Python3::Float     does Python3::IAtom  { has Str $.value is required; }
our class Python3::Imaginary does Python3::IAtom  { has Str $.value is required; }

#-----------------------------
our class Python3::DotName does Python3::ITrailer  {
    has Python3::Name $.name is required;
}

our class Python3::SliceOp  {
    has Python3::ITest $.test;
}

our class Python3::Slice does Python3::ISubscript  {
    has Python3::ITest    $.test0;
    has Python3::ITest    $.test1;
    has Python3::SliceOp  $.slice-op;
}

our class Python3::SubscriptList does Python3::ITrailer  {
    has Python3::ISubscript @.items;
}

#-----------------------------
our class Python3::AugmentedAtom 
does Python3::IAugmentedAtom  {
    has Python3::IAtom    $.atom is required;
    has Python3::ITrailer @.trailers is required;
}

our class Python3::PlusFactor does Python3::IFactor  {
    has Python3::IFactor $.factor is required;
}

our class Python3::MinusFactor does Python3::IFactor  {
    has Python3::IFactor $.factor is required;
}

our class Python3::TildeFactor does Python3::IFactor  {
    has Python3::IFactor $.factor is required;
}

#----------------------
our class Python3::StarOperand does Python3::ITermOperand  {
    has Python3::IFactor $.factor is required;
}

our class Python3::DivOperand does Python3::ITermOperand  {
    has Python3::IFactor $.factor is required;
}

our class Python3::ModOperand does Python3::ITermOperand  {
    has Python3::IFactor $.factor is required;
}

our class Python3::DoubleDivOperand does Python3::ITermOperand  {
    has Python3::IFactor $.factor is required;
}

our class Python3::AtOperand does Python3::ITermOperand  {
    has Python3::IFactor $.factor is required;
}

#----------------------
our class Python3::Power 
does Python3::IPower  {
    has Python3::IAugmentedAtom $.base is required;
    has Python3::IFactor        $.power;
}

our class Python3::Term 
does Python3::ITerm  {
    has Python3::IFactor      $.lhs  is required;
    has Python3::ITermOperand @.operands is required;
}

our class Python3::PlusOperand does Python3::IArithOperand  {
    has Python3::ITerm    $.term is required;
}

our class Python3::MinusOperand does Python3::IArithOperand  {
    has Python3::ITerm    $.term is required;
}

our class Python3::ArithExpr does Python3::IArithExpr  {
    has Python3::ITerm         $.lhs is required;
    has Python3::IArithOperand @.operands is required;
}


our class Python3::LeftShiftOperand 
does Python3::ShiftOperand  {
    has Python3::IArithExpr $.expr is required;
}

our class Python3::RightShiftOperand 
does Python3::ShiftOperand  {
    has Python3::IArithExpr $.expr is required;
}

our class Python3::ShiftExpr does Python3::IShiftExpr  {
    has Python3::IArithExpr   $.lhs is required;
    has Python3::ShiftOperand @.operands is required;
}

our class Python3::AndExpr does Python3::IAndExpr  {
    has Python3::IShiftExpr @.operands is required;
}

our class Python3::XorExpr does Python3::IXorExpr  {
    has Python3::IAndExpr @.operands is required;
}

our class Python3::OrExpr 
does Python3::ITest
does Python3::IOrExpr  {
    has Python3::IXorExpr @.operands is required;
}

our class Python3::StarExpr 
does Python3::IStarExpr
does Python3::ITestOrStarExpr  {
    has Bool             $.has-star is required;
    has Python3::IOrExpr $.or-expr  is required;
}

our class Python3::TestListStarExpr  
does Python3::ITestListStarExpr
{
    has Python3::ITestOrStarExpr @.test-or-star-exprs is required;
}

our class Python3::ExprList  {
    has Python3::IStarExpr @.items is required;
}

our class Python3::CompOp  {
    has Str $.op is required;
}

our class Python3::ComparisonOperand {
    has Python3::CompOp   $.comp-op is required;
    has Python3::IStarExpr $.star-expr is required;
}

our class Python3::Comparison 
does Python3::IComparison
does Python3::ITest {
    has Python3::IStarExpr          $.base     is required;
    has Python3::ComparisonOperand @.operands is required;
}

our class Python3::NotTest 
does Python3::INotTest  {
    has Int $.not-count is required;
    has Python3::IComparison $.comparison is required;
}

our class Python3::AndTest 
does Python3::IAndTest  
{
    has Python3::INotTest @.operands is required;
    has Python3::Comment @.comments;
}

our class Python3::OrTest 
does Python3::IOrTest 
 {
    has Python3::IAndTest @.operands is required;
    has Python3::Comment @.comments;
}


#-----------------------------
our class Python3::CompIf does Python3::CompIter  {
    has Python3::ITestNoCond $.test-nocond is required;
    has Python3::CompIter   $.comp-iter;
}

our class Python3::CompFor 
does Python3::CompIter  {
    has Python3::ExprList $.exprlist is required;
    has Python3::IOrTest   $.or-test  is required;
    has Python3::CompIter $.comp-iter;
}

#----------------------------
our class Python3::ParensAtom does Python3::IAtom  {
    has Python3::IParensInner $.value is required;
    has Python3::Comment      @.comments;
}

our class Python3::TestList does Python3::IListMaker  {
    has Python3::ITest @.tests;
}

our class Python3::MaybeCommentedTest does Python3::ITest  {
    has Python3::ITest   $.test is required;
    has Python3::Comment @.comment;
}

our class Python3::ListComp does Python3::IListMaker  {
    has Python3::ITest   $.test is required;
    has Python3::CompFor $.comp is required;
}

our class Python3::ListAtom does Python3::IAtom  {
    has Python3::IListMaker $.value is required;
    has Python3::Comment    @.comments;
}

our class Python3::DictAtom does Python3::IAtom  {
    has Python3::IDictOrSet $.value is required;
    has Python3::Comment    @.comments;
}

our class Python3::DictMakerItem  {
    has Python3::Comment $.comments;
    has Python3::ITest   $.K is required;
    has Python3::ITest   $.V is required;
}

our class Python3::Dict      does Python3::IDictOrSet  {
    has Python3::DictMakerItem @.items;
}

our class Python3::SetMakerItem  {
    has Python3::Comment $.comments;
    has Python3::ITest   $.K         is required;
    has Bool             $.has-stars is required;
}

our class Python3::DictComp  does Python3::IDictOrSet  {
    has Python3::DictMakerItem $.item is required;
    has Python3::CompFor       $.comp is required;
}

our class Python3::SetComp  does Python3::IDictOrSet  {
    has Python3::SetMakerItem $.item is required;
    has Python3::CompFor      $.comp is required;
}

our class Python3::Set       does Python3::IDictOrSet  {

}

#----------------------------
our class Python3::VfpDef  {
    has Python3::Name  $.name is required;
    has Python3::ITest $.test;
}

our class Python3::VarArgsList  {
    has Python3::VfpDef @.basic-args;
    has Python3::VfpDef @.star-args;
    has Python3::VfpDef @.kwargs;
}

our class Python3::Lambdef does Python3::ITest  {
    has Python3::ITest       $.test       is required;
    has Python3::VarArgsList $.varargslist;
}

our class Python3::LambdefNoCond 
does Python3::ITest 
does Python3::ITestNoCond  {
    has Python3::ITestNoCond  $.test-nocond is required;
    has Python3::VarArgsList $.varargslist;
}

our class Python3::TernaryOperator does Python3::ITest  {
    has $.A    is required;
    has $.cond is required;
    has $.B    is required;
}

#-------------------------
our class Python3::CommentedArgument does Python3::IArgument {
    has Python3::IArgument $.argument is required;
    has Python3::Comment   @.comments;
}

our class Python3::Argument does Python3::IArgument {
    has Python3::ITest $.test;
}

our class Python3::DefaultArgument does Python3::IArgument {
    has Python3::ITest $.base;
    has Python3::ITest $.default;
}

our class Python3::CompForArgument does Python3::IArgument {
    has Python3::ITest    $.test;
    has Python3::CompFor $.comp-for;
}


our class Python3::ArgList does Python3::ITrailer  {
    has Python3::IArgument @.basic-args;
    has Python3::IArgument @.star-args;
    has Python3::IArgument @.kwargs;

    method count( --> Int) {
        [+] [
            @.basic-args,
            @.star-args,
            @.kwargs,
        ].map: {.elems}
    }

    method  {
        my @basic-rust = do for @.basic-args {
            my $rust-arg = $_.as-rust()
        };

        my @star-rust = do for @.basic-args {
            my $rust-arg = $_.as-rust()
        };

    }
}

our class Python3::ImportDots  {
    has Bool $.plural is required;
}

our class Python3::DottedName  {
    has Python3::Name @.names is required;
}

our class Python3::DottedAsName  {
    has     $.name is required;
    has Str $.as;
}

our class Python3::ImportFromSrc  {
    has Python3::ImportDots @.dot-stack;
    has Python3::DottedName $.name;
}

our class Python3::ImportAsName  {
    has Str $.name is required;
    has Str $.as;
}

our class Python3::ImportFromTarget  {
    has Bool $.glob is required;
    has Python3::Comment      $.comment;
    has Python3::ImportAsName @.names;
}

our class Python3::YieldArg  { 
    has $.from;
    has $.testlist;
}

our class Python3::YieldExpr does Python3::IParensInner  {
    has Python3::YieldArg $.arg;
}

#------------------------------------
our class Python3::ExprEquals does Python3::ISmallStmt  {
    has $.lhs       is required;
    has @.rhs-stack is required;
    has Str $.text is required;

    method is-assign-to-self( --> Bool ) {
        self.lhs.operands[0]
    }
}

our sub assign-item-to-lhs(:$lhs, :$item) {
    "assignment, {:$lhs.gist}, {:$item.gist}"
}

our class Python3::ExprAugAssign does Python3::ISmallStmt  {
    has $.lhs is required;
    has $.op  is required;
    has $.rhs is required;
    has Str $.text is required;
}

our class Python3::Return does Python3::ISmallStmt  {
    has Python3::TestList $.testlist;
    has Str $.text is required;
}

our class Python3::RaiseClause does Python3::ISmallStmt  {
    has Python3::ITest $.test is required;
    has Python3::ITest $.from;
}

our class Python3::Raise does Python3::ISmallStmt  {
    has Python3::RaiseClause $.clause;
    has Str $.text is required;
}

our class Python3::ImportName does Python3::ISmallStmt  {
    has Python3::DottedAsName @.names is required;
    has Str $.text is required;
}

our class Python3::Nonlocal does Python3::ISmallStmt  {
    has Str @.names is required;
    has Str $.text is required;
}

our class Python3::Assert does Python3::ISmallStmt  {
    has @.tests is required;
    has Str $.text is required;
}

our class Python3::Pass     does Python3::ISmallStmt  { }

our class Python3::Break    does Python3::ISmallStmt  { }

our class Python3::Continue does Python3::ISmallStmt  { }

our class Python3::Yield does Python3::ISmallStmt  {
    has Python3::YieldExpr $.expr is required;
    has Str $.text is required;
}

our class Python3::ImportFrom does Python3::ISmallStmt  {
    has Python3::ImportFromSrc    $.src    is required;
    has Python3::ImportFromTarget $.target is required;
    has Str $.text is required;
}

our class Python3::Global does Python3::ISmallStmt  {
    has Str @.names is required;
    has Str $.text is required;
}

our class Python3::Del does Python3::ISmallStmt  {
    has @.exprs is required;
    has Str $.text is required;
}

#---------------------------------------
our class Python3::SimpleSuite 
does Python3::Suite 
does Python3::IStmt  {
    has Python3::ISmallStmt @.stmts is required;
    has Python3::Comment    $.comment;
    has Str $.text is required is rw;

    method toplevel-standard-python-functions { [] }
    method toplevel-python-test-functions { [] }
    method toplevel-dunder-functions { [] }
    method toplevel-python-functions { [] }

    method recalculate-text {  
        $.text = @.stmts>>.text.join("\n")
    }
}

our class Python3::StmtWithComments 
does Python3::IStmt  {
    has Python3::IStmt   $.stmt is required;
    has Python3::Comment @.comments is required;
    has Str $.text is required;
}

our class Python3::StmtSuite does Python3::Suite  {
    has Python3::StmtWithComments @.stmts is required;
    has Str $.text is required is rw;

    method recalculate-text {  
        $.text = @.stmts>>.text.join("")
    }

    method toplevel-python-functions {
        @.stmts.List.grep({ $_.stmt ~~ Python3::IFuncDef }).map: { $_.stmt }
    }

    method toplevel-standard-python-functions {
        @.stmts.List.grep({ 
            given $_.stmt {
                when Python3::FuncDef {
                    so !$_.is-test()
                }
                default {
                    False
                }
            }
        }).map: { $_.stmt }
    }

    method toplevel-python-test-functions {
        @.stmts.List.grep({ 
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

    method toplevel-dunder-functions {
        @.stmts.List.grep({ $_.stmt ~~ Python3::IDunderFunc }).map: { $_.stmt }
    }
}

#---------------------------------------
#TODO: might need to be more robust
our sub extract-rust-comment-from-suite($suite is rw, :$extra = "") {

    my $first-stmt = $suite.stmts[0].stmt;

    if $first-stmt ~~ Python3::SimpleSuite {

        $first-stmt = $first-stmt.stmts[0];

        if $first-stmt ~~ Python3::ExprEquals {
            my $first-lhs-operand = $first-stmt.lhs.operands[0];
            if $first-lhs-operand ~~ Python3::Strings {
                my $text = $first-lhs-operand.items.join("\n");
                $suite.stmts = $suite.stmts[1..*];
                $suite.recalculate-text();
                return qq:to/END/;
                /**
                $text
                {$extra}
                */
                END
            } 
        } 
    }

    ""
}

our class Python3::Classdef 
does Python3::ICompoundStmt
does Python3::IDecoratedItem  {
    has Python3::Name    $.name is required;
    has Python3::Suite   $.suite is required is rw;
    has Python3::ArgList $.arglist;
    has Python3::Comment $.comment;

    method rust-struct-name {
        $.name.value
    }

    method rust-comment-from-suite {
        extract-rust-comment-from-suite($.suite, extra => self.toplevel-rust-comment())
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

    method format-type-list(@list) {
        if @list.elems gt 0 {
            my $text = indent-rust-named-type-list(@list);
            $text.split("\n")>>.trim.join("\n")
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
        $.suite.toplevel-standard-python-functions()
    }

    method python-test-functions {
        $.suite.toplevel-python-test-functions()
    }

    method python-class-special-functions {
        $.suite.toplevel-dunder-functions()
    }

    method rust-function-scaffolds {

        do for self.python-class-functions().List 
        -> $py-func {
            $py-func.get-rust-scaffold()
        }
    }

    method rust-test-scaffolds {

        do for self.python-test-functions().List 
        -> $py-func {
            $py-func.name.value
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

        do if $.suite ~~ Python3::StmtSuite {

            #this will ignore Classdef and
            #Funcdef, just taking SimpleSuite
            do for $.suite.stmts.map: { .stmt } {
                given $_ {
                    when Python3::SimpleSuite {
                        my $stmt = $_.stmts[0];
                        if $stmt ~~ Python3::ExprEquals {
                            @toplevel-assignments.push: $stmt;
                        } else {
                            unless $stmt ~~ Python3::Pass {
                                @misc-class-stmts.push: $stmt;
                            }
                        }
                    }
                }
            }
        }

        (@toplevel-assignments, @misc-class-stmts)
    }

    method rust-static-members {

        my ($toplevel-assignments, $misc-class-stmts) = 
        self.toplevel-stmts();

        if $toplevel-assignments.List.elems {
            qq:to/END/.chomp
            lazy_static!\{

                /*
            {$toplevel-assignments.List>>.text.join("\n").indent(4)}
                */
            \}
            END
        }
    }

    method misc-class-stmts {
        my ($toplevel-assignments, $misc-class-stmts) = self.toplevel-stmts();
        if $misc-class-stmts.List.elems {
            create-function(
                comment               => "//this was toplevel code in the python class",
                private               => False,
                name                  => "class_single_initialization",
                rust-args             => "",
                optional-initializers => "",
                body                  => $misc-class-stmts.List.map({ .text }).join("\n")
            )
        }
    }

    method translate-to-rust {

        my $rust-comment     = self.rust-comment-from-suite();
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

        my @rust-static-members    = self.rust-static-members();

        my @rust-misc-class-stmts  = self.misc-class-stmts();

        #---------------------
        my Bool $need-impl-block = @rust-impls.elems gt 0;

        my Bool $need-specials   = @rust-special-functions.elems gt 0;

        my Bool $need-struct-def = so [
            @rust-struct-args.elems       gt 0,
            @rust-special-functions.elems gt 0,
            $need-impl-block,
        ].any;

        my Bool $need-module = so [
            @rust-test-scaffolds.elems gt 0,
            @rust-static-members.elems gt 0,
            @rust-misc-class-stmts.elems gt 0,
        ].any;

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

        sub create-rust-struct-def(
            :$comment,
            :$struct-name,
            :@struct-args) {
            qq:to/END/
            $comment
            pub struct $struct-name \{
            {self.format-type-list(@struct-args).indent(4)}
            \}
            END
        }

        sub format-static-members-for-module(@static-members) {
            @static-members>>.gist.join("\n")
        }

        sub format-misc-class-stmts-for-module(@misc-class-stmts) {
            @misc-class-stmts>>.gist.join("\n")
        }

        sub create-rust-module(
            :$comment,
            :$struct-name,
            :@test-scaffolds,
            :@misc-class-stmts,
            :@static-members,
            :$solo-test-module,
            ) {

            qq:to/END/
            {$comment ?? $comment !! "" }
            {$solo-test-module ?? "#[cfg(test)]" !! ""}
            pub mod {snake-case($struct-name)} \{
            {format-static-members-for-module(@static-members).indent(4)}
            {format-misc-class-stmts-for-module(@misc-class-stmts).indent(4)}
            {@test-scaffolds.join("\n").indent(4)}
            \}
            END
        } 

        sub create-special($struct-name, $stmt) {
            $stmt
        }

        sub create-specials(
            :$struct-name,
            :@stmts
            ) {
            do for @stmts {
                create-special($struct-name,$_)
            }.join("\n")
        }

        sub create-rust-impl-block(
            :$struct-name,
            :@impls
            ) {
            qq:to/END/
            impl $struct-name \{

            {@impls.join("\n").indent(4)}
            \}
            END
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
        create-specials(
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

our sub default-get-str($default) {
    $default.operands[0].value
}

our class Python3::TypedArgList  {
    has Python3::AugmentedTfpdef @.basic-args;
    has Python3::AugmentedTfpdef @.star-args;
    has Python3::Tfpdef          @.kw-args;

    method is-first-parameter-self( --> Bool ) {
        @.basic-args[0].is-self();
    }

    method convert-to-rust {

        my @rust-args = [
            |do for @.basic-args { $_.as-rust() }
            |do for @.star-args  { $_.as-rust(star => True) }
            |do for @.kw-args    { $_.as-rust(kw   => True) }
        ];
        indent-rust-named-type-list(@rust-args)
    }

    method optional-initializers {
        do for @.basic-args {

            if $_.default {
                my $default = default-get-str($_.default);
                my $name    = $_.tfpdef.name.value;

                "let {$_.as-rust(force-not-default => True)} = {$name}.unwrap_or($default);"
            }
        }
    }

    method count( --> Int ) {
        [+] [
            @.basic-args,
            @.star-args,
            @.kw-args,
        ].map: {.elems}
    }
}

#same members as FuncDef
our role Python3::IDunderFunc 
does Python3::ICompoundStmt 
does Python3::IFuncDef
does Python3::IDecoratedItem  {
    has Python3::Name  $.name is required;
    has Bool           $.private is required;
    has Bool           $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required;
    has Python3::ITest $.test;

    method translate-special-function-to-rust { ... }
}

our class Python3::FuncDef 
does Python3::ICompoundStmt 
does Python3::IFuncDef
does Python3::IDecoratedItem  {
    has Python3::Name  $.name is required;
    has Bool           $.private is required;
    has Bool           $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required is rw;
    has Python3::ITest $.test;

    method get-rust-scaffold {

        my $comment               = self.rust-comment-from-suite();
        my $optional-initializers = $.parameters ?? $.parameters.optional-initializers() !! "";
        my $body                  = $.suite.text;
        my $rust-args             = $.parameters ?? $.parameters.convert-to-rust() !! "";

        create-function(
            :$comment,
            :$.private,
            name => snake-case($.name.value),
            :$rust-args,
            :$optional-initializers,
            :$body)
    }

    method rust-comment-from-suite {
        extract-rust-comment-from-suite($.suite)
    }
}

our class Python3::DunderFunc::Init does Python3::IDunderFunc {

    method translate-as-default-fn($cls-name) {
        qq:to/END/
        impl Default for {$cls-name} \{

            fn default() -> Self \{
                {wrap-body-todo($.suite.text, python => True)}
            \}
        \}
        END
    }

    method translate-as-from-fn(
        $cls-name, 
        Python3::AugmentedTfpdef $src,
        $optional-initializers) 
    {
        my ($src-name, $src-type) = $src.tfpdef.as-rust-name-type(
            default => $src.default 
        );

        qq:to/END/
        impl From<$src-type> for {$cls-name} \{

            fn from({$src-name}: $src-type) -> Self \{
                $optional-initializers
                {wrap-body-todo($.suite.text, python => True)}
            \}
        \}
        END
    }

    method translate-as-standard-new-fn($cls-name) {
        "TODO: __init__ --> standard-new-fn"
    }

    method translate-dunder-init($cls-name) {

        die if not $.parameters.is-first-parameter-self();

        my $nargs = $.parameters.count();

        given $nargs {
            when 1 {
                self.translate-as-default-fn($cls-name)
            }
            when 2 {
                my $src = $.parameters.basic-args[1];
                my $optional-initializers = $.parameters.optional-initializers();
                self.translate-as-from-fn($cls-name, $src, $optional-initializers)
            }
            when 3..* {
                self.translate-as-standard-new-fn($cls-name)
            }
        }
    }

    method translate-special-function-to-rust($cls-name) {  
        self.translate-dunder-init($cls-name)
    }
}

our class Python3::DunderFunc::Repr does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Add  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Sub  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Mul  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Div  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

#---------------------------------
our class Python3::Elif  {
    has Python3::Comment @.comments;
    has Python3::ITest   $.test is required;
    has Python3::Suite   $.suite is required;
}

our class Python3::Else  {
    has                @.comments;
    has Python3::Suite $.suite is required;
}

our class Python3::If does Python3::ICompoundStmt  {
    has Python3::Comment $.comment;
    has Python3::ITest   $.test  is required;
    has Python3::Suite   $.suite is required;
    has Python3::Elif    @.elif-suites;
    has Python3::Else    $.else-suite;
}

our class Python3::Decorator  {
    has Python3::DottedName $.name is required;
    has Python3::Comment    $.comment;
    has Python3::ArgList    $.arglist;
}

our class Python3::Decorated does Python3::ICompoundStmt  {
    has Python3::Decorator      @.decorators is required;
    has Python3::IDecoratedItem $.decorated  is required;
}

our class Python3::For does Python3::ICompoundStmt  {
    has Python3::ExprList $.exprlist is required;
    has Python3::TestList $.testlist is required;
    has Python3::Suite    $.suite    is required;
    has Python3::Comment  $.comment;
    has Python3::Else     $.else;
}

our class Python3::While does Python3::ICompoundStmt  {
    has Python3::ITest   $.test  is required;
    has Python3::Suite   $.suite is required;
    has Python3::Comment @.comments;
    has Python3::Else    $.else;
}

#-----------------------------
our class Python3::ExceptClause  {
    has Python3::Comment @.comments;
    has Python3::Suite   $.suite is required;
}

our class Python3::Finally     does Python3::TryControlSuite  {
    has Python3::Comment @.comments;
    has Python3::Suite   $.suite is required;
}

our class Python3::ExceptSuite does Python3::TryControlSuite  {
    has Python3::Comment      @.comments;
    has Python3::ExceptClause @.clauses is required;
    has Python3::Else         $.else;
    has Python3::Finally      $.finally;
}

our class Python3::Try does Python3::ICompoundStmt  {
    has Python3::Comment         @.comments;
    has Python3::Suite           $.suite is required;
    has Python3::TryControlSuite $.control-suite  is required;
}

#-----------------------------
our class Python3::WithItemBasic does Python3::WithItem  { 
    has Python3::ITest $.test is required;
}

our class Python3::WithItemAs    does Python3::WithItem  { 
    has Python3::ITest   $.test is required;
    has Python3::IOrExpr $.or-expr is required;
}

our class Python3::With does Python3::ICompoundStmt  {
    has Python3::Comment  @.comments;
    has Python3::Suite    $.suite is required;
    has Python3::WithItem @.with-items is required;
}

our sub pymodel-to-rust-type($x) {
    given $x {
        when Python3::Name      { "PyObj" }
        when Python3::Strings   { "String" }
        when Python3::False     { "bool" }
        when Python3::True      { "bool" }
        when Python3::Float     { "f32" }
        when Python3::Imaginary { "Complex" }
        when Python3::None      { "PyObj" }
        when Python3::Integer   { "i32" }
        when Python3::OrExpr    { pymodel-to-rust-type($_.operands[0]) }
        default                 { "PyObj" }
    }
}

our class Python3::Tfpdef  {
    has Python3::Name  $.name is required;
    has Python3::ITest $.type;

    method as-rust-name-type(:$default, Bool :$star, Bool :$kw ) {

        if $star {
            return [
                $.name.value,
                "&\[&PyObj\]"
            ];
        }

        if $kw {
            return [
                $.name.value,
                "HashMap<&str,PyObj>"
            ];
        }

        my $type = do if so $.type {

            convert-type-to-rust($.type)

        } else {

            $default 
            ?? pymodel-to-rust-type($default)
            !! 'PyObj'

        };

        [
            $.name.value,
            $type
        ]
    }

    method as-rust(:$default = Nil, :$force-not-default, :$star = False, :$kw = False) {
        my ($name, $type) = self.as-rust-name-type(:$default, :$star, :$kw);
        $default && !$force-not-default
        ??  "$name: Option<$type>"
        !!  "$name: $type"
    }
}

our class Python3::AugmentedTfpdef  {

    has Python3::Tfpdef  $.tfpdef is required;
    has Python3::ITest   $.default is required;
    has Python3::Comment @.comments;

    method is-self( --> Bool ) {
        $.tfpdef.name.value eq "self"
    }

    method as-rust( :$force-not-default = False, :$star = False, :$kw = False ) {
        if self.is-self() {
            "&mut self"
        } else {
            $.default
            ?? $.tfpdef.as-rust(:$.default, :$force-not-default, :$star, :$kw)
            !! $.tfpdef.as-rust(default => Nil, :$force-not-default, :$star, :$kw)
        }
    }
}

#----------------------------------------
our sub do-rust-struct-members-from-python-funcdefs(Python3::Classdef $self) {

    my @funcdefs = $self.suite.toplevel-python-functions();

    my $seen = SetHash.new;
    my @struct-members;

    sub get-member-name($augmented-atom) {
        $augmented-atom.trailers[0].name.value
    }


    sub infer-rust-type($rhs) {
        pymodel-to-rust-type($rhs.operands[0])
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

                #TODO: need handle testlist-star-expr

                if $expr-equals.lhs.operands.elems eq 1 {
                    my $op0 = $expr-equals.lhs.operands[0];
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
        handle($stmt.stmt);
    }

    multi sub handle(Python3::Classdef $stmt) {
        handle($stmt.stmt);
    }

    multi sub handle(Python3::SimpleSuite $stmt) {
        for $stmt.stmts -> $child {
            handle($child);
        }
    }

    multi sub handle(Python3::StmtWithComments $stmt) {
        handle($stmt.stmt);
    }

    multi sub handle(Python3::StmtSuite $stmt) {
        for $stmt.stmts -> $child {
            handle($child);
        }
    }

    for @funcdefs.List -> $funcdef {
        for $funcdef.suite.stmts -> $stmt {
            handle($stmt);
        }
    }

    @struct-members
}
