crate::ix!();

pub fn maybe_fix_errors_in_index_expr(
    db:   &RootDatabase, 
    expr: &ast::IndexExpr) -> Option<ast::Expr> {
    None
}
