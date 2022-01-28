use JSON::Class;

our role Python3::ISubscript  { }
our role Python3::ITestOrStarExpr  { }

our role Python3::ITest 
does Python3::ISubscript 
does Python3::ITestOrStarExpr
 {}

our role Python3::ITestNoCond  {}

our role Python3::IOrExpr  {}

our role Python3::IXorExpr 
does Python3::IOrExpr  {}

our role Python3::IAndExpr 
does Python3::IXorExpr  {}

our role Python3::IShiftExpr 
does Python3::IAndExpr  {}

our role Python3::IArithExpr 
does Python3::IShiftExpr  {}

our role Python3::ITerm 
does Python3::IArithExpr  {}

our role Python3::IFactor 
does Python3::ITerm  {}

our role Python3::IPower 
does Python3::IFactor  {}

our role Python3::IAugmentedAtom 
does Python3::IPower  {}

our role Python3::IAtom 
does Python3::IAugmentedAtom  {}

our role Python3::IDecoratedItem  {}
our role Python3::IArithOperand  {}
our role Python3::ITermOperand  {}
our role Python3::IDictOrSet  {}
our role Python3::IParensInner  {}
our role Python3::IListMaker does Python3::IParensInner  {}

our role Python3::IStmt  { }
our role Python3::ISmallStmt    does Python3::IStmt  { }
our role Python3::ICompoundStmt does Python3::IStmt  { }

our role Python3::ITrailer  { }

#-----------------------------
our class Python3::Comment  {
    has Str $.text is required;
}

our class Python3::Strings   does Python3::IAtom  { has Str @.items is required; }
our class Python3::Name      does Python3::IAtom  { has Str $.value is required; }
our class Python3::Ellipsis  does Python3::IAtom  {}
our class Python3::False     does Python3::IAtom  {}
our class Python3::True      does Python3::IAtom  {}
our class Python3::None      does Python3::IAtom  {}
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

our role Python3::ShiftOperand  { }

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

our class Python3::OrExpr does Python3::IOrExpr  {
    has Python3::IXorExpr @.operands is required;
}

our class Python3::StarExpr does Python3::ITestOrStarExpr  {
    has Bool            $.has-star is required;
    has Python3::IOrExpr $.or-expr  is required;
}

our class Python3::TestListStarExpr  {
    has Python3::ITestOrStarExpr @.test-or-star-exprs is required;
}

our class Python3::ExprList  {
    has Python3::StarExpr @.items is required;
}

our class Python3::CompOp  {
    has Str $.op is required;
}

our class Python3::Comparison does Python3::ITest  {
    has Python3::StarExpr @.star-exprs is required;
    has Python3::CompOp   @.comp-ops   is required;
}

our class Python3::NotTest does Python3::ITest  {
    has Int $.not-count is required;
    has Python3::Comparison $.comparison is required;
}

our class Python3::AndTest does Python3::ITest  {
    has Python3::NotTest @.operands is required;
    has Python3::Comment @.comments;
}

our class Python3::OrTest 
does Python3::ITest 
does Python3::ITestNoCond
 {
    has Python3::AndTest @.operands is required;
    has Python3::Comment @.comments;
}

our class Python3::BasicTest does Python3::ITest  {
    has Python3::OrTest $.or-test is required;
}


#-----------------------------
our role Python3::CompIter  { }

our class Python3::CompIf does Python3::CompIter  {
    has Python3::ITestNoCond $.test-nocond is required;
    has Python3::CompIter   $.comp-iter;
}

our class Python3::CompFor does Python3::CompIter  {
    has Python3::ExprList $.exprlist is required;
    has Python3::OrTest   $.or-test  is required;
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

our class Python3::ArgList does Python3::ITrailer  {
    has $.basic-args;
    has $.star-args;
    has $.kwargs;
}

our class Python3::ImportDots  {
    has Bool $.plural is required;
}

our class Python3::DottedName  {
    has Str @.names is required;
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
}

our class Python3::ExprAugAssign does Python3::ISmallStmt  {
    has $.lhs is required;
    has $.op  is required;
    has $.rhs is required;
}

our class Python3::Return does Python3::ISmallStmt  {
    has Python3::TestList $.testlist;
}

our class Python3::RaiseClause does Python3::ISmallStmt  {
    has Python3::ITest $.test is required;
    has $.from;
}

our class Python3::Raise does Python3::ISmallStmt  {
    has Python3::RaiseClause $.clause;
}

our class Python3::ImportName does Python3::ISmallStmt  {
    has Python3::DottedAsName @.names is required;
}

our class Python3::Nonlocal does Python3::ISmallStmt  {
    has Str @.names is required;
}

our class Python3::Assert does Python3::ISmallStmt  {
    has @.tests is required;
}

our class Python3::Pass     does Python3::ISmallStmt  { }

our class Python3::Break    does Python3::ISmallStmt  { }

our class Python3::Continue does Python3::ISmallStmt  { }

our class Python3::Yield does Python3::ISmallStmt  {
    has Python3::YieldExpr $.expr is required;
}

our class Python3::ImportFrom does Python3::ISmallStmt  {
    has Python3::ImportFromSrc    $.src    is required;
    has Python3::ImportFromTarget $.target is required;
}

our class Python3::Global does Python3::ISmallStmt  {
    has Str @.names is required;
}

our class Python3::Del does Python3::ISmallStmt  {
    has @.exprs is required;
}

#---------------------------------------
our role Python3::Suite  { }

our class Python3::SimpleSuite does Python3::Suite does Python3::IStmt  {
    has Python3::ISmallStmt @.stmts is required;
    has Python3::Comment    $.comment;
}

our class Python3::StmtWithComments does Python3::IStmt  {
    has Python3::IStmt   $.stmt is required;
    has Python3::Comment @.comments is required;
}

our class Python3::StmtSuite does Python3::Suite  {
    has Python3::StmtWithComments @.stmts is required;
}

#---------------------------------------
our class Python3::Classdef 
does Python3::ICompoundStmt
does Python3::IDecoratedItem  {
    has Python3::Name    $.name is required;
    has Python3::Suite   $.suite is required;
    has Python3::ArgList $.args;
    has Python3::Comment $.comment;
}

our class Python3::TypedArgList  {
    has $.basic-args;
    has $.star-args;
    has $.kw-args;
}

our class Python3::Funcdef 
does Python3::ICompoundStmt 
does Python3::IDecoratedItem  {
    has Python3::Name  $.name is required;
    has Bool           $.private is required;
    has Bool           $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required;
    has Python3::ITest $.test;
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
our role Python3::TryControlSuite  {}

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
our role Python3::WithItem  { }

our class Python3::WithItemBasic does Python3::WithItem  { 
    has Python3::ITest $.test is required;
}

our class Python3::WithItemAs    does Python3::WithItem  { 
    has Python3::ITest  $.test is required;
    has Python3::IOrExpr $.or-expr is required;
}

our class Python3::With does Python3::ICompoundStmt  {
    has Python3::Comment  @.comments;
    has Python3::Suite    $.suite is required;
    has Python3::WithItem @.with-items is required;
}

our class Python3::Tfpdef  {
    has Python3::Name  $.name is required;
    has Python3::ITest $.test ;
}

our class Python3::AugmentedTfpdef  {
    has Python3::Tfpdef  $.tfpdef is required;
    has Python3::ITest   $.test ;
    has Python3::Comment @.comments;
}
