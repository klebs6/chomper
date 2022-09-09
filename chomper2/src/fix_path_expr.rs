crate::ix!();

pub fn maybe_fix_errors_in_path_expr(
    db:   &RootDatabase, 
    expr: &ast::PathExpr) -> Option<ast::Expr> {
    None
}
