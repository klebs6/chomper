use Chomper::Py3::Python3Stmt;
use Chomper::Py3::Python3Suite;
use Chomper::Py3::Python3Args;

our role Python3::ICompoundStmt
does Python3::IStmt { }

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
our role Python3::TryControlSuite 
{ }

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
our role Python3::WithItem        
{ }

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

