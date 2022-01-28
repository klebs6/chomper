our role Python3::Subscript { }
our role Python3::TestOrStarExpr { }

our role Python3::Test 
does Python3::Subscript 
does Python3::TestOrStarExpr
{}

our role Python3::TestNoCond {}
our role Python3::Atom {}
our role Python3::DecoratedItem {}
our role Python3::PlusMinusTerm {}
our role Python3::DictOrSet {}
our role Python3::ParensInner {}
our role Python3::ListMaker does Python3::ParensInner {}

#-----------------------------
our class Python3::Comment {
    has Str $.text is required;
}

our class Python3::Strings   does Python3::Atom { has Str @.items is required; }
our class Python3::Name      does Python3::Atom { has Str $.value is required; }
our class Python3::Ellipsis  does Python3::Atom {}
our class Python3::False     does Python3::Atom {}
our class Python3::True      does Python3::Atom {}
our class Python3::None      does Python3::Atom {}
our class Python3::Integer   does Python3::Atom { has Str $.value is required; }
our class Python3::Float     does Python3::Atom { has Str $.value is required; }
our class Python3::Imaginary does Python3::Atom { has Str $.value is required; }

#-----------------------------
our role Python3::Trailer { }

our class Python3::DotName does Python3::Trailer {
    has Python3::Name $.name is required;
}

our class Python3::SliceOp {
    has Python3::Test $.test;
}

our class Python3::Slice does Python3::Subscript {
    has Python3::Test    $.test0;
    has Python3::Test    $.test1;
    has Python3::SliceOp $.slice-op;
}

our class Python3::SubscriptList does Python3::Trailer {
    has Python3::Subscript @.items;
}

#-----------------------------

our class Python3::AugmentedAtom {
    has Python3::Atom    $.atom is required;
    has Python3::Trailer @.trailers is required;
}

our role Python3::Factor {}

our class Python3::Power {
    has Python3::AugmentedAtom $.base is required;
    has Python3::Factor        $.power;
}

our class Python3::FactorDelim { has Str $.value is required; }
our class Python3::TermDelim   { has Str $.value is required; }

our class Python3::BaseFactor does Python3::Factor {
    has Python3::FactorDelim @.delim-stack is required;
    has Python3::Power       $.power is required;
}

our class Python3::TermDelimitedFactor {
    has Python3::Comment   @.comments is required;
    has Python3::TermDelim $.delim    is required;
    has Python3::BaseFactor    $.factor   is required;
}

our class Python3::Term {
    has Python3::BaseFactor              $.base  is required;
    has Python3::TermDelimitedFactor @.stack is required;
}

our class Python3::PlusTerm does Python3::PlusMinusTerm {
    has Python3::Term    $.term is required;
    has Python3::Comment @.comments is required;
}

our class Python3::MinusTerm does Python3::PlusMinusTerm {
    has Python3::Term    $.term is required;
    has Python3::Comment @.comments is required;
}

our class Python3::ArithExpr {
    has Python3::Term          $.lhs is required;
    has Python3::PlusMinusTerm @.stack is required;
}

our role Python3::ShiftArithExpr { }

our class Python3::LeftShiftExpr 
does Python3::ShiftArithExpr {
    has Python3::ArithExpr $.arith-expr is required;
}

our class Python3::RightShiftExpr 
does Python3::ShiftArithExpr {
    has Python3::ArithExpr $.arith-expr is required;
}

our class Python3::ShiftExpr {
    has Python3::ArithExpr      $.lhs is required;
    has Python3::ShiftArithExpr @.stack is required;
}

our class Python3::AndExpr {
    has Python3::ShiftExpr @.operands is required;
}

our class Python3::XorExpr {
    has Python3::AndExpr @.operands is required;
}

our class Python3::Expr {
    has Python3::XorExpr @.operands is required;
}

our class Python3::StarExpr does Python3::TestOrStarExpr {
    has Bool          $.has-star is required;
    has Python3::Expr $.expr     is required;
}

our class Python3::TestListStarExpr {
    has Python3::TestOrStarExpr @.test-or-star-exprs is required;
}

our class Python3::ExprList {
    has Python3::StarExpr @.items is required;
}

our class Python3::CompOp {
    has Str $.op is required;
}

our class Python3::Comparison does Python3::Test {
    has Python3::StarExpr @.star-exprs is required;
    has Python3::CompOp   @.comp-ops   is required;
}

our class Python3::NotTest does Python3::Test {
    has Int $.not-count is required;
    has Python3::Comparison $.comparison is required;
}

our class Python3::AndTest does Python3::Test {
    has Python3::NotTest  @.operands is required;
    has Python3::Comment @.comments;
}

our class Python3::OrTest 
does Python3::Test 
does Python3::TestNoCond
{
    has Python3::AndTest  @.operands is required;
    has Python3::Comment @.comments;
}

