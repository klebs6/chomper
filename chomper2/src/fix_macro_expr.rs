crate::ix!();

pub fn maybe_fix_errors_in_macro_expr(
    db:   &RootDatabase, 
    expr: &ast::MacroExpr) -> Option<ast::Expr> {
    None
}
