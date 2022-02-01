use python3-prelude;
use python3-varargs;

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