our class Python3::BasicTest does Python3::Test {
    has Python3::OrTest $.or-test is required;
}


#-----------------------------
our role Python3::CompIter { }

our class Python3::CompIf does Python3::CompIter {
    has Python3::TestNoCond $.test-nocond is required;
    has Python3::CompIter   $.comp-iter;
}

our class Python3::CompFor does Python3::CompIter {
    has Python3::ExprList $.exprlist is required;
    has Python3::OrTest   $.or-test  is required;
    has Python3::CompIter $.comp-iter;
}

#----------------------------
our class Python3::ParensAtom does Python3::Atom {
    has Python3::ParensInner $.value is required;
    has Python3::Comment   @.comments;
}

our class Python3::TestList does Python3::ListMaker {
    has Python3::Test @.tests;
}

our class Python3::MaybeCommentedTest does Python3::Test {
    has Python3::Test    $.test is required;
    has Python3::Comment @.comment;
}

our class Python3::ListComp does Python3::ListMaker {
    has Python3::Test    $.test is required;
    has Python3::CompFor $.comp is required;
}

our class Python3::ListAtom does Python3::Atom {
    has Python3::ListMaker $.value is required;
    has Python3::Comment   @.comments;
}

our class Python3::DictAtom does Python3::Atom {
    has Python3::DictOrSet $.value is required;
    has Python3::Comment   @.comments;
}

our class Python3::DictMakerItem {
    has Python3::Comment $.comments;
    has Python3::Test    $.K is required;
    has Python3::Test    $.V is required;
}

our class Python3::Dict      does Python3::DictOrSet {
    has Python3::DictMakerItem @.items;
}

our class Python3::SetMakerItem {
    has Python3::Comment $.comments;
    has Python3::Test    $.K         is required;
    has Bool             $.has-stars is required;
}

our class Python3::DictComp  does Python3::DictOrSet {
    has Python3::DictMakerItem $.item is required;
    has Python3::CompFor       $.comp is required;
}

our class Python3::SetComp  does Python3::DictOrSet {
    has Python3::SetMakerItem $.item is required;
    has Python3::CompFor      $.comp is required;
}

our class Python3::Set       does Python3::DictOrSet {

}

#----------------------------

our class Python3::VfpDef {
    has Python3::Name $.name is required;
    has Python3::Test $.test;
}

our class Python3::VarArgsList {
    has Python3::VfpDef @.basic-args;
    has Python3::VfpDef @.star-args;
    has Python3::VfpDef @.kwargs;
}

our class Python3::Lambdef does Python3::Test {
    has Python3::Test        $.test       is required;
    has Python3::VarArgsList $.varargslist;
}

our class Python3::LambdefNoCond 
does Python3::Test 
does Python3::TestNoCond {
    has Python3::TestNoCond  $.test-nocond is required;
    has Python3::VarArgsList $.varargslist;
}

our class Python3::TernaryOperator does Python3::Test {
    has $.A    is required;
    has $.cond is required;
    has $.B    is required;
}

our class Python3::ArgList does Python3::Trailer {
    has $.basic-args;
    has $.star-args;
    has $.kwargs;
}

our class Python3::ImportDots {
    has Bool $.plural is required;
}

our class Python3::DottedName {
    has Str @.names is required;
}

our class Python3::DottedAsName {
    has $.name is required;
    has Str $.as;
}

our class Python3::ImportFromSrc {
    has Python3::ImportDots @.dot-stack;
    has Python3::DottedName $.name;
}

our class Python3::ImportAsName {
    has Str $.name is required;
    has Str $.as;
}

our class Python3::ImportFromTarget {
    has Bool $.glob is required;
    has Python3::Comment $.comment;
    has Python3::ImportAsName @.names;
}

our class Python3::YieldArg { 
    has $.from;
    has $.testlist;
}

our class Python3::YieldExpr does Python3::ParensInner {
    has Python3::YieldArg $.arg;
}

#------------------------------------
our role Python3::Stmt { }
our role Python3::SmallStmt    does Python3::Stmt { }
our role Python3::CompoundStmt does Python3::Stmt { }

our class Python3::ExprEquals does Python3::SmallStmt {
    has $.lhs       is required;
    has @.rhs-stack is required;
}

our class Python3::ExprAugAssign does Python3::SmallStmt {
    has $.lhs is required;
    has $.op  is required;
    has $.rhs is required;
}

our class Python3::Return does Python3::SmallStmt {
    has Python3::TestList $.testlist;
}

our class Python3::RaiseClause does Python3::SmallStmt {
    has Python3::Test $.test is required;
    has $.from;
}

our class Python3::Raise does Python3::SmallStmt {
    has Python3::RaiseClause $.clause;
}

our class Python3::ImportName does Python3::SmallStmt {
    has Python3::DottedAsName @.names is required;
}

our class Python3::Nonlocal does Python3::SmallStmt {
    has Str @.names is required;
}

