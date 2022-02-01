use python3-prelude;

our role Python3::ShiftOperand    
{ }

our role Python3::IArithOperand   
{ }

our role Python3::ITermOperand    
{ }

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
    has Int              $.stars is required;
    has Python3::IOrExpr $.or-expr  is required;
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
