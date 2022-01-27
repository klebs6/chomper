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

our class Python3::YieldExpr {
    has Python3::YieldArg $.arg;
}

#------------------------------------
our role Python3::Stmt { }
our role Python3::SmallStmt does Python3::Stmt { }

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
    has $.test is required;
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

our class Python3::StmtWithComments {
    has Python3::Stmt    $.stmt is required;
    has Python3::Comment @.comments is required;
}

our class Python3::StmtSuite does Python3::Suite {
    has Python3::StmtWithComments @.stmts is required;
}

#---------------------------------------
our class Python3::Classdef {
    has Str $.name is required;
    has Python3::Suite   $.suite is required;
    has Python3::Arglist $.args;
    has Python3::Comment $.comment;
}
