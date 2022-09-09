crate::ix!();

pub fn maybe_fix_errors_in_continue_expr(
    db:   &RootDatabase, 
    expr: &ast::ContinueExpr) -> Option<ast::Expr> {
    None
}
