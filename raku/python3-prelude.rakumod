our class Python3::Comment  {
    has Str $.text is required;
}

#----------------------------------
our role Python3::ITrailer        
{ }

our role Python3::ISubscript      
{ }


#----------------------------------
our role Python3::ITestListStarExpr  {}

our role Python3::ITestOrStarExpr 
does Python3::ITestListStarExpr
{ }


#----------------------------------
our role Python3::ITest
does Python3::ISubscript
does Python3::ITestOrStarExpr { }

our class Python3::MaybeCommentedTest does Python3::ITest  {
    has Python3::ITest   $.test is required;
    has Python3::Comment @.comment;
}

our class Python3::TernaryOperator does Python3::ITest  {
    has $.A    is required;
    has $.cond is required;
    has $.B    is required;
}

our role Python3::ITestNoCond     
{ }


our class Python3::TestListStarExpr  
does Python3::ITestListStarExpr
{
    has Python3::ITestOrStarExpr @.test-or-star-exprs is required;
}


#----------------------------------
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

our class Python3::Strings   does Python3::IAtom  { has Str @.items is required; }
our class Python3::Name      does Python3::IAtom  { has Str $.value is required; }
our class Python3::Ellipsis  does Python3::IAtom  {}
our class Python3::False     does Python3::IAtom  { has Str $.value = "false" }
our class Python3::True      does Python3::IAtom  { has Str $.value = "true" }
our class Python3::None      does Python3::IAtom  { has Str $.value = "None" }
our class Python3::Integer   does Python3::IAtom  { has Str $.value is required; }
our class Python3::Float     does Python3::IAtom  { has Str $.value is required; }
our class Python3::Imaginary does Python3::IAtom  { has Str $.value is required; }

our class Python3::DotName does Python3::ITrailer  {
    has Python3::Name $.name is required;
}

our class Python3::DottedName  {
    has Python3::Name @.names is required;
}

#---------------------------------
our role Python3::IDictOrSet      
{ }

our role Python3::IParensInner    
{ }

our role Python3::IListMaker
does Python3::IParensInner { }

our class Python3::TestList does Python3::IListMaker  {
    has Python3::ITest @.tests;
}

our class Python3::ParensAtom does Python3::IAtom  {
    has Python3::IParensInner $.value is required;
    has Python3::Comment      @.comments;
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
    has Python3::Comment $.comment;
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

our class Python3::Set       does Python3::IDictOrSet  {

}

#-----------------------------
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