our class Python3::Assert does Python3::SmallStmt {
    has @.tests is required;
}

our class Python3::Pass     does Python3::SmallStmt { }

our class Python3::Break    does Python3::SmallStmt { }

our class Python3::Continue does Python3::SmallStmt { }

our class Python3::Yield does Python3::SmallStmt {
    has Python3::YieldExpr $.expr is required;
}

our class Python3::ImportFrom does Python3::SmallStmt {
    has Python3::ImportFromSrc    $.src    is required;
    has Python3::ImportFromTarget $.target is required;
}

our class Python3::Global does Python3::SmallStmt {
    has Str @.names is required;
}

our class Python3::Del does Python3::SmallStmt {
    has @.exprs is required;
}

#---------------------------------------
our role Python3::Suite { }

our class Python3::SimpleSuite does Python3::Suite does Python3::Stmt {
    has Python3::SmallStmt @.stmts is required;
    has Python3::Comment   $.comment;
}

our class Python3::StmtWithComments does Python3::Stmt {
    has Python3::Stmt    $.stmt is required;
    has Python3::Comment @.comments is required;
}

our class Python3::StmtSuite does Python3::Suite {
    has Python3::StmtWithComments @.stmts is required;
}

#---------------------------------------
our class Python3::Classdef 
does Python3::CompoundStmt
does Python3::DecoratedItem {
    has Python3::Name    $.name is required;
    has Python3::Suite   $.suite is required;
    has Python3::ArgList $.args;
    has Python3::Comment $.comment;
}

our class Python3::TypedArgList {
    has $.basic-args;
    has $.star-args;
    has $.kw-args;
}

our class Python3::Funcdef 
does Python3::CompoundStmt 
does Python3::DecoratedItem {
    has Python3::Name  $.name is required;
    has Bool $.private is required;
    has Bool $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required;
    has Python3::Test  $.test;
}

#---------------------------------
our class Python3::Elif {
    has Python3::Comment @.comments;
    has Python3::Test    $.test is required;
    has Python3::Suite   $.suite is required;
}

our class Python3::Else {
    has @.comments;
    has Python3::Suite   $.suite is required;
}

our class Python3::If does Python3::CompoundStmt {
    has Python3::Comment    $.comment;
    has Python3::Test       $.test  is required;
    has Python3::Suite      $.suite is required;
    has Python3::Elif @.elif-suites;
    has Python3::Else $.else-suite;
}

our class Python3::Decorator {
    has Python3::DottedName $.name is required;
    has Python3::Comment    $.comment;
    has Python3::ArgList    $.arglist;
}

our class Python3::Decorated does Python3::CompoundStmt {
    has Python3::Decorator     @.decorators is required;
    has Python3::DecoratedItem $.decorated  is required;
}

our class Python3::For does Python3::CompoundStmt {
    has Python3::ExprList   $.exprlist is required;
    has Python3::TestList   $.testlist is required;
    has Python3::Suite      $.suite    is required;
    has Python3::Comment    $.comment;
    has Python3::Else $.else;
}

our class Python3::While does Python3::CompoundStmt {
    has Python3::Test       $.test  is required;
    has Python3::Suite      $.suite is required;
    has Python3::Comment    @.comments;
    has Python3::Else $.else;
}

#-----------------------------
our role Python3::TryControlSuite {}

our class Python3::ExceptClause {
    has Python3::Comment @.comments;
    has Python3::Suite   $.suite is required;
}

our class Python3::Finally     does Python3::TryControlSuite {
    has Python3::Comment @.comments;
    has Python3::Suite   $.suite is required;
}

our class Python3::ExceptSuite does Python3::TryControlSuite {
    has Python3::Comment      @.comments;
    has Python3::ExceptClause @.clauses is required;
    has Python3::Else         $.else;
    has Python3::Finally      $.finally;
}

our class Python3::Try does Python3::CompoundStmt {
    has Python3::Comment         @.comments;
    has Python3::Suite           $.suite is required;
    has Python3::TryControlSuite $.control-suite  is required;
}

#-----------------------------
our role Python3::WithItem { }

our class Python3::WithItemBasic does Python3::WithItem { 
    has Python3::Test $.test is required;
}

our class Python3::WithItemAs    does Python3::WithItem { 
    has Python3::Test $.test is required;
    has Python3::Expr $.expr is required;
}

our class Python3::With does Python3::CompoundStmt {
    has Python3::Comment  @.comments;
    has Python3::Suite    $.suite is required;
    has Python3::WithItem @.with-items is required;
}

our class Python3::Tfpdef {
    has Python3::Name $.name is required;
    has Python3::Test $.test ;
}

our class Python3::AugmentedTfpdef {
    has Python3::Tfpdef $.tfpdef is required;
    has Python3::Test   $.test ;
    has Python3::Comment @.comments;
}
