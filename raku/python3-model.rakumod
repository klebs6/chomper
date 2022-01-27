our role Python3::Test {}
our role Python3::Atom {}
our role Python3::DecoratedItem {}
our role Python3::PlusMinusTerm {}
our role Python3::DictOrSet {}
our role Python3::ParensInner {}
our role Python3::ListMaker does Python3::ParensInner {}

our class Python3::ParensAtom does Python3::Atom {
    has Python3::ParensInner $.value is required;
    has Python3::Comment   @.comments;
}

our class Python3::TestList does Python3::ListMaker {
    has Python3::Test @.tests;
}

our class Python3::MaybeCommentedTest does Python3::Test {
    has Python3::Test    $.test is required;
    has Python3::Comment $.comment;
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

our class Python3::Dict      does Python3::DictOrSet {
    has Python3::DictMakerItem @.items;
}

our class Python3::DictMakerItem {
    has Python3::Comment $.comments;
    has Python3::Test    $.K is required;
    has Python3::Test    $.V is required;
}

our class Python3::SetmakerItem {
    has Python3::Comment $.comments;
    has Python3::Test    $.K         is required;
    has Bool             $.has-stars is required;
}

our class Python3::DictComp  does Python3::DictOrSet {
    has Python3::DictMakerItem $.item is required;
    has Python3::CompFor       $.comp is required;
}

our class Python3::SetComp  does Python3::DictOrSet {
    has Python3::SetmakerItem $.item is required;
    has Python3::CompFor      $.comp is required;
}

our class Python3::Set       does Python3::DictOrSet {

}

our class Python3::Strings   does Python3::Atom { has Str @.items is required; }
our class Python3::Name      does Python3::Atom { has Str $.value is required; }
our class Python3::Ellipsis  does Python3::Atom {}
our class Python3::False     does Python3::Atom {}
our class Python3::True      does Python3::Atom {}
our class Python3::None      does Python3::Atom {}
our class Python3::Integer   does Python3::Atom { has Int     $.value is required; }
our class Python3::Float     does Python3::Atom { has Num     $.value is required; }
our class Python3::Imaginary does Python3::Atom { has Complex $.value is required; }

our class Python3::AugmentedAtom {
    has Python3::Atom    $.atom is required;
    has Python3::Trailer @.trailers is required;
}

our class Python3::Power {
    has Python3::AugmentedAtom $.augmented-atom is required;
    has Python3::Factor        @.factor-stack is required;
}

our class Python3::TermDelimitedFactor {
    has Python3::Comment   @.comments is required;
    has Python3::TermDelim $.delim    is required;
    has Python3::Factor    $.factor   is required;

}

our class Python3::Factor {
    has Python3::FactorDelim $.delim-stack is required;
    has Python3::Power       $.power is required;
}

our class Python3::Term {
    has Python3::Factor              $.base  is required;
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


our class Python3::BasicTest does Python3::Test {
    has Python3::OrTest $.or-test is required;
}

our class Python3::OrTest does Python3::Test {
    has Python3::AndTest  @.operands is requried;
    has Python3::Comments @.comments;
}

our class Python3::AndTest does Python3::Test {
    has Python3::NotTest  @.operands is requried;
    has Python3::Comments @.comments;
}

our class Python3::NotTest does Python3::Test {
    has Int $.not-count is required;
    has Python3::Comparison $.comparison is required;
}

our class Python3::ArithExpr {
    has Python3::Term          $.lhs is requried;
    has Python3::PlusMinusTerm @.stack is requried;
}

our class Python3::ShiftExpr {
    has Python3::ArithExpr      $.lhs is requried;
    has Python3::ShiftArithExpr @.stack is requried;
}

our class Python3::AndExpr {
    has Python3::ShiftExpr @.operands is requried;
}

our class Python3::XorExpr {
    has Python3::AndExpr @.operands is requried;
}

our class Python3::Expr {
    has Python3::XorExpr @.operands is requried;
}

our class Python3::StarExpr {
    has Bool          $.has-star is required;
    has Python3::Expr $.expr     is required;
}

our class Python3::CompOp {
    has Str $.op is required;
}

our class Python3::Comparison does Python3::Test {
    has Python3::StarExpr @.star-exprs is required;
    has Python3::CompOp   @.comp-ops   is requried;
}


our class Python3::Lambdef does Python3::Test {
#TODO

}

our class Python3::TernaryOperator does Python3::Test {
    has $.A    is required;
    has $.cond is required;
    has $.B    is required;
}

our class Python3::Arglist {
    has $.basic-args;
    has $.star-args;
    has $.kwargs;
}

our class Python3::Comment {
    has Str $.text is required;
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

our class Python3::Stmt::ExprEquals does Python3::SmallStmt {
    has $.lhs       is required;
    has @.rhs-stack is required;
}

our class Python3::Stmt::ExprAugAssign does Python3::SmallStmt {
    has $.lhs is required;
    has $.op  is required;
    has $.rhs is required;
}

our class Python3::Stmt::Return does Python3::SmallStmt {
    has $.testlist;
}

our class Python3::RaiseClause does Python3::SmallStmt {
    has Python3::Test $.test is required;
    has $.from;
}

our class Python3::Stmt::Raise does Python3::SmallStmt {
    has Python3::RaiseClause $.clause;
}

our class Python3::Stmt::ImportName does Python3::SmallStmt {
    has Python3::DottedAsName @.names is required;
}

our class Python3::Stmt::Nonlocal does Python3::SmallStmt {
    has Str @.names is required;
}

our class Python3::Stmt::Assert does Python3::SmallStmt {
    has @.tests is required;
}

our class Python3::Stmt::Pass     does Python3::SmallStmt { }

our class Python3::Stmt::Break    does Python3::SmallStmt { }

our class Python3::Stmt::Continue does Python3::SmallStmt { }

our class Python3::Stmt::Yield does Python3::SmallStmt {
    has Python3::YieldExpr $.expr is required;
}

our class Python3::Stmt::ImportFrom does Python3::SmallStmt {
    has Python3::ImportFromSrc    $.src    is required;
    has Python3::ImportFromTarget $.target is required;
}

our class Python3::Stmt::Global does Python3::SmallStmt {
    has Str @.names is required;
}

our class Python3::Stmt::Del does Python3::SmallStmt {
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
    has Str $.name is required;
    has Python3::Suite   $.suite is required;
    has Python3::Arglist $.args;
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
    has Str  $.name    is required;
    has Bool $.private is required;
    has Bool $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required;
    has Python3::Test  $.test;
}

#---------------------------------
our class Python3::Stmt::Elif does Python3::Stmt {
    has Python3::Comment @.comments;
    has Python3::Test    $.test is required;
    has Python3::Suite   $.suite is required;
}

our class Python3::Stmt::Else does Python3::Stmt {
    has @.comments;
    has Python3::Suite   $.suite is required;
}

our class Python3::Stmt::If does Python3::Stmt {
    has Python3::Comment    $.comment;
    has Python3::Test       $.test  is required;
    has Python3::Suite      $.suite is required;
    has Python3::Stmt::Elif @.elif-suites;
    has Python3::Stmt::Else $.else-suite;
}

our class Python3::Decorator {
    has Python3::DottedName $.name is required;
    has Python3::Comment    $.comment;
    has Python3::Arglist    $.arglist;
}

our class Python3::Decorated does Python3::CompoundStmt {
    has Python3::Decorator     @.decorators is required;
    has Python3::DecoratedItem $.decorated  is required;
}

our class Python3::Stmt::For does Python3::Stmt {
    #TODO

}
