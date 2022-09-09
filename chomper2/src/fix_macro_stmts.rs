crate::ix!();

pub fn maybe_fix_errors_in_macro_stmts(
    db:   &RootDatabase, 
    expr: &ast::MacroStmts) -> Option<ast::Expr> {
    None
}
