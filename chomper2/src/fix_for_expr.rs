crate::ix!();

pub fn maybe_fix_errors_in_for_expr(
    db:   &RootDatabase, 
    expr: &ast::ForExpr) -> Option<ast::Expr> {
    None
}
