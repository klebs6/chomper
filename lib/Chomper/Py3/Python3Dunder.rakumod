use Chomper::Py3::Python3Func;
use Chomper::Py3::Python3Suite;
use Chomper::Py3::Python3Comment;
use Chomper::WrapBodyTodo;

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

    has Python3::Suite $.suite is required is rw;
    has Python3::ITest $.test;

    has $.comment        = extract-rust-comment-from-suite($!suite);
    has $.parsed-comment = parse-python-doc-comment($!comment);

    has $.param-typemap  = $!parsed-comment ~~ PythonDocComment 
    ?? $!parsed-comment.extract-param-typemap()
    !! {};

    has $.rust-comment   = as-rust-comment($!parsed-comment,backup => $!comment) // "";
    has $.optional-initializers = $!parameters.optional-initializers(typemap => $!param-typemap);

    method translate-special-function-to-rust { ... }
}

our class Python3::DunderFunc::Abs           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Add           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::And           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Call          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Cmp           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Coerce        does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Complex       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Contains      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Del           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Delattr       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Delete        does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Delitem       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Delslice      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Div           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Divmod        does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Enter         does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Eq            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Exit          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Float         does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Floordiv      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ge            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Get           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Getattr       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Getattribute  does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Getitem       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Getslice      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Gt            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Hash          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Hex           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Iadd          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Iand          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Idiv          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Idivmod       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ifloordiv     does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ilshift       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Imod          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Imul          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Index         does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Instancecheck does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Int           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Invert        does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ior           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ipow          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Irshift       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Isub          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Iter          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Itruediv      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ixor          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Le            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Len           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Long          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Lshift        does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Lt            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Metaclass     does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Missing       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Mod           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Mul           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ne            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Neg           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Nonzero       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Oct           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Or            does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Pos           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Pow           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Radd          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rand          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rcmp          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rdiv          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rdivmod       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Repr          does Python3::IDunderFunc { 
    method translate-special-function-to-rust($cls-name) {  
        qq:to/END/
        impl fmt::Debug for $cls-name \{
            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result \{

        {$.optional-initializers.indent(8)}

                {wrap-body-todo($.suite.text)}
            \}
        \}

        END
    } 
}

our class Python3::DunderFunc::Reversed      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rfloordiv     does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rlshift       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rmod          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rmul          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Ror           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rpow          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rrshift       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rshift        does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rsub          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rtruediv      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Rxor          does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Set           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Setattr       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Setitem       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Setslice      does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Str           does Python3::IDunderFunc { 
    method translate-special-function-to-rust($cls-name) {  
        qq:to/END/
        impl fmt::Display for $cls-name \{
            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result \{

        {$.optional-initializers.indent(8)}

                {wrap-body-todo($.suite.text)}
            \}
        \}

        END
    } 
}

our class Python3::DunderFunc::Sub           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Subclasscheck does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Truediv       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Unicode       does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }
our class Python3::DunderFunc::Xor           does Python3::IDunderFunc { method translate-special-function-to-rust($cls-name) { ... } }

our sub toplevel-dunder-functions(Python3::StmtSuite $suite) {
    $suite.stmts.List.grep({ $_.stmt ~~ Python3::IDunderFunc }).map: { $_.stmt }
}
