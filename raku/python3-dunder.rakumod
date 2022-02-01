use python3-func;

#same members as FuncDef
our role Python3::IDunderFunc 
does Python3::ICompoundStmt 
does Python3::IFuncDef
{
    has Python3::Name  $.name is required;
    has Bool           $.private is required;
    has Bool           $.is-test is required;

    has Python3::TypedArgList 
        $.parameters is required;

    has Python3::Suite $.suite is required;
    has Python3::ITest $.test;

    method translate-special-function-to-rust { ... }
}


our class Python3::DunderFunc::Repr does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Add  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Sub  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Mul  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our class Python3::DunderFunc::Div  does Python3::IDunderFunc {
    method translate-special-function-to-rust($cls-name) { ... }
}

our sub toplevel-dunder-functions(Python3::StmtSuite $suite) {
    $suite.stmts.List.grep({ $_.stmt ~~ Python3::IDunderFunc }).map: { $_.stmt }
}
