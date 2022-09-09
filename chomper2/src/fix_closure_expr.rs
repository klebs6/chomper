crate::ix!();

pub fn maybe_fix_errors_in_closure_expr(
    db:   &RootDatabase, 
    expr: &ast::ClosureExpr) -> Option<ast::Expr> {
    None
}
