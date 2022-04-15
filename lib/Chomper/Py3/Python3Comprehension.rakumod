use Chomper::Py3::Python3Prelude;
use Chomper::Py3::Python3Expr;

our role Python3::CompIter        
{ }

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

our class Python3::ListComp does Python3::IListMaker  {
    has Python3::ITest   $.test is required;
    has Python3::CompFor $.comp is required;
}

our class Python3::DictComp  does Python3::IDictOrSet  {
    has Python3::DictMakerItem $.item is required;
    has Python3::CompFor       $.comp is required;
}

our class Python3::SetComp  does Python3::IDictOrSet  {
    has Python3::SetMakerItem $.item is required;
    has Python3::CompFor      $.comp is required;
}
