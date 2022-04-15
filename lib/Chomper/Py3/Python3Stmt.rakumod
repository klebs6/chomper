use Chomper::Py3::Python3Prelude;

our role Python3::ISmallStmt
does Python3::IStmt { }

our class Python3::StmtWithComments 
does Python3::IStmt  {
    has Python3::IStmt   $.stmt is required;
    has Python3::Comment @.comments;
    has Str $.text is required;
}

our class Python3::ExprEquals does Python3::ISmallStmt  {
    has $.lhs       is required;
    has @.rhs-stack is required;
    has Str $.text is required;

    method is-assign-to-self( --> Bool ) {
        self.lhs.operands[0]
    }

    method doc-comment-text( --> Str ) {
        $.lhs.operands[0].items.join("\n")
    }

    method is-doc-comment( --> Bool ) {
        my Bool $only-lhs    = so self.rhs-stack;
        my Bool $one-lhs-op  = self.lhs.operands.elems eq 1;
        if self.lhs ~~ Python3::IOrExpr {
            my $op0 = self.lhs.operands[0];
            my Bool $lhs-is-strs = $op0 ~~ Python3::Strings;
            so [
                $only-lhs,
                $one-lhs-op,
                $lhs-is-strs,
            ].all
        } else {
            False
        }
    }
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

our class Python3::DottedAsName  {
    has     $.name is required;
    has Str $.as;
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

#----------------------------------
our class Python3::YieldArg  { 
    has $.from;
    has $.testlist;
}

our class Python3::YieldExpr does Python3::IParensInner  {
    has Python3::YieldArg $.arg;
}

our class Python3::Yield does Python3::ISmallStmt  {
    has Python3::YieldExpr $.expr is required;
    has Str $.text is required;
}

#----------------------------------
our class Python3::ImportDots  {
    has Bool $.plural is required;
}

our class Python3::ImportFromSrc  {
    has Python3::ImportDots @.dot-stack;
    has Python3::DottedName $.name;
}

our class Python3::ImportAsName  {
    has Python3::Name $.name is required;
    has Python3::Name $.as;
}

our class Python3::ImportFromTarget  {
    has Bool $.glob is required;
    has Python3::Comment      $.comment;
    has Python3::ImportAsName @.names;
}

our class Python3::ImportFrom does Python3::ISmallStmt  {
    has Python3::ImportFromSrc    $.src    is required;
    has Python3::ImportFromTarget $.target is required;
    has Str $.text is required;
}

#----------------------------------
our class Python3::Global does Python3::ISmallStmt  {
    has Str @.names is required;
    has Str $.text is required;
}

our class Python3::Del does Python3::ISmallStmt  {
    has @.exprs is required;
    has Str $.text is required;
}
