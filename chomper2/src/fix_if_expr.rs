crate::ix!();

pub fn maybe_fix_errors_in_if_expr(
    db:   &RootDatabase, 
    expr: &ast::IfExpr) -> Option<ast::Expr> {
    None
}
